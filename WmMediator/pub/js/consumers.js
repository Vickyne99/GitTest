/**
 * @author mgunasek
 */
$(function() {
	$('div.consumer span').click(function() {
		var isImg = $(this).hasClass('img');
		if(!isImg) {
			return;
		}
		var img = $(this).children(0);
		var id = $(img).attr('id');
        var isCollapsed = $(img).hasClass('collapsed');
		
        if (isCollapsed)
            expandDetails(0, img);
        else
            collapseDetails(0, img);
    });

    $('a.collapse').click(function(e) {
        $('div.consumer img').each(collapseDetails);
        e.preventDefault();
    });

    $('a.expand').click(function(e) {
        $('div.consumer img').each(expandDetails);
        e.preventDefault();
    });

    $('input[type=button]').click(function() {
        $(this).after("<input type='hidden' name='syncAction' value='" + this.name + "'/>");
        $('input[type=button]').attr('disabled', 'true'); //disable the sync button
        $(this).parent('form').submit();
    });
});

function collapseDetails(idx, img) {
    $(img).parents('.consumer').find('.details').hide('slow');
    //$(img).attr('src', 'images/collapsed.gif').removeClass('expanded');
	$(img).attr('src', 'images/collapsed.gif').addClass('collapsed');
}

function expandDetails(idx, img) {
    $(img).parents('.consumer').find('.details').show('slow');
    //$(img).attr('src', 'images/expanded.gif').addClass('expanded');
	$(img).attr('src', 'images/expanded.gif').removeClass('collapsed');
}


