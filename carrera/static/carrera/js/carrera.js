$(document).ready( function()
{
<<<<<<< HEAD
  /*$(".materia").click(function()
=======
  $("#materia-li").click(function()
  {
    $("#contenido_materia").slideToggle();
  });

  
  $(".materia").click(function()
>>>>>>> ayuda
  {
    $(this).fadeToggle("slow",function()
    {
        $(this).fadeToggle("slow");
    });
<<<<<<< HEAD
  });*/
  
  $(".list-group-item").click(function(ev) // for each edit materia url
  { 
    ev.preventDefault(); // prevent navigation
    var url = $(this).data("form"); // get the contact form url
    $("#muestra").load(url, function()  // load the url into the modal
    {
        $(this).modal('show'); // display the modal on url load
    });
    return false; // prevent the click propagation
    
    });
   
  
  
=======
  });

>>>>>>> ayuda
  
  
}); 
