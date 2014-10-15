from django.shortcuts import render, get_object_or_404
from plan.models import Parcial, Materia
from django.contrib.auth.models import User
from funciones.validaregistro import validacampo, usuarioexistente

# Create your views here.
def home(request):
    seleccion=request.GET.get('reg','')
    regerror=""
    if request.method == "POST":
        p=request.POST.get('passwd','')
        p2=request.POST.get('repasswd','')
        u=request.POST.get('user','')
        n=request.POST.get('name','')
        a=request.POST.get('lastname','')
        e=request.POST.get('email','')
        
        datos={"user":u,"passwd":p,"repasswd":p2,"name":n,"lastname":a,"email":e}
        regerror = validacampo(datos)
        if regerror == "":
            if usuarioexistente(u) == False:
                nuevoalumno=User(username=u, password=p, first_name=n, last_name=a, email= e)
                nuevoalumno.save()
            else:
                regerror="Usuario Existente"
        seleccion="1"

            
            
    return render(request, "plan/home.html",{"reg" : seleccion,"regerror":regerror})
                  
def index(request):
    lista_alumnos = User.objects.all()
    lista_parciales = Parcial.objects.all()
    context = {"lista_alumnos" : lista_alumnos , "lista_parciales" : lista_parciales}
    return render(request, "plan/index.html", context)

def alumno(request, usuario):
    alumno = get_object_or_404(User, nombre = usuario)
    return render(request, "plan/detallado.html", {"alumno" : alumno})


def materia(request, materia_nom):
    materia = get_object_or_404(Materia, nombre__iexact= materia_nom)
    return render(request, "plan/detallado.html", {"materia" : materia})

def parcial(request, id_parcial):
    parcial = get_object_or_404(Parcial, pk=id_parcial)
    return render(request, "plan/detallado.html", {"alumno" : parcial})
