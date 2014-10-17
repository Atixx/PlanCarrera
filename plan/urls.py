from django.conf.urls import patterns, url

from plan import views

urlpatterns = patterns ('',
   url(r'^$',views.index, name='index'),
    #url(r'^(?P<usuario>\w+)/alumno/$', views.alumno, name='alumno'),
    url(r'^(?P<materia_nom>\w+)/materia/$', views.materia, name="materia"),
    url(r'^(?P<id_parcial>\d+)/parcial/$', views.parcial, name="parcial"),
    
)
