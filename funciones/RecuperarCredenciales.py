'''
Created on 17/04/2015

@author: maxi
'''
from django.core.mail import send_mail

def RecuperarPassword(request):
    '''Vamos a hacer una prueba de envio por correo, si eso no funca
    todo esto es inutil
    '''
    send_mail('Prueba', 'Here is the message.', 'PlanCarrera@example.com',
               ['mcolombo87@gmail.com'], fail_silently=False)
    
'''    
    
    
def RecuperarUsuario(request):
'''