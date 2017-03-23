/**
 * @author mgunasek
 */

$(document).ready(function() {

 $('.TreeView li').each(function(){
          var curr = $(this);
          curr.click(function(evt){
                if (curr.find('ul').size()>0) {
                   $(this).toggleClass('expanded').toggleClass('collapsed');
                }
                evt.stopPropagation();
          });
    });

    $('a').click(function(){
       $('a').removeClass('selected');
       $(this).addClass('selected'); 
    });

});

