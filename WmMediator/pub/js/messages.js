/* Auto-generated text file from Localization Framework 7.7.5.2 Version=910apr2016 Locale= DO NOT EDIT BY HAND! */

String.prototype.format = function(args) {
    var txt = this, i = args.length;
    while (i--) {
        txt = txt.replace(new RegExp('\\{' + i + '\\}', 'gm'), args[i]);
    }
    return txt;
};

/**
 * arg1 = msg key
 * arg2..n = msg params
 */
function getmsg() {
    var msg = messages[arguments[0]];
    if (msg == undefined) {
        msg = messages["missing.msg"];
        arguments[1] = arguments[0];
    }
    if (arguments.length > 1) {
       var args = [];
       for (var i=1; i<arguments.length; i++) args.push(arguments[i]);
       msg = msg.format(args);
    }
    return msg;
}

var messages = {

    "interval.invalid": "Invalid Performance Interval",
    "eda.no.destination": "Please select atleast one destination for EDA",
    "apiportal.delete.config": "Are you sure you want to delete this API Portal configuration?",
    "url.invalid": "URL is invalid (should be http(s))",
    "pwd.wrong.len": "Password length must be >= {0} characters!",
    "testing": "Testing...",
    "saving": "Saving...",
    "port.remove.error": "Cannot remove primary HTTP port [{0}]. Mediator is always available on the primary port",
    "save": "Save",
    "config.error": "There are configuration errors in the form. Required fields are highlighted.\nPlease correct them and try again! ",
    "delete.config": "Are you sure you want to delete this STS configuration?",
    "pwd.no.match": "Passwords don\'t match!",
    "missing.msg": "Missing message key [{0}]!",
    "pjs1": "missing.msg",
    "sts.name.missing": "STS name must be specified",
    "sts.name.bad.char": "STS name contains an illegal character \'{0}\'",
    "sts.epr.missing": "STS Endpoint value must be specified",
    "username.bad.char": "Username contains an illegal character \'{0}\'",
    "port.invalid": " is not a valid port number!"

};
