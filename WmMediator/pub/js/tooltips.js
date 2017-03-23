/* Auto-generated text file from Localization Framework 7.7.5.2 Version=910apr2016 Locale= DO NOT EDIT BY HAND! */

/**
 * Refer to http://docs.jquery.com/Plugins/Tooltip for description of tooltip options
 */
$(function() {

    $('td input, td select').addClass('showDesc');

    $('.showDesc').each(function() {
        var desc = tooltips[this.name];
        $(this).attr('title', desc);
        $(this).tooltip({delay:500});
    });
});

var tooltips = {

    "pg.keystore.trustStoreHandle": "IS configured truststore handle",
    "pg.cs.snmpTarget.privKey": "CentraSite SNMP privacy key",
    "check.pg.wrapperFactory.password": "Confirm Password for the above CentraSite username",
    "pg.PgMenConfiguration.reportInterval": "Performance data reporting interval in minutes",
    "pg.cs.snmpTarget.transportProtocol": "SNMP transport protocol",
    "pg.snmp.communityTarget.ipAddress": "3rd party SNMP community Host name / IP address",
    "pg.wrapperFactory.password": "Password for the above CentraSite username",
    "pg.policygateway.targetName": "Mediator/Target name configured in CentraSite",
    "check.pg.email.password": "Confirm SMTP user password",
    "pg.snmp.userTarget.useAuth": "Enable/Disable Authorization for 3rd party SNMP (required if \'Use Privacy\' is checked)",
    "pg.cs.snmpTarget.userName": "CentraSite SNMP user name",
    "pg.lb.http.url": "The HTTP Load Balancer URL",
    "pg.email.smtpPort": "SMTP host port number",
    "pg.snmp.customTarget": "3rd party SNMP target type flag (user / community)",
    "pg.PgMenConfiguration.publishPolicyViolationEvents": "Enable/disable publishing policy violation events to CentraSite",
    "pg.snmp.userTarget.port": "3rd party SNMP port number",
    "pg.email.smtpHost": "SMTP Host name/ IP address",
    "pg.cs.snmpTarget.port": "CentraSite SNMP port number",
    "pg.email.userName": "SMTP account username",
    "pg.snmp.userTarget.userName": "3rd party SNMP username",
    "pg.cs.snmpTarget.sendTraps": "Enable/disable sending SNMP Traps to CentraSite",
    "pg.email.TLSEnabled": "Enable/disable Transport-Layer Security",
    "pg.cs.snmpTarget.authKey": "CentraSite SNMP authorization key",
    "pg.PgMenConfiguration.publishLifeCycleEvents": "Enable/disable publishing Lifecycle events to CentraSite",
    "pg.PgMenConfiguration.perfDataEnabled": "Enable/disable performance data collection",
    "pg.lb.https.url": "The HTTPS Load Balancer URL",
    "check.pg.cs.snmpTarget.privKey": "Confirm CentraSite SNMP privacy key",
    "pg.keystore.keyStoreHandle": "IS configured keystore handle",
    "pg.snmp.userTarget.ipAddress": "3rd party SNMP Host name / IP address",
    "pg.cs.snmpTarget.usePrivacy": "Enable/Disable Privacy for CS SNMP",
    "check.pg.snmp.userTarget.authKey": "Confirm 3rd party SNMP authorization key",
    "pg.PgMenConfiguration.publishErrorEvents": "Enable/disable publishing error events to CentraSite",
    "pg.email.password": "SMTP user password",
    "pg.snmp.communityTarget.transportProtocol": "3rd party SNMP transport protocol",
    "pg.snmp.communityTarget.communityName": "3rd party SNMP community name",
    "pg.cs.snmpTarget.useAuth": "Enable/Disable Authorization for CS SNMP (required if \'Use Privacy\' is checked)",
    "pg.snmp.customTarget.sendTraps": "Enable/disable sending SNMP Traps to 3rd party SNMP receiver",
    "pg.wrapperFactory.userName": "CentraSite user name",
    "pg.rampartdeploymenthandler.signingCertAlias": "Keystore alias to use for signing responses from Mediator to client",
    "pg.snmp.userTarget.authKey": "3rd party SNMP authorization key",
    "pg.email.from": "From email address",
    "pg.wrapperFactory.hostName": "Host name or IP Address of CentraSite",
    "pg.snmp.communityTarget.port": "3rd party SNMP community port",
    "check.pg.snmp.userTarget.privKey": "Confirm 3rd party SNMP privacy key",
    "pg.cs.snmpTarget.ipAddress": "CentraSite SNMP Host name / IP Address",
    "pg.snmp.userTarget.transportProtocol": "3rd party SNMP transport protocol",
    "pg.policygateway.disableCsComm": "Enable/disable communication with CentraSite",
    "pg.snmp.userTarget.usePrivacy": "Enable/Disable Privacy for 3rd party SNMP",
    "pg.snmp.userTarget.privKey": "3rd party SNMP privacy key",
    "check.pg.cs.snmpTarget.authKey": "Confirm CentraSite SNMP authorization key",
    "pg.uddiClient.password": "Password for the above CentraSite username",
    "pg.uddiClient.hostName": "Host name or IP Address of CentraSite",
    "check.pg.uddiClient.password": "Confirm Password for the above CentraSite username",
    "pg.uddiClient.userName": "CentraSite user name"

};
