from django.shortcuts import render, get_object_or_404
from plan.models import Parcial, EstadoMateria
from django.contrib.auth.models import User
from funciones.validaregistro import validacampo, usuarioexistente, validarpasswd
from django.contrib import auth
from django.contrib.auth.hashers import make_password

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
        libre = mat.filter(estado = 'LI')
        en_curso = mat.filter(estado = 'CU')
        aprobada = mat.filter(estado = 'RE')
        completa = mat.filter(estado = 'FI')
    else:
        libre = None
        en_curso = None
        aprobada = None
        completa = None
       
    return render(request, "plan/alumno.html", {"alumno" : alumno, "libre" : libre, "en_curso" : en_curso, "aprobada" : aprobada, "completa" : completa})

def materia(request, materia_nom):
    materia = get_object_or_404(Materia, nombre__iexact= materia_nom)
    return render(request, "plan/detallado.html", {"materia" : materia})

def parcial(request, id_parcial):
    parcial = get_object_or_404(Parcial, pk=id_parcial)
    return render(request, "plan/detallado.html", {"alumno" : parcial})
