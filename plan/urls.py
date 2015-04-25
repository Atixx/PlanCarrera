from django.conf.urls import patterns, url

from plan import views

urlpatterns = patterns ('',
   url(r'^$',views.index, name='index'),
    #url(r'^(?P<usuario>\w+)/alumno/$', views.alumno, name='alumno'),
    #url(r'^(?P<materia_nom>\w+)/materia/$', views.materia, name="materia"),
    url(r'^nueva-materia/$', views.anotarse_materia, name="anotarse-materia"),
    url(r'^abandonar-materia/$', views.abandonar_materia, name="abandonar-materia"),
    url(r'^ayuda/$', views.ayuda, name="ayuda"),
    url(r'^alumno/$', views.alumno, name="alumno"),
    url(r'^logout/$', views.logout, name="logout"),
    url(r'^materias/arbol$', views.arbol_materias, name="arbol"),
    url(r'^materias/(?P<nombre_materia>[\w\d-]+)$', views.materia, name="materia"),
    url(r'^materias/$', views.lista_materias, name="materias"),
    url(r'^nuevo-examen/$', views.anotarse_examen, name="anotarse-examen"),
	url(r'^consulta-examen/$', views.consulta_examen, name="consulta-examen"),
	url(r'^editar-datos/$', views.editar_datos, name="editar-datos"),
    
)
