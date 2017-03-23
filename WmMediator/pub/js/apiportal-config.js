/**
 * @author clep
 */

$(document).ready(function() {
	
	updateReportInterval();
    $('a#deleteConfig').bind('click', function(e) {
        var isConfirmed = confirm(getmsg("apiportal.delete.config"));
        if (!isConfirmed) {
            e.preventDefault();
        }
    });
	
	//bind the validation call to the onclick event of save button
    $('input[type=submit]').click(function(evt) {
        var result = validateFields();
        if (!result) {
            evt.preventDefault();
            evt.stopPropagation();
        }
    });

    //validate the metrics reporting interval [should be between 1 and 60]
    $("input[name='pg.apiportal.PgMenConfiguration.reportInterval']").blur(checkReportInterval);
	
	//enable/disable the perf reporting interval based on whether reporting checkbox is checked/unchecked
    $('input[name=pg.apiportal.PgMenConfiguration.perfDataEnabled]').click(updateReportInterval);
	
	//check the passwords
    $('input[name$="password"]').change(function() {
        checkPasswords("password", "check.password");
    });
});

//validate the reporting interval field
function checkReportInterval() {
    var intEl = $('input[name="pg.apiportal.PgMenConfiguration.reportInterval"]')[0];
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

//Enable or disable the perf reporting section based on whether the perf reporting flag is checked/unchecked
function updateReportInterval() {
    var reportIntEl = $('input[name=pg.apiportal.PgMenConfiguration.reportInterval]')[0];
    var perfReportingEl = $('input[name=pg.apiportal.PgMenConfiguration.perfDataEnabled][type=checkbox]')[0];
    if (perfReportingEl && perfReportingEl.checked) {
        enableElement(0, reportIntEl);
    }
    else if (reportIntEl){
        disableElement(0, reportIntEl);
    }
}

//whenever the checkbox is checked, set the value attribute to 'true', when it is unchecked send value as 'false'
function updateCheckboxValue(chkEl) {
    if (chkEl.checked) {
        $(chkEl).attr('value', 'true');
    }
    else {
        $(chkEl).after("<input type='hidden' name=" + chkEl.name + " value='false' />");
    }
}

//target name field is required
function checkPortalName() {
	var result = true;
    var portalName = $('input[name="name"]')[0];
    var result = ($.trim(portalName.value) != ''); 
    if (!result) {
    	markInvalid(portalName);
    } else {
    	markValid(portalName);
    }
    return result;
}

//do any required field validation here
function validateFields() {
    var result = checkPortalName();
    if ( !result ) {
    	alertUser();
    }
    return result;
}
