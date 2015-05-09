$(document).ready( function()
{

    $('.list-group-item').click(function () {
      var classes = ['list-group-item list-group-item-warning active','list-group-item list-group-item-danger active', 'list-group-item list-group-item-success active', 'list-group-item list-group-item active'];
      $(this).each(function(){
        this.className = classes[($.inArray(this.className, classes)+1)%classes.length];
      });
    });



});
