$(document).ready( function()
{
  $("#materia-li").click(function()
  {
    $("#contenido_materia").slideToggle();
  });

  
  $(".materia").click(function()
  {
    $(this).fadeToggle("slow",function()
    {
        $(this).fadeToggle("slow");
    });
  });

  
  
}); 
