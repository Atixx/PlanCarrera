'''
Created on 13/10/2014

@author: maxi
'''
from django.contrib.auth.models import User
from django.contrib.auth.hashers import check_password



def validacampo(campos):
    if campos["passwd"] != campos["repasswd"]:
            regerror="passnoigual"                    
    elif campos["user"] =="":
            regerror="Usuario"
    elif campos["passwd"] =="" or campos["repasswd"] =="":
            regerror="Password"
    elif campos["name"] =="":
            regerror="Nombre"
    elif campos["lastname"] =="":
            regerror="Apellido"
    elif campos["email"] =="":
            regerror="Email"
    else:
        regerror =""
    return(regerror)

def usuarioexistente(usuario):

    Encontrado = False
    if User.objects.filter(username=usuario):
        Encontrado = True
    return(Encontrado)
    
def validarpasswd(datos):
    encontrado = False
    m=User.objects.get(username=datos["user"])
    if check_password(datos["passwd"], m.password)==True:
        encontrado = True
    return (encontrado)

def correoexiste(correo):
    Encontrado = False
    if User.objects.filter(email=correo):
        Encontrado = True
    return(Encontrado)

