'''
Created on 17/04/2015

@author: maxi
'''
from django.core.mail import send_mail
from django.shortcuts import render
from django.contrib.auth.models import User

def RecuperarPassword(email):
    '''Vamos a hacer una prueba de envio por correo, si eso no funca
    todo esto es inutil
    '''
    send_mail('Prueba', 'Here is the message.', 'gestion.plancarrera@gmail.com', ['gestion.plancarrera@gmail.com'], fail_silently=False)
    return ()

    
'''    
    
    
def RecuperarUsuario(request):
'''