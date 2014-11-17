from django.shortcuts import render, get_object_or_404, redirect
from plan.models import Parcial, EstadoMateria, Materia, Profesor
from django.contrib.auth.models import User
from funciones.validaregistro import validacampo, usuarioexistente, validarpasswd
from funciones.funcmaterias import estadoMateria, promedioMateria
from django.contrib import auth
from django.contrib.auth.hashers import make_password
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.decorators import login_required
from django.template.defaultfilters import slugify

# Create your views here.
def home(request):
    if request.user.is_authenticated():
        #PRUEBO SI MANTIENE LA SESION
        #yalogeado="1"
        #return render(request, "plan/detallado.html",{"yalogeado" : "1"} )
        #return alumno(request, request.user.username)
        return index(request)
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
                    return home(request)
                    #return render(request, "plan/detallado.html")
                else:
                    regerror="Password Invalida"
            else:
                regerror="El usuario no existe"


        #LOGEO
        
        
    return render(request, "plan/home.html",{"reg" : seleccion,"regerror":regerror})
                  
def index(request):
    #lista_alumnos = User.objects.all()
    #lista_parciales = Parcial.objects.all()
    #context = {"lista_alumnos" : lista_alumnos , "lista_parciales" : lista_parciales}
    alumno = User.objects.get(pk=request.user.id)
    tot = Materia.objects.count()
    if tot != 0:
    
        reg = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'RE').count()
        regperc = reg*100/tot
        com = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'FI').count() 
        comperc = com*100/tot
        cur = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'CU').count()
        curperc = cur*100/tot
    
    context = {
        "alumno" : alumno,
        "reg" : reg,
        "regperc" : regperc,
        "com" : com,
        "comperc" : comperc,
        "cur" : cur, 
        "curperc" : curperc,
        "tot" : tot
    }
    return render(request, "plan/index.html", context)

@login_required
def alumno(request):
    alumno = get_object_or_404(User, pk=request.user.id)
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
    
    
@login_required
def anotarse_materia(request):
    if request.method == 'POST':
        nombreMateria = request.POST.get('materia', '')
        try:
            existe = EstadoMateria.objects.get(materia__nombre__exact = nombreMateria, alumno__id = request.user.id)
            existe.estado = 'CU'
            existe.save()
            msg = "Se ha inscripto en la materia: "+nombreMateria+" , que la curse con exito!"
        except ObjectDoesNotExist:    
            try:
                estadonuevo = EstadoMateria( materia =  Materia.objects.get(nombre__exact = nombreMateria), alumno = User.objects.get(pk=request.user.id), estado = 'CU')
                msg = "Se ha inscripto en la materia: "+nombreMateria+" , que la curse con exito!"
                estadonuevo.save()
            except:
                msg = "No ha seleccionado ninguna materia, debe elejir una!!!"
        return render(request, "plan/anotarse_materia.html", {"msg" : msg})
    else:
        enabled = []
        disabled = []
        for l in Materia.objects.select_related().all():
            estado = estadoMateria(l, request.user)
            if estado == "disponible":
                enabled.append(l)
            elif estado == "deshabilitada":
                disabled.append(l)    
        context = {"enabled" : enabled, "disabled" : disabled}
        return render(request, "plan/anotarse_materia.html", context)


@login_required
def abandonar_materia(request):
    #TODO: Chequear si hay materias en curso (msg de error sino), mostrarlas, cambiar su estado de CU a LB
    if request.method == 'POST':
        nombreMateria = request.POST.get('materia', '')
        try:
            libre = EstadoMateria.objects.get(materia__nombre = nombreMateria, alumno_id = request.user.id)
            libre.estado = 'LB'
            libre.save()
            Parcial.objects.filter(materia__nombre = nombreMateria, alumno_id = request.user.id).delete()
            msg = "Ha quedado libre de "+nombreMateria+" suerte en el resto de la cursada."
        except ObjectDoesNotExist:
            msg = "usted debe seleccionar una materia para abandonar."
            
        return render(request, "plan/abandonar_materia.html", { "msg" : msg })
    else:
        mat = []
        for m in EstadoMateria.objects.filter(alumno_id = request.user.id, estado = 'CU'):
            mat.append(m.materia)
        context = { "materias" : mat }
        return render(request, "plan/abandonar_materia.html", context)

#No se usa esto
def parcial(request, id_parcial):
    parcial = get_object_or_404(Parcial, pk=id_parcial)
    return render(request, "plan/detallado.html", {"alumno" : parcial})
    
def ayuda(request):
    return render(request, "plan/ayuda.html")    

#TODO: Fijarse si hara falta hacer un flush, o algun otro paso mas??
def logout(request): 
    auth.logout(request)
    return render(request, "plan/logout.html")


#TODO: listar materias por anios

def lista_materias(request):
    primero = []
    segundo = []
    tercero = []
    cuarto = []
    quinto= []
    mat = { "PR" : primero, #aca deberia cambiar segun el modelo de Materia y tambien en lista_materias.html
            "SE" : segundo,
            "TE" : tercero,
            "CU" : cuarto,
            "QU" : quinto
        }
    for m in Materia.objects.select_related().all():
        mat[m.anio].append([m, promedioMateria(m, request.user)])
    context = { "materias" : mat }
    return render(request, "plan/lista_materias.html", context)
    
def arbol_materias(request):
    mat = {}
    if request.user.is_authenticated():
        css = { "cursando" : 'danger active', #lo que representa cada estado en css
                 "regularizada" : 'warning active', 
                 "completa" : 'success active', 
                 "disponible" : ' active'
                } 
        
        mat = {}
        for m in Materia.objects.select_related().all():
           estado = estadoMateria(m, request.user)  #retorna "desabilitada" "cursando", "regularizada", "completa", "disponible"
           if not(estado == "desabilitada"):
            mat[m.nombre.lower().replace(" ","")] = css[estado]
        
    context = { "materias" : mat }
    
    return render(request, "plan/arbolMaterias.html", context)      
      

def materia(request, nombre_materia):
    nombre_materia = nombre_materia.replace("-" ," ")
    materia = get_object_or_404(Materia, nombre__iexact = nombre_materia)
    profesor = materia.profesor.all() #Profesor.objects.filter(materia__nombre = nombre_materia)
    correlativas = materia.correlativas.all()
    context = {"mat": materia, "profesor" : profesor, "correlativas" : correlativas}
    if request.user.is_authenticated(): #datos solo disponibles a logged
        context["auth"] = True;
        if EstadoMateria.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id).exists():
            context["estado"] = EstadoMateria.objects.get(materia__nombre = materia.nombre, alumno_id = request.user.id).estado
        if Parcial.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id).exists():
            context["parciales"] = Parcial.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id)
    else: #datos disponibles solo a NO logged
        context["auth"] = False;
    return render(request, "plan/materiamodal.html", context)
