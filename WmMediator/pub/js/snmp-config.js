/**
 * SNMP Configuration DSP related JS code
 * @author mgunasek
 */

$(function() {

    //bind a listener to the 3rd party snmp target type radio buttons to toggle their config screen
    ///and set the value of the radio control so the backend can update correctly
    $('#userRadio').click(function() {
        $('#customUserTarget').show();
        $('#customCommunityTarget').hide();
        $(this).attr('value', 'userTarget');
    });
    $('#communityRadio').click(function() {
        $('#customUserTarget').hide();
        $('#customCommunityTarget').show();
        $(this).attr('value', 'communityTarget');
    });


    //if the toggle checkbox is clicked and if checked get all the input elements and enable them
    //else if unchecked disable them
    $("#toggle-cs-snmp").click(function() {
        updateCSSnmpFields(this);
        var tpElem = $('#toggle-3p-snmp')[0];
        checkAndTogglePerfReporting(this, tpElem);
        updateCheckboxValue(this);
    });


    $("#toggle-3p-snmp").click(function() {
        update3PSnmpFields(this);
        var csElem = $('#toggle-cs-snmp')[0];
        checkAndTogglePerfReporting(csElem, this);
        updateCheckboxValue(this);
    });

    //if the use auth or use priv checkboxes are toggled, enable/disable the related fields accordingly
    $("#csUseAuth").click(function() {
        updateCSAuthFields(this);
    });

    $("#csUsePriv").click(function() {
        updateCSPrivFields(this);
    });

    $("#3pUseAuth").click(function() {
        update3PAuthFields(this);
    });

    $("#3pUsePriv").click(function() {
        update3PPrivFields(this);
    });


    //check the passwords when the 2nd password field loses focus
    var pwdLen = 8;
    $("input[name$='pg.cs.snmpTarget.authKey']").change(function() {
        checkPasswords("pg.cs.snmpTarget.authKey", "check.pg.cs.snmpTarget.authKey", pwdLen);
    });

    $("input[name$='pg.cs.snmpTarget.privKey']").change(function() {
        checkPasswords("pg.cs.snmpTarget.privKey", "check.pg.cs.snmpTarget.privKey", pwdLen);
    });

    $("input[name$='pg.snmp.userTarget.authKey']").change(function() {
        checkPasswords("pg.snmp.userTarget.authKey", "check.pg.snmp.userTarget.authKey", pwdLen);
    });

    $("input[name$='pg.snmp.userTarget.privKey']").change(function() {
        checkPasswords("pg.snmp.userTarget.privKey", "check.pg.snmp.userTarget.privKey", pwdLen);
    });

    //enable or disable the performance reporting section depending on the loaded values for cs and 3p snmp flags
    updateFieldsOnLoad();

    //bind the validation call to the onclick event of save button
    $('input[type=submit]').click(function(evt) {
        var result = validateFields();
        if (!result) {
            evt.preventDefault();
            evt.stopPropagation();
        }
    });

});

//whenever the checkbox is checked, set the value attribute to 'true', when it is unchecked send value as 'false'
function updateCheckboxValue(chkEl) {
    if (chkEl.checked) {
        $(chkEl).attr('value', 'true');
    }
    else {
        $(chkEl).after("<input type='hidden' name=" + chkEl.name + " value='false' />");
    }
}


//find all the input fields under the 'Send traps to CS SNMP' section and enable/disable
//based on whether the flag is checked or unchecked
function updateCSSnmpFields(csEl) {
    if (csEl.checked) {
        $(csEl).parents('table').find('input:disabled, select:disabled').each(enableElement);
        updateCSAuthFields($('#csUseAuth')[0]);
        updateCSPrivFields($('#csUsePriv')[0]);
    }
    else {
        $(csEl).parents('table').find('input, select').not('#toggle-cs-snmp').each(disableField);
    }
}

//find all the input fields under the 'Send traps to 3p SNMP' section and enable/disable
//based on whether the flag is checked or unchecked
function update3PSnmpFields(tpEl) {
    var elems = $(tpEl).parents('table').siblings("table").find('input, select');
    if (tpEl.checked) {
        elems.each(enableElement);
        update3PAuthFields($('#3pUseAuth')[0]);
        update3PPrivFields($('#3pUsePriv')[0]);
    }
    else {
        elems.each(disableField);
    }
}

//if the use auth or use priv checkboxes are toggled, enable/disable the password fields accordingly
function updateCSAuthFields(csUseAuthEl) {
    var pwdEls = $('input[name$=pg.cs.snmpTarget.authKey]');
    var protocolEl = $('select[name=pg.cs.snmpTarget.authProtocol]')[0];
    if (csUseAuthEl.checked) {
        //enable the auth password fields
        pwdEls.each(enableElement);
        enableElement(0, protocolEl);
    }
    else {
        //disable the auth password fields
        pwdEls.each(disableElement);
        disableElement(0, protocolEl);
    }
    updateCheckboxValue(csUseAuthEl);
}

function updateCSPrivFields(csUsePrivEl) {
    var pwdEls = $('input[name$=pg.cs.snmpTarget.privKey]');
    var protocolEl = $('select[name=pg.cs.snmpTarget.privProtocol]')[0];
    if (csUsePrivEl.checked) {
        //enable the priv pwd field
        pwdEls.each(enableElement);
        enableElement(0, protocolEl);
    }
    else {
        //disable the priv pwd field
        pwdEls.each(disableElement);
        disableElement(0, protocolEl);
    }
    updateCheckboxValue(csUsePrivEl);
}

function update3PAuthFields(tpUseAuthEl) {
    var pwdEls = $('input[name$=pg.snmp.userTarget.authKey]');
    var protocolEl = $('select[name=pg.snmp.userTarget.authProtocol]')[0];
    if (tpUseAuthEl.checked) {
        //enable the auth password fields
        pwdEls.each(enableElement);
        enableElement(0, protocolEl);
    }
    else {
        //disable the auth password fields
        pwdEls.each(disableElement);
        disableElement(0, protocolEl);
    }
    updateCheckboxValue(tpUseAuthEl);
}

function update3PPrivFields(tpUsePrivEl) {
    var pwdEls = $('input[name$=pg.snmp.userTarget.privKey]');
    var protocolEl = $('select[name=pg.snmp.userTarget.privProtocol]')[0];
    if (tpUsePrivEl.checked) {
        //enable the priv pwd field
        pwdEls.each(enableElement);
        enableElement(0, protocolEl);
    }
    else {
        //disable the priv pwd field
        pwdEls.each(disableElement);
        disableElement(0, protocolEl);
    }
    updateCheckboxValue(tpUsePrivEl);
}


// This function sets the on-page-load state by disabling/enabling the relevant fields
//1. Depending on whether the 'Send traps' flag is enabled/disabled for both CS and 3P SNMP
//update the corresponding input fields and the reporting interval section
//2. If the use auth / use priv fields are checked/unchecked update the password field states accordingly
function updateFieldsOnLoad() {
    var csEl = $('#toggle-cs-snmp')[0];
    var tpEl = $('#toggle-3p-snmp')[0];

    updateCSSnmpFields(csEl);
    updateCheckboxValue(csEl);

    update3PSnmpFields(tpEl);
    updateCheckboxValue(tpEl);

    checkAndTogglePerfReporting(csEl, tpEl);
}


//If both the 'Send traps to CS' and 'Send traps to 3P' SNMP flags are unchecked, disable
//the performance reporting field
function checkAndTogglePerfReporting(csElem, tpElem) {
    if (!csElem.checked && !tpElem.checked) {
        disablePerfReporting();
    }
    else {
        enablePerfReporting();
    }
}

function enablePerfReporting() {
    $('#eventGeneration input').each(enableElement);
}

function disablePerfReporting() {
    $('#eventGeneration input').each(disableElement);
}

//validate the CS SNMP fields
function checkCSFields() {
    var result = true;
    //only validate if the 'send' flag is checked
    var isChecked = $('input[name=pg.cs.snmpTarget.sendTraps]').is(':checked');
    if (isChecked) {
        var csUserEl = $('input[name=pg.cs.snmpTarget.userName]');
        var csHostEl = $('input[name=pg.cs.snmpTarget.ipAddress]');
        var csPortEl = $('input[name=pg.cs.snmpTarget.port]');

        var privEl = $('input[name=pg.cs.snmpTarget.usePrivacy]')[0];
        var authEl = $('input[name=pg.cs.snmpTarget.useAuth]')[0];

        result = validateName(csUserEl) && result;
        result = validateName(csHostEl) && result;
        result = validateName(csPortEl) && result;
        result = validatePrivFlag(privEl, authEl) && result;
    }
    return result;
}

//validate the 3rd party SNMP community config fields
function check3PCommunityFields() {
    var result = true;
    var checked = $('input[name=pg.snmp.customTarget.sendTraps]').is(":checked");
    var isVisible = $('#customCommunityTarget').is(':visible');

    if (checked && isVisible) {
        var commEl = $('input[name=pg.snmp.communityTarget.communityName]');
        var commHostEl = $('input[name=pg.snmp.communityTarget.ipAddress]');
        var commPortEl = $('input[name=pg.snmp.communityTarget.port]');

        result = validateName(commEl) && result;
        result = validateName(commHostEl) && result;
        result = validateName(commPortEl) && result;
    }
    return result;
}

//validate the 3rd party SNMP user fields
function check3PUserFields() {
    var result = true;
    var checked = $('input[name=pg.snmp.customTarget.sendTraps]').is(":checked");
    var isVisible = $('#customUserTarget').is(':visible');

    if (checked && isVisible) {
        var tpUserEl = $('input[name=pg.snmp.userTarget.userName]');
        var tpHostEl = $('input[name=pg.snmp.userTarget.ipAddress]');
        var tpPortEl = $('input[name=pg.snmp.userTarget.port]');

        var privEl = $('input[name=pg.snmp.userTarget.usePrivacy]')[0];
        var authEl = $('input[name=pg.snmp.userTarget.useAuth]')[0];

        result = validateName(tpUserEl) && result;
        result = validateName(tpHostEl) && result;
        result = validateName(tpPortEl) && result;
        result = validatePrivFlag(privEl, authEl) && result;
    }
    return result;
}

//check if the 'Use Privacy' flag is checked, then 'Use Authorization' flag must be checked as well
function validatePrivFlag(privEl, authEl) {
    var result = true;
    if (privEl != undefined && authEl != undefined) {

        //mark the div surrounding the authEl as invalid/valid (FF has problem adding CSS to checkboxes directly)
        var divEl = $(authEl).parent('div').get(0);

        if ($(privEl).is(":checked") && ($(authEl).is(":disabled") || !$(authEl).is(":checked"))) {
            markInvalid(divEl, 'checkboxWrap-invalid');
            result = false;
        }
        else {
            markValid(divEl, 'checkboxWrap-invalid');
            result = true;
        }
    }
    return result;
}


//do any required field validation here
function validateFields() {
    var result = true;
    var isCSFieldsValid = checkCSFields();
    var is3PCommFieldsValid = check3PCommunityFields();
    var is3PUserFieldsValid = check3PUserFields();

    if (!isCSFieldsValid ||
        !is3PCommFieldsValid ||
        !is3PUserFieldsValid) {

        alertUser();
        result = false;
    }
    return result;
}

