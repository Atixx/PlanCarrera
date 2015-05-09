$(document).ready( function()
{


    $('.list-group-item').click(function () {
      var classes = ['list-group-item list-group-item-danger active','list-group-item list-group-item-warning active', 'list-group-item list-group-item-success active', 'list-group-item list-group-item active'];
      $(this).each(function(){
        this.className = classes[($.inArray(this.className, classes)+1)%classes.length];
      });
    });
    
   
    $('#alert').click(function ()
    {
        alert(estados[0].fields.estado);
    });


    function materia(pk, nombre, correlativas)
    {
        this.pk = pk;
        this.nombre = nombre;
        this.correlativas = correlativas;
    }
    
    for (var i=0; i < matJson.length; i++)
    {
        todasLasMaterias[i] = new materia(matJson[i].pk, matJson[i].fields.nombre, matJson[i].fields.correlativas);
    }
    
    for (var i=0; i < matJson.length; i++)
    {
        numeros = todasLasMaterias[i].correlativas;
        for (var n=0; n < numeros.length; n++)
        {
            todasLasMaterias[i].correlativas[n] = todasLasMaterias[(numeros[n]-1)];
        }
    }
    
    for (var i=0; i < estados.length; i++)
    {
        todasLasMaterias[(estados[i].fields.materia - 1 )].estado = estados[i].fields.estado;
    }

    
   
});
