/**
 * @author mgunasek
 */
$(function() {
    $('form a').click(function() {
        $(this).parent('form').submit();
    });

    $('form.serviceDetails').submit(function() {
        popupform(this, 'Source');
    });

});

//the following code is executed after all the page elements have loaded
$(window).load(function() {
    //add the fadeout behavior for the message element (if present)
//    $('div.success').fadeOut(4000);
});

function popupform(myform, windowname)
{
    if (! window.focus) return true;
    window.open('', windowname, 'width=900, height=600,scrollbars=yes');
    myform.target = windowname;
    return true;
}

