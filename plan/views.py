from django.shortcuts import render, get_object_or_404
from plan.models import Alumno, Parcial, Materia

# Create your views here.

def index(request):
    lista_alumnos = Alumno.objects.all()
    lista_parciales = Parcial.objects.all()
    context = {"lista_alumnos" : lista_alumnos , "lista_parciales" : lista_parciales}
    return render(request, "plan/index.html", context)

def alumno(request, usuario):
    alumno = get_object_or_404(Alumno, nombre = usuario)
    return render(request, "plan/detallado.html", {"alumno" : alumno})


def materia(request, materia_nom):
    materia = get_object_or_404(Materia, nombre__iexact= materia_nom)
    return render(request, "plan/detallado.html", {"materia" : materia})

def parcial(request, id_parcial):
    parcial = get_object_or_404(Parcial, pk=id_parcial)
    return render(request, "plan/detallado.html", {"alumno" : parcial})
