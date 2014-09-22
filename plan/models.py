from django.db import models

# Create your models here.


class Alumno(models.Model):
    #TODO: agregar usuario como PK
    usuario = models.CharField(max_length=30)
    nombre = models.CharField(max_length=50)
    email = models.EmailField(max_length=50)

    def __unicode__(self):
        return self.nombre

class Profesor(models.Model):
    nombre = models.CharField(max_length=50)
    
    def __unicode__(self):
        return self.nombre

class Materia(models.Model):
    PRIMERO = 'PR'
    SEGUNDO = 'SE'
    ANUAL = 'AN'
    OPCION_CUATRI = (
        (PRIMERO, 'Primero'),
        (SEGUNDO, 'Segundo'),
        (ANUAL, 'Anual'),
    )
    nombre = models.CharField(max_length=100)
    cuatrimestre = models.CharField(max_length=2,
                                    choices=OPCION_CUATRI,
                                    default=PRIMERO)
    profesor = models.ManyToManyField(Profesor)
    correlativas = models.ManyToManyField("Materia", blank=True);
                                        
    def __unicode__(self):
        return self.nombre
        
class Parcial(models.Model):
    nota = models.DecimalField(max_digits=2, decimal_places=1)
    fecha = models.DateTimeField('fecha rendido')
    alumno = models.ForeignKey(Alumno)
    materia = models.ForeignKey(Materia)
    
    def __unicode__(self):
        return '%s, %s: %s' %(self.materia, self.alumno, self.nota)
    

class EstadoMateria(models.Model):
    LIBRE = 'LB'
    CURSANDO = 'CU'
    REGULARIZADA = 'RE'
    FINAL = 'FI'
    ESTADOS = (
        (LIBRE, 'Libre'),
        (CURSANDO, 'En Curso'),
        (REGULARIZADA, 'Aprobada'),
        (FINAL, 'Completa'),
    )
    materia = models.ForeignKey(Materia)
    alumno = models.ForeignKey(Alumno)
    estado = models.CharField(max_length=2,
                            choices = ESTADOS,
                            default = LIBRE)      
    class Meta:
        unique_together = (("materia", "alumno"),)
    
    def __unicode__(self):
        return '%s, %s: %s' %(self.materia, self.alumno, self.estado)                         
                              






