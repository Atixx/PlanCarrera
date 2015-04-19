'''
Created on 17/04/2015

@author: maxi
'''
from django.core.mail import send_mail
from django.contrib.auth.models import User
from django.contrib.auth.hashers import base64

def RecuperarPassword(correo):
    '''Vamos a hacer una prueba de envio por correo, si eso no funca
    todo esto es inutil
    '''
    u=User.objects.get(email=correo)
    createidcode="UserID:"+ str(u.id)
    idcode="AA="+base64.standard_b64encode(createidcode)
    url= "http://localhost:8000/plan/recuperar?"+idcode
    send_mail('Plan Carrera: Recuperar password', 'Para poder continuar y recuperar su clave, siga el siguiente link: '
              +url, 'gestion.plancarrera@gmail.com', [correo], fail_silently=False)
    
    return ()

def DesencriptarUserID(UserEncrypt):
        
    UserDesencrypt = base64.standard_b64decode(UserEncrypt)
    UserID = UserDesencrypt.split(':')
    UserID = UserID[1]
        
    return (UserID)
    