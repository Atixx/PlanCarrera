$(document).ready( function()
{
  $("#materia-li").click(function()
  {
    $("#materias").toggle();
    $("#materias").attr("class", "show");
  });
    
  $(".materia").click(function()
  {
    $(this).fadeToggle("slow",function()
    {
        $(this).fadeToggle("slow");
    });
  });

  
  
}); 
