from django.shortcuts import render, get_object_or_404
from plan.models import Parcial, EstadoMateria, Materia
from django.contrib.auth.models import User
from funciones.validaregistro import validacampo, usuarioexistente, validarpasswd
from django.contrib import auth
from django.contrib.auth.hashers import make_password
from django.core.exceptions import ObjectDoesNotExist

# Create your views here.
def home(request):
    if request.user.is_authenticated():
        #PRUEBO SI MANTIENE LA SESION
        #yalogeado="1"
        #return render(request, "plan/detallado.html",{"yalogeado" : "1"} )
        return alumno(request, request.user.username)
    seleccion=request.GET.get('reg','')
    regerror=""
    if request.method == "POST":
        p=request.POST.get('passwd','')
        p2=request.POST.get('repasswd','')
        u=request.POST.get('user','')
        n=request.POST.get('name','')
        a=request.POST.get('lastname','')
        e=request.POST.get('email','')
        u2=request.POST.get('userlog','')
        pl=request.POST.get('passwdlog','')
        #Valida REGISTRO
        if u:
            datos={"user":u,"passwd":p,"repasswd":p2,"name":n,"lastname":a,"email":e}
            regerror = validacampo(datos)
            if regerror == "":
                if usuarioexistente(u) == False:
                    p = make_password(p)
                    nuevoalumno=User(username=u, password=p, first_name=n, last_name=a, email= e)
                    nuevoalumno.save()
                else:
                    regerror="Usuario Existente"
            seleccion="1"
        if u2:
            datos={"user":u2,"passwd":pl}
            seleccion="0"
            if usuarioexistente(u2):
                if validarpasswd(datos):
                    #Datos Validos, hacer logeo
                    usuario = auth.authenticate(username=u2,password=pl)
                    auth.login(request, usuario)
                    return alumno(request, usuario)
                    #return render(request, "plan/detallado.html")
                else:
                    regerror="Password Invalida"
            else:
                regerror="El usuario no existe"


        #LOGEO
        
        
    return render(request, "plan/home.html",{"reg" : seleccion,"regerror":regerror})
                  
def index(request):
    lista_alumnos = User.objects.all()
    lista_parciales = Parcial.objects.all()
    context = {"lista_alumnos" : lista_alumnos , "lista_parciales" : lista_parciales}
    return render(request, "plan/index.html", context)

def alumno(request, usuario):
    alumno = get_object_or_404(User, username = usuario)
    if EstadoMateria.objects.filter(alumno_id = alumno.id).exists():
        mat = EstadoMateria.objects.filter(alumno_id = alumno.id)
        libre = mat.filter(estado = 'LB')
        en_curso = mat.filter(estado = 'CU')
        aprobada = mat.filter(estado = 'RE')
        completa = mat.filter(estado = 'FI')
    else:
        libre = None
        en_curso = None
        aprobada = None
        completa = None
       
    return render(request, "plan/alumno.html", {"alumno" : alumno, "libre" : libre, "en_curso" : en_curso, "aprobada" : aprobada, "completa" : completa})

def anotarse_materia(request):
    if request.user.is_authenticated():
        if request.method == 'POST':
            nombreMateria = request.POST.get('materia', '')
            try:
                existe = EstadoMateria.objects.get(materia__nombre__exact = nombreMateria, alumno__id = request.user.id)
                existe.estado = 'CU'
                existe.save()
            except ObjectDoesNotExist:    
                try:
                    estadonuevo = EstadoMateria( materia =  Materia.objects.get(nombre__exact = nombreMateria), alumno = User.objects.get(pk=request.user.id), estado = 'CU')
                    msg = "Se ha inscripto en la materia: "+nombreMateria+" , que la curse con exito!"
                    estadonuevo.save()
                except:
                    msg = "No ha seleccionado ninguna materia, debe elejir una!!!"
            return render(request, "plan/anotarse_materia.html", {"msg" : msg})
        else: #usar .select_related() para minimizar overhead
            #libres =  Materia.objects.filter(estadomateria__estado = 'LB', estadomateria__alumno_id = request.user.id)
            #no_cursadas = Materia.objects.exclude(estadomateria__alumno_id__exact = request.user.id)
            enabled = []
            disabled = []
            n=0
            m=0
            for l in Materia.objects.select_related().all(): #TODO: Hacer funcional las busquedas (usar archivo .py con funciones)
                n=0 #nueva materia
                if not (l.correlativas.all().exists()): #si no tiene correlativas
                    if EstadoMateria.objects.filter(materia__nombre = l.nombre, alumno_id = request.user.id).exists(): #existe el algun estado
                        #estado = EstadoMateria.objects.get(materia__nombre = l.nombre, alumno_id = request.user.id)
                        if (EstadoMateria.objects.get(materia__nombre = l.nombre, alumno_id = request.user.id).estado == 'LB'):# Y ese estado es libre
                           enabled.append(l) #agrega 
                    else: #no tiene estado, no la curso (puede anotarse)
                        enabled.append(l)
                else: #si SI tiene correlativas
                    for c in l.correlativas.all():
                        m=0 #nueva correlativa
                        n+=1 #bandera de correlativa existente (la materia la tiene)
                        if not (EstadoMateria.objects.filter(materia__nombre = c.nombre, alumno_id = request.user.id).exists()): #si la correlativa no existe en Estado, no fue cursada
                            disabled.append(l)
                        else:
                            estado = EstadoMateria.objects.get(materia__nombre = c.nombre, alumno_id = request.user.id)
                            if (estado.estado == 'RE') or (estado.estado == 'FI'):
                                m+= 1 #bandera de correlativa aprobada
                        if (m==n):  
                            if EstadoMateria.objects.filter(materia__nombre = l.nombre, alumno_id = request.user.id).exists(): #existe el algun estado
                               #estado = EstadoMateria.objects.get(materia__nombre = l.nombre, alumno_id = request.user.id)
                               if (EstadoMateria.objects.get(materia__nombre = l.nombre, alumno_id = request.user.id).estado == 'LB'):# Y ese estado es libre
                                   enabled.append(l) #agrega 
                            else: #no tiene estado, no la curso (puede anotarse)
                              enabled.append(l)
                           #enabled.append(l)
#                for l in no_cursadas:
#                    n=0
#                    for c in l.correlativas.all():
#                        m=0
#                        estado = EstadoMateria.objects.get(materia__nombre = c.nombre, alumno_id = request.user.id)
#                        n+= 1
#                        if (estado.estado == 'RE') or (estado.estado == 'FI'):
#                            m+= 1
#                            if (m==n):
#                                enabled.append(l)   
            
            return render(request, "plan/anotarse_materia.html", {"enabled" : enabled, "disabled" : disabled})#"no_cursadas" : no_cursadas})
    else:
        return home(request)


def parcial(request, id_parcial):
    parcial = get_object_or_404(Parcial, pk=id_parcial)
    return render(request, "plan/detallado.html", {"alumno" : parcial})
