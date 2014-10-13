from django.shortcuts import render, get_object_or_404
from plan.models import Parcial, Materia
from django.contrib.auth.models import User

# Create your views here.
def home(request):
    seleccion=request.GET.get('reg','')
    passinvalida=False
    if request.method == "POST":
        p=request.POST.get('passwd','')
        p2=request.POST.get('repasswd','')
        if p == p2:
            u=request.POST.get('user','')
            n=request.POST.get('name','')
            a=request.POST.get('lastname','')
            e=request.POST.get('email','')
            nuevoalumno=User(username=u, password=p, first_name=n, last_name=a, email= e)
            nuevoalumno.save()
        else:
            passinvalida=True
            
    return render(request, "plan/home.html",{"reg" : seleccion,"passinv":passinvalida})
                  
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
