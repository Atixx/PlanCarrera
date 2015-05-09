$(document).ready( function()
{

    function materia(nombre, estado)
    {
        this.nombre = nombre;
        this.estado = estado;
    }

    //TODO cargar todas las materias en un array de materias


    $('.list-group-item').click(function () {
      var classes = ['list-group-item list-group-item-warning active','list-group-item list-group-item-danger active', 'list-group-item list-group-item-success active', 'list-group-item list-group-item active'];
      $(this).each(function(){
        this.className = classes[($.inArray(this.className, classes)+1)%classes.length];
      });
    });
    
    
    $('#alert').click(function ()
    {
        alert(estados[0].fields.estado);
    });



});
