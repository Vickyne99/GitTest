//validate the given jquery element using the optional regex expression to match;
//if regex is not provided, check if value of element is ''; if result is false mark invalid,
//else mark as valid
function validateName(jqObj) {
    var isValid = true;
    var val = jqObj.val();
//	alert('val ' +val);
    var regxObj = arguments[1];
	//alert('regxObj ='+regxObj);
    if (regxObj != undefined && regxObj != null) {
        isValid = regxObj.test(val);
    }
    else isValid = ($.trim(val) != '');
	//alert('isValid' +isValid);
    if (isValid) {
        markValid(jqObj);
    } else {
        markInvalid(jqObj);
    }
    return isValid;
}

//utility function that disables the given field; also resets the field if previously marked invalid
function disableField(index, el) {
    markValid(el);
    disableElement(index, el);
}

//mark the given dom element as invalid by adding optional 2nd argument css class or 'invalid'
function markInvalid(el) {
    var cssClass = arguments[1];
    if (cssClass == undefined || cssClass == null) cssClass = 'invalid';
    if (el != undefined && el != null) {
        $(el).addClass(cssClass);
    }
}

//mark the given dom element as valid by removing the optional 2nd argument css class or 'invalid'
function markValid(el) {
    var cssClass = arguments[1];
    if (cssClass == undefined || cssClass == null) cssClass = 'invalid';
    if (el != undefined && el != null) {
        $(el).removeClass(cssClass);
    }
}