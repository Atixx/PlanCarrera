from django.contrib import admin
from plan.models import *


# Register your models here.

class AlumnoAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Informacion Personal', {'fields': ['nombre', 'email']}),
    ]


admin.site.register(Materia)
admin.site.register(Profesor)
admin.site.register(Examen)
admin.site.register(EstadoMateria)
