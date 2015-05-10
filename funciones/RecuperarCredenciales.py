'''
Created on 17/04/2015

@author: maxi
'''
from django.core.mail import send_mail
from django.contrib.auth.models import User
from django.contrib.auth.hashers import base64

def RecuperarPassword(correo):
    '''Enviamos el ID del usuario por email, encriptado para ser usado luego
    por un get y recuperar la contrasenia
    '''
    u=User.objects.get(email=correo)
    createidcode="UserID:"+ str(u.id)
    idcode="AA="+base64.standard_b64encode(createidcode)
    url= "http://atix.koding.io:80/plan/recuperar?"+idcode
    send_mail('Plan Carrera: Recuperar password', 'Para poder continuar y recuperar su clave, siga el siguiente link: '
              +url, 'gestion.plancarrera@gmail.com', [correo], fail_silently=False)
    
    return ()

def DesencriptarUserID(UserEncrypt):
        
    UserDesencrypt = base64.standard_b64decode(UserEncrypt)
    UserID = UserDesencrypt.split(':')
    UserID = UserID[1]
        
    return (UserID)

def RecuperarUsuario(correo):

    u=User.objects.get(email=correo)
    usuario=u.username
    createidcode="UserID:"+ str(u.id)
    idcode="AA="+base64.standard_b64encode(createidcode)
    url= "http://atix.koding.io:80/plan/recuperar?"+idcode
    send_mail('Plan Carrera: Recuperar Usuario', 'Su usuario es: '
              +usuario +'. Si no recuerda su clave de acceso puede cambiarla siguiendo este link: '
              +url, 'gestion.plancarrera@gmail.com', [correo], fail_silently=False)
    
    return ()
