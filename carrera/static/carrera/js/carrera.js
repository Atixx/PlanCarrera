$(document).ready( function()
{
  /*$(".materia").click(function()
  {
    $(this).fadeToggle("slow",function()
    {
        $(this).fadeToggle("slow");
    });
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
  
  
  
  
}); 
