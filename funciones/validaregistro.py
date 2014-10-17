'''
Created on 13/10/2014

@author: maxi
'''
from django.contrib.auth.models import User


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

    Encontrado=False
    if User.objects.filter(username=usuario): #retornaba lista vacia, por lo tanto siempre daba distinto de ""
        Encontrado=True
    return(Encontrado)
    
