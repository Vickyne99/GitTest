/**
* This script is used by the nerv-config-edit.dsp 
*   to hide the Performance interval text box based on the report checkbox and
*   perform validation for the field.
*   @author mki
**/

$(function() {

	$("#perfEnabled").click(function() {
	   var element = $('#perfEnabled')[0];
	   var intervalInput = $("#reportInterval");
	   if(element.checked) {
		intervalInput.attr("disabled", "");
	   } else {
		intervalInput.attr("disabled", "disabled");
	   }
    });
    
});



$(document).ready(function() {

$("input[name='pg.nerv.PgMenConfiguration.reportInterval']").blur(checkReportInterval);

});

function checkReportInterval() {
    var intEl = $('input[name="pg.nerv.PgMenConfiguration.reportInterval"]')[0];
    var pattern = /^\d{1,2}$/;

    if (intEl != null) {
        var val = intEl.value;
        var result = val.search(pattern);

        if (result == -1 || (val < 1 || val > 60)) {   //valid value range = 1<=val<=60
            $('#report-interval span').show();
            $(intEl).addClass('invalid');
            isErr = true;
        }
        else {
            $('#report-interval span').hide();
            $(intEl).removeClass('invalid');
            isErr = false;
        }
    }
}


