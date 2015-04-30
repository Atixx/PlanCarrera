################################################################################
##                   Funciones Materias                                       ##
## Autor: Maor Levy - 2014                                                    ##
##                                                                            ## 
##       Proyecto PlanCarrera - UNLa 2014 - Seminario de Lenguajes            ##
## funciones que asisten en manejo de la informacion del modelo de la materia ##
##                                                                            ##
################################################################################


from plan.models import EstadoMateria, Materia, Examen
from django.core.exceptions import ObjectDoesNotExist
import math


# La funcion recibe la materia a chequar y el usuario
# corrobora el estado de todas las correlatividades y retorna el estado de la materia segun el diccionario 'estados'
def estadoMateria(materia, usuario): 

    estados = { 'LB' : 'disponible',
                'CU' : 'cursando',
                'RE' : 'regularizada',
                'FI' : 'completa',
                'NO' : 'desabilitada'
                }
                
    if EstadoMateria.objects.filter(materia__nombre = materia.nombre, alumno_id = usuario.id).exists(): #Si tiene estado, agarrarlo
        estado = EstadoMateria.objects.get(materia__nombre = materia.nombre, alumno_id = usuario.id)
        return estados[estado.estado]
    else:
        if materia.correlativas.all().exists(): #si tiene correlativas
            lista = []
            for c in materia.correlativas.all():
                try:
                    estadoCorr = EstadoMateria.objects.get(materia__nombre = c.nombre, alumno_id = usuario.id).estado
                    if (estadoCorr == 'CU' or estadoCorr == 'LB'):
                        lista.append("no aprobado")
                    else:
                        lista.append("aprobado")
                except ObjectDoesNotExist:
                    lista.append("no aprobado")                      
            
            if not ("no aprobado" in lista): #correlativas aprobadas
                return estados['LB']
            else: #correlativas no aprobadas
                return estados['NO']     
        else: #no tiene correlativas, lo pongo disponible
            return estados['LB']
            
            
            
#funciones que reciben una materia y usuario
#TODO: retorna el promedio de cursada chequeando los examenes, en caso de no existir, retorna ???            
def promedioParciales(materia, usuario):
    if Examen.objects.filter(materia__nombre = materia.nombre, opcion = 'PA', alumno_id = usuario.id).exists():
        nota = 0
        cantidad = 0
        for e in Examen.objects.filter(materia__nombre = materia.nombre,opcion = 'PA', alumno_id = usuario.id):
            cantidad+= 1
            nota += e.nota
        return (nota/cantidad)
    else:
        return None

def promedioFinales(materia, usuario):      
    if Examen.objects.filter(materia__nombre = materia.nombre, opcion = 'FI', alumno_id = usuario.id).exists():
        nota = 0
        cantidad = 0
        for e in Examen.objects.filter(materia__nombre = materia.nombre,opcion = 'FI', alumno_id = usuario.id):
            cantidad+= 1
            nota+= e.nota
        return (nota/cantidad)
    else:
        return None  
             
def promedioMateria(materia, usuario):
    retval = None
    parciales = promedioParciales(materia, usuario)
    finales = promedioFinales(materia, usuario)
    if (parciales):
        if (finales):
            retval = "{0:g}".format(math.ceil((parciales+finales)/2))
        else:
            retval = "{0:g}".format(math.ceil(parciales))
    elif (finales):
        retval = "{0:g}".format(math.ceil(finales))
    return retval
##### fin funciones promedio
#convierte el estado de una materia a uno legible para el usuario
def convertirEstado(estado):

    estados = { 'LB' : 'Libre',
                'CU' : 'En Curso',
                'RE' : 'Final Adeudado',
                'FI' : 'Completa'
               }
    return estados[estado]
    
def convertirExamen(examen):
    opcion = { 'FI' : 'Final', 'PA' : 'Parcial' }
    return opcion[examen.opcion]
    
#recibe el id del usuario, 2 listas y las llena de las materias en curso y las regularizadas

def materiasExamen(userId, cursando, regularizadas):
    for l in Materia.objects.select_related().all():
                estado = estadoMateria(l, userId)
                if estado == "cursando":
                    cursando.append(l)
                elif estado == "regularizada":
                    regularizadas.append(l)
       
#funciones para tirar ValueError

def stringVacio(string):
    if not string:
        raise ValueError
    else:
        return string     
    
    
def corroborarNota(nota):
    if int(nota) >= 1 and int(nota) <= 10:
        return int(nota)
    else:
        raise ValueError('la nota tiene que ser entre 0 y 10')

def promedioCursada(usuario):#TODO
    promedio = 0
    materias = []
    for m in Materia.objects.all():
        promedio = promedioMateria(m, usuario)
        if (promedio):
            materias.append(float(promedio))
    if (len(materias)):
        promedio = "{0:g}".format(math.ceil(sum(materias)/len(materias)))
    #if (promedio == None):
    #    promedio = ''
    return promedio

#Definimos el proximo estado de la materia
#Puede ser  el estado actual, sirve para evaluar la condicion de la materia
#.. frente a ls modificaciones de examenes. Si es  cumple con ciertas condiciones
# cambia el estado y la almacena en la base (Maxi).
def EvaluarEstadoMateria(request, materia): #Recibe objeto Materia y evalua estado
    
    cantParciales = Examen.objects.filter(materia_id = materia).filter(alumno_id = request.user).filter(opcion = 'PA').filter( nota__gt = 4).count()
    #Examen.objects.filter(materia_id = materia.id, alumno_id = request.user.id(), opcion = 'PA', nota__gt = 4).count()
    hayFinal = Examen.objects.filter(materia_id = materia).filter(alumno_id = request.user).filter(opcion = 'FI').filter( nota__gt = 4).count()
    #Condiciones -- REgulada = (1 parcial aprobado si es Cuatri, 3 apro si es Anual)
    # FInal si se aprobo final
    if cantParciales > 1:
        materiaEstado = EstadoMateria.objects.get(materia = materia.id, alumno = request.user.id)
        materiaEstado.estado = 'RE'
        materiaEstado.save()
    else:
        materiaEstado = EstadoMateria.objects.get(materia = materia.id, alumno = request.user.id)
        materiaEstado.estado = 'CU' #Esto es por si se borra parciales y se llama (OJO QUE NO SIEMPRE SERA 
                            #.. CURSANDO, por lo que se tendra que evaluar otra solucion en mejoras)
        materiaEstado.save()
    if hayFinal:
        materiaEstado = EstadoMateria.objects.get(materia = materia.id, alumno = request.user.id)
        materiaEstado.estado = 'FI'
        materiaEstado.save()
    return ()