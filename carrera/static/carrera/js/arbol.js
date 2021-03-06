$(document).ready( function()
{


    $(' .list-group-item').click(function () {
      var classes = ['list-group-item list-group-item-danger active','list-group-item list-group-item-warning active', 'list-group-item list-group-item-success active', 'list-group-item list-group-item active'];
      var nuevaClase;
      $(this).each(function(){
        nuevaClase = classes[($.inArray(this.className, classes)+1)%classes.length]
        this.className = nuevaClase;//classes[($.inArray(this.className, classes)+1)%classes.length];
      });
      materias[materias[$(this).text()].nombre].estado = CssAEstado(nuevaClase);
      calcularPagina();
    });
    
    
    //TODO:jQuery que reconozca el Objeto segun el div que se clickeo
   
    /*$('.list-group-item').click(function ()
    {
        alert(materias[$(this).text()].nombre);
        
    });*/
    
    //TODO funcion de traduccion de estados a "disabled", "disponible", "completa"
    //LB, CU, RE, FI
    
    function traduccionEstado(estado)
    {
        var estados = { 'LB' : 'libre', 'CU' : 'cursando', 'RE' : 'regularizada', 'FI' : 'completa'};
        return estados[estado];
    }
    
    function CssAEstado(input)
    {
        var css = {'list-group-item list-group-item-danger active' : "cursando",'list-group-item list-group-item-warning active' : "regularizada", 'list-group-item list-group-item-success active' : "completa",'list-group-item list-group-item active' : "disponible"} 
        return css[input];
    }  


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
        todasLasMaterias[(estados[i].fields.materia - 1 )].estado = traduccionEstado(estados[i].fields.estado);
    }
    
    for (var i=0; i < todasLasMaterias.length; i++)
    {   
        materias[todasLasMaterias[i].nombre] = todasLasMaterias[i];
    }    
       
    function funcCss (input)
    {
        var css = { "cursando" : 'list-group-item-danger active', "regularizada" : 'list-group-item-warning active', "completa" : 'list-group-item-success active', "disponible" : ' active', "libre" : ' active', "undefined" : ' active'} 
        return css[input];
    }   
        
    function calcularPagina() //FUNCIONA
    {
        for (m in materias) 
        {
            if (materias[m].estado != undefined) //si tiene estado, lo tomo
            {
                $( "a:contains('" + m + "')").addClass(funcCss(materias[m].estado));
                 
            }
            else 
            {
                if(materias[m].correlativas.length > 0) 
                {
                    var flag = true;
                    var corr = materias[m].correlativas;
                    for (var i=0; i < materias[m].correlativas.length; i++)
                    {
                        if (corr[i].estado == undefined || corr[i].estado == "libre" || corr[i].estado == "disponible" || corr[i].estado == "cursando") 
                        {
                            flag = false;
                        }
                        
                    }
                    if (flag) //Todos las correlativas estan aprobadas
                    {
                        materias[m].estado = "disponible"
                        $( "a:contains('" + m + "')").addClass(funcCss(materias[m].estado));
                    }
                    /*else //no estan aprobadas, le saco la clase
                    {
                        $( "a:contains('" + m + "')").removeClass(funcCss(materias[m].estado));
                    }*/
                }
                else  //no tiene estado, pero no tiene correlativas lo agrego             
                {
                    materias[m].estado = "disponible"
                    $( "a:contains('" + m + "')").addClass(funcCss(materias[m].estado));
                }
            }
        }
    }
    

    calcularPagina();   
    
    
    
   
});
