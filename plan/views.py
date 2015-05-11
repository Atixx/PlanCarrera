from datetime import datetime
from django.shortcuts import render, get_object_or_404, redirect
from plan.models import Examen, EstadoMateria, Materia, Profesor
from django.contrib.auth.models import User
from funciones.validaregistro import validacampo, usuarioexistente, validarpasswd,\
    correoexiste
from funciones.funcmaterias import *
from django.utils.safestring import mark_safe
from django.contrib import auth
from django.contrib.auth.hashers import make_password
from django.core import serializers
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.decorators import login_required
from django.template.defaultfilters import slugify
from django.contrib.auth import authenticate
from funciones.RecuperarCredenciales import RecuperarPassword, RecuperarUsuario, DesencriptarUserID
from urllib2 import HTTPRedirectHandler
from django.http.response import HttpResponseRedirect

# Create your views here.
def home(request):
    registroOk = False
    if request.user.is_authenticated():
        #PRUEBO SI MANTIENE LA SESION
        return index(request)
    seleccion=request.POST.get('reg','')
    regerror=""
    if request.method == "POST":
        p=request.POST.get('passwd','')
        p2=request.POST.get('repasswd','')
        u=request.POST.get('user','')
        n=request.POST.get('name','')
        a=request.POST.get('lastname','')
        e=request.POST.get('email','')
        u2=request.POST.get('userlog','')
        pl=request.POST.get('passwdlog','')
        #Valida REGISTRO
        if u:
            datos={"user":u,"passwd":p,"repasswd":p2,"name":n,"lastname":a,"email":e}
            regerror = validacampo(datos)
            if regerror == "":
                if usuarioexistente(u) == False and correoexiste(e)== False:
                    p = make_password(p)
                    nuevoalumno=User(username=u, password=p, first_name=n, last_name=a, email= e)
                    nuevoalumno.save()
                    registroOk = True
                    #logear al nuevo usuario
                    nuevoalumno = authenticate(username=u, password=datos["passwd"])
                    auth.login(request, nuevoalumno)
                else:
                    regerror="Usuario o Email Existente"
            seleccion="1"
        if u2:
            datos={"user":u2,"passwd":pl}
            seleccion="0"
            if usuarioexistente(u2):
                if validarpasswd(datos):
                    #Datos Validos, hacer logeo
                    usuario = auth.authenticate(username=u2,password=pl)
                    auth.login(request, usuario)
                    return home(request)
                    #return render(request, "plan/detallado.html")
                else:
                    regerror="Password Invalida"
            else:
                regerror="El usuario no existe"
         
    return render(request, "plan/home.html",{"reg" : seleccion,"regerror":regerror, "registroOk":registroOk})
                  
def index(request):
    #lista_alumnos = User.objects.all()
    #lista_parciales = Parcial.objects.all()
    #context = {"lista_alumnos" : lista_alumnos , "lista_parciales" : lista_parciales}
    alumno = User.objects.get(pk=request.user.id)
    tot = Materia.objects.count()
    if tot != 0:
    
        reg = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'RE').count()
        regperc = reg*100/tot
        com = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'FI').count() 
        comperc = com*100/tot
        cur = EstadoMateria.objects.filter(alumno_id = alumno.id , estado = 'CU').count()
        curperc = cur*100/tot
        promedio = promedioCursada(alumno)
    
    context = {
        "alumno" : alumno,
        "reg" : reg,
        "regperc" : regperc,
        "com" : com,
        "comperc" : comperc,
        "cur" : cur, 
        "curperc" : curperc,
        "tot" : tot,
        "promedio" : promedio
        
    }
    return render(request, "plan/index.html", context)

@login_required
def alumno(request):
    alumno = get_object_or_404(User, pk=request.user.id)
    if request.method == 'POST':
        alumno.first_name = request.POST.get('name', '')
        alumno.last_name = request.POST.get('last', '')
        alumno.email = request.POST.get('email', '')
        alumno.save()
    return render(request, "plan/alumno.html",{"alumno" : alumno})
    
    
@login_required
def anotarse_materia(request):
    if request.method == 'POST':
        nombreMateria = request.POST.get('materia', '')
        try:
            existe = EstadoMateria.objects.get(materia__nombre__exact = nombreMateria, alumno__id = request.user.id)
            existe.estado = 'CU'
            existe.save()
            msg = "Se ha inscripto en la materia: "+nombreMateria+" , que la curse con exito!"
        except ObjectDoesNotExist:    
            try:
                estadonuevo = EstadoMateria( materia =  Materia.objects.get(nombre__exact = nombreMateria), alumno = User.objects.get(pk=request.user.id), estado = 'CU')
                msg = "Se ha inscripto en la materia: "+nombreMateria+". Exitos!"
                estadonuevo.save()
            except:
                msg = "Debe seleccionar la materia en la que desea anotarse."
        return render(request, "plan/anotarse_materia.html", {"msg" : msg})
    else:
        enabled = []
        disabled = []
        for l in Materia.objects.select_related().all():
            estado = estadoMateria(l, request.user)
            if estado == "disponible":
                enabled.append(l)
            elif estado == "deshabilitada":
                disabled.append(l)    
        context = {"enabled" : enabled, "disabled" : disabled}
        return render(request, "plan/anotarse_materia.html", context)


@login_required
def abandonar_materia(request):
    #TODO: Chequear si hay materias en curso (msg de error sino), mostrarlas, cambiar su estado de CU a LB
    if request.method == 'POST':
        nombreMateria = request.POST.get('materia', '')
        try:
            libre = EstadoMateria.objects.get(materia__nombre = nombreMateria, alumno_id = request.user.id)
            libre.estado = 'LB'
            libre.save()
            Examen.objects.filter(materia__nombre = nombreMateria, alumno_id = request.user.id).delete() #TODO: cambiar que no borre finales
            msg = "Ha quedado libre de "+nombreMateria+"."
        except ObjectDoesNotExist:
            msg = "Debe seleccionar la materia que desea abandonar."
            
        return render(request, "plan/abandonar_materia.html", { "msg" : msg })
    else:
        mat = []
        for m in EstadoMateria.objects.filter(alumno_id = request.user.id, estado = 'CU'):
            mat.append(m.materia)
        context = { "materias" : mat }
        return render(request, "plan/abandonar_materia.html", context)

    
def ayuda(request):
    return render(request, "plan/ayuda.html")    

#TODO: Fijarse si hara falta hacer un flush, o algun otro paso mas??
def logout(request): 
    auth.logout(request)
    return render(request, "plan/logout.html")


#TODO: listar materias por anios

def lista_materias(request):
    primero = []
    segundo = []
    tercero = []
    cuarto = []
    quinto= []
    mat = { "PR" : primero, #aca deberia cambiar segun el modelo de Materia y tambien en lista_materias.html
            "SE" : segundo,
            "TE" : tercero,
            "CU" : cuarto,
            "QU" : quinto
        }
    for m in Materia.objects.select_related().all():
        mat[m.anio].append([m, promedioMateria(m, request.user)])
    context = { "materias" : mat }
    return render(request, "plan/lista_materias.html", context)
    
def arbol_materias(request):
    estadoMaterias = mark_safe(serializers.serialize("json", EstadoMateria.objects.filter(alumno = request.user.id)))
    materiasJson = mark_safe(serializers.serialize("json", Materia.objects.all()))

    context = {"estados" : estadoMaterias, "matJson" : materiasJson }
    
    return render(request, "plan/arbol.html", context)      
      

def materia(request, nombre_materia): #modal usa esto
    nombre_materia = nombre_materia.replace("-" ," ")
    materia = get_object_or_404(Materia, nombre__iexact = nombre_materia)
    profesor = materia.profesor.all() #Profesor.objects.filter(materia__nombre = nombre_materia)
    correlativas = materia.correlativas.all()
    context = {"mat": materia, "profesor" : profesor, "correlativas" : correlativas}
    examenes = []    
    parciales = []
    finales = []
    if request.user.is_authenticated(): #datos solo disponibles a logged
        context["auth"] = True;
        if EstadoMateria.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id).exists():         
            context["estado"] = convertirEstado(EstadoMateria.objects.get(materia__nombre = materia.nombre, alumno_id = request.user.id).estado)
        if Examen.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id).exists():
            for e in Examen.objects.filter(materia__nombre = materia.nombre, alumno_id = request.user.id): 
                examenes.append(e)
            for i in examenes:
                if i.opcion == 'PA': 
                    parciales.append(i)
                if i.opcion == 'FI': 
                    finales.append(i) 
            context["parciales"] = parciales
            context["finales"] = finales
    else: #datos disponibles solo a NO logged
        context["auth"] = False;
    return render(request, "plan/materiamodal.html", context)
    
    
#TODO: agregar examen a DB
#Menos importante: agregar <selected> a la materia seleccionada antes del error
@login_required
def anotarse_examen(request):
    if request.method == 'POST':
        try:
            nombreMateria = stringVacio(request.POST.get('materia',''))
            opcion = request.POST.get('opcion','')
            fecha = datetime.strptime(request.POST.get('fecha',''), "%d/%m/%Y") #.date
            nota = corroborarNota(request.POST.get('nota',''))
            alumno = request.user.id   
            msg = "Se registro el siguiente"
            fechaDB = fecha.strftime("%Y-%m-%d")
            #fechaDB = fecha.isoformat()
            if opcion == "PA":
                if EstadoMateria.objects.get(materia__nombre__exact = nombreMateria, alumno_id = alumno).estado != 'CU':
                    raise ValueError("no puede agregar un parcial a una materia que solo adeuda final")   
            #Si puede cargar parcial, Guardo la informacion y revaluo el estado de la materia para el alumno
                else:
                    examen = Examen(nota=nota, fecha= fechaDB,
                                    alumno= User.objects.get(id=alumno),
                                    materia= Materia.objects.get(nombre= nombreMateria),
                                    opcion= opcion)
                    examen.save()
            if opcion == "FI": 
                examen = Examen(nota=nota, fecha= fechaDB,
                                alumno= User.objects.get(id=alumno),
                                materia= Materia.objects.get(nombre= nombreMateria),
                                opcion= opcion)
                examen.save()
            opcion = convertirExamen(examen)
            EvaluarEstadoMateria(request, Materia.objects.get(nombre= nombreMateria))
            context = { "msg" : msg, "nom" : nombreMateria, "opcion" : opcion.lower(), "fecha" : fecha.date, "nota" : nota, "alumno" : alumno}
        
        except ValueError as e:
            error = "Corrobore los datos, "+e.message
            fecha = request.POST.get('fecha','')
            nota = request.POST.get('nota','')
            cursando = []
            regular = []
            materiasExamen(request.user, cursando, regular)
            context = {"error" : error, "cursando": cursando, "regular" : regular, "fecha" : fecha, "nota" : nota}
        return render(request, "plan/anotarse_examen.html", context)
        
    else:
        cursando = []
        regular = []
        materiasExamen(request.user, cursando, regular)    
        context = {"cursando" : cursando, "regular" : regular}
        return render(request, "plan/anotarse_examen.html", context)
  
def recpass (request):
    
    mensj=""
    if request.method == "POST":
        correo=request.POST.get('recemail','')
        if correo != "name@example.com":
            if correoexiste(correo) == True:
                RecuperarPassword(correo)
                mensj="Revise el correo suministrado y siga las instrucciones"
            else:
                mensj="El correo ingresado no se encuentra registrado en nuestra base"            
    context = {"mensj":mensj}
    
    return render(request, "plan/recupasswd.html", context)

def recuser (request):
    
    mensj=""
    if request.method == "POST":
        correo=request.POST.get('recemail','')
        if correo != "name@example.com":
            if correoexiste(correo) == True:
                RecuperarUsuario(correo)
                mensj="Revise el correo suministrado y siga las instrucciones"
            else:
                mensj="El correo ingresado no se encuentra registrado en nuestra base"            
    context = {"mensj":mensj}
    
    return render(request, "plan/recupasswd.html", context)

def restablecer (request):
    
    regerror = ""
    encrypUserID = request.GET.get('AA','')
    if encrypUserID != "":
        UserID = DesencriptarUserID(encrypUserID)
        usuario = User.objects.get(id=UserID)
        context = {"usuario":usuario, "userid":UserID}
    if request.method == "POST":
        p=request.POST.get('passwd','')
        p2=request.POST.get('repasswd','')
        usuario=request.POST.get('usuario','')
        if p != p2:
            regerror="passnoigual"  
            context = {"usuario":usuario, "regerror":regerror}
        else:
            u = User.objects.get(username=usuario)
            p = make_password(p)
            u.password = p
            u.save()
            regerror = "ok"
            context = {"regerror":regerror}
    return render(request, "plan/restablecer.html", context)

@login_required
def consulta_examen(request):
    lista_examen = []	
    #if Examen.objects.filter(pub_date__year=2015).exists(): #prueba con fecha 2015. mejorar la implementacion
    if Examen.objects.filter(fecha__range=(datetime(2008, 1, 1), datetime.now().date()), alumno_id = request.user.id).exists():		
        for i in Examen.objects.filter(fecha__range=(datetime(2008, 1, 1), datetime.now().date()), alumno_id = request.user.id).order_by('-fecha'):
            lista_examen.append(i) # agregar al filtro, discriminar por user logueado.   agregado
        context={"lista_examen" : lista_examen}
        #lista_examen.sort(reverse=True)
        for e in lista_examen:
            e.opcion = convertirExamen(e)
    else:
        no_hay="No se registran examenes a la fecha."
        context={"no_hay" : no_hay}
    return render(request,"plan/consulta_examen.html", context)
	
@login_required
def editar_datos(request):
    alumno = []
    alumno.append(request.user.first_name)
    alumno.append(request.user.last_name)
    alumno.append(request.user.email)
    alumno.append(request.user.username)
    return render(request, "plan/datosmodal.html", {"alumno" : alumno})
