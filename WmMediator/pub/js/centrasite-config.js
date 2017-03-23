/**
 * @author mgunasek
 */

$(function() {
	updateReportInterval();
    //bind the validation call to the onclick event of save button
    $('input[type=submit]').click(function(evt) {
        var result = validateFields();
        if (!result) {
            evt.preventDefault();
            evt.stopPropagation();
        }
    });
});

$(document).ready(function() {

    //validate the metrics reporting interval [should be between 1 and 60]
    $("input[name='pg.PgMenConfiguration.reportInterval']").blur(checkReportInterval);

    //check the passwords
    $('input[name$="pg.uddiClient.password"]').change(function() {
        checkPasswords("pg.uddiClient.password", "check.pg.uddiClient.password");
    });

    //validate the port values; checks fields with name ending with 'port'
    $('input[name$=Port]').each(function() {
        $(this).change(function() {checkPort(this)});
    });

    //enable/disable the perf reporting interval based on whether reporting checkbox is checked/unchecked
    $('input[name=pg.PgMenConfiguration.perfDataEnabled]').click(updateReportInterval);


});

//check if the given element's value is a valid port number 
function checkPort(el) {
    if (el != null) {
        var val = el.value;
        var regex = /^\d{1,5}$/;
        var isValid = regex.test(val);
        if (isValid) {
            //check if it is within the right range (port numbers are valid between 0 and 65535)
            if (val < 0 || val > 65535) {
                isValid = false;
            }
        }
        if (!isValid) {
            $(el).addClass('invalid');
            if ($(el).next('span').size() > 0) {  //remove and add if already present
               $(el).next('span').remove();
            }
			var msg = getmsg("port.invalid");
            $(el).after('<span>' + val + msg + '</span>');
        }
        else {
            $(el).removeClass('invalid');
            $(el).next('span').remove();
        }

        if ($('input.invalid').size()>0) {
            updateSave(false);
        }
        else updateSave(true);
    }
}


//whenever the checkbox is checked, set the value attribute to 'false',
// when it is unchecked send value as 'true' (this is because the what is shown in the UI is the inverse of the
//flag value
function updateCheckboxValue(chkEl) {
    if (chkEl.checked) {
        $(chkEl).attr('value', 'false');
    }
    else {
        $(chkEl).after("<input type='hidden' name=" + chkEl.name + " value='true' />");
    }
}


//Enable or disable the perf reporting section based on whether the perf reporting flag is checked/unchecked
function updateReportInterval() {
    var reportIntEl = $('input[name=pg.PgMenConfiguration.reportInterval]')[0];
    var perfReportingEl = $('input[name=pg.PgMenConfiguration.perfDataEnabled][type=checkbox]')[0];
    if (perfReportingEl.checked) {
        enableElement(0, reportIntEl);
    }
    else {
        disableElement(0, reportIntEl);
    }
}


//validate the reporting interval field
function checkReportInterval() {
    var intEl = $('input[name="pg.PgMenConfiguration.reportInterval"]')[0];
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


//target name field is required
function checkTargetName() {
	var result = true;
    var csTargetName = $('input[name="pg.policygateway.targetName"]')[0];
    var result = ($.trim(csTargetName.value) != ''); 
    if (!result) {
    	markInvalid(csTargetName);
    } else {
    	markValid(csTargetName);
    }
    return result;
}

//do any required field validation here
function validateFields() {
    var result = checkTargetName();
    if ( !result ) {
    	alertUser();
    }
    return result;
}
