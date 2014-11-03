from django.conf.urls import patterns, url

from plan import views

urlpatterns = patterns ('',
   url(r'^$',views.index, name='index'),
    #url(r'^(?P<usuario>\w+)/alumno/$', views.alumno, name='alumno'),
    #url(r'^(?P<materia_nom>\w+)/materia/$', views.materia, name="materia"),
    url(r'^nueva-materia/$', views.anotarse_materia, name="anotarse-materia"),
    url(r'^(?P<id_parcial>\d+)/parcial/$', views.parcial, name="parcial"),
    url(r'^abandonar-materia/$', views.abandonar_materia, name="abandonar-materia"),
    url(r'^ayuda/$', views.ayuda, name="ayuda"),
    url(r'^alumno/$', views.alumno, name="alumno"),
    url(r'^logout/$', views.logout, name="logout"),
    
)
