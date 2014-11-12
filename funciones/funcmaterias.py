################################################################################
##                   Funciones Materias                                       ##
## Autor: Maor Levy - 2014                                                    ##
##                                                                            ## 
##       Proyecto PlanCarrera - UNLa 2014 - Seminario de Lenguajes            ##
## funciones que asisten en manejo de la informacion del modelo de la materia ##
##                                                                            ##
################################################################################


from plan.models import EstadoMateria, Materia, Parcial
from django.core.exceptions import ObjectDoesNotExist


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
            
            
#funcion que recibe una materia y usuario
#TODO: retorna el promedio de cursada chequeando los examenes, en caso de no existir, retorna ???
def promedioMateria(materia, usuario):
    if Parcial.objects.filter(materia__nombre = materia.nombre, alumno_id = usuario.id).exists:
        nota = 0
        cantidad = 0
        for p in Parcial.objects.filter(materia__nombre = materia.nombre, alumno_id = usuario.id):
            cantidad+= 1
            nota += p.nota
        #return nota/cantidad
    else:
        return null

