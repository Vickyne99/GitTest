<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <title>Integration Server - Mediator Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <script src="js/jquery.js"></script>
    <script src="js/mediator.js"></script>
</head>
<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="menusection-Solutions">
    Administration &gt; Mediator Config
</div>

<div id="container">
<ul>
    <li><a href="mediator-config-edit.dsp">Edit Mediator Configuration</a></li>
</ul>

                                  <!-- MEDIATOR RUNTIME CONFIG -->

<!--
<div id="mediatorConfig" class="config">
    <table summary="Table showing Mediator runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">HTTP Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Load Balancer URL (http)</td>
            <td>%value pg.lb.http.url%</td>
        </tr>
        <tr>
            <td>Load Balancer URL (https)</td>
            <td>%value pg.lb.https.url%</td>
        </tr>
        </tbody>
    </table>
</div>
-->

                                    <!-- CS UDDI LOGIN CONFIG -->

<div id="csLoginConfig" class="config">
    <table summary="Table showing CentraSite Login config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">CentraSite Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Mediator Name</td>
            <td>%value pg.policygateway.targetName%</td>
        </tr>
        <tr>
            <td>Host Name</td>
            <td>%value pg.uddiClient.hostName%</td>
        </tr>
        <tr>
            <td>User Name</td>
            <td>%value pg.uddiClient.userName%</td>
        </tr>
		 <tr>
            <td colspan=2><input type="checkbox" name="pg.policygateway.disableCsComm" disabled readonly
                    %ifvar pg.policygateway.disableCsComm equals('false')% checked='checked' %endif%/>
                Enable CentraSite communication
            </td>
        </tr>
		<tr>
            <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.perfDataEnabled" disabled readonly
                %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true' %endif%/>
                Enable Performance Data Reporting
            </td>
        </tr>
        <tr>
            <td>Publish Interval (in minutes)</td>
            <td>%value pg.PgMenConfiguration.reportInterval%</td>
        </tr>       
        </tbody>
    </table>
</div>

<div id="eventGeneration" class="config">
      <table summary="Table to input Mediator event generation config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>Event Generation</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan=2>
                <input type="checkbox" name="pg.PgMenConfiguration.publishLifeCycleEvents" disabled readonly
                %ifvar pg.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true' %endif%/>
                    Enable Life Cycle Events
            </td>
        </tr>
        <tr>
            <td colspan=2>
               <input type="checkbox" name="pg.PgMenConfiguration.publishErrorEvents" disabled readonly
                %ifvar pg.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true' %endif%/>
                Enable Error Events
            </td>
        </tr>
        <tr>
            <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.publishPolicyViolationEvents" disabled readonly
                %ifvar pg.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
                            value='true' %endif%/>
                Enable Policy Violation Events
            </td>
        </tr>
       </tbody>
       </table>
</div>

                                <!-- KEYSTORE CONFIG -->

<div id="keystoreConfig" class="config">
    <table summary="Table showing Mediator Keystore runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">Keystore Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>IS Keystore Name</td>
            <td>
                %value pg.keystore.keyStoreHandle%
            </td>
        </tr>
        <tr>
            <td>Alias (signing)</td>
            <td>%value pg.rampartdeploymenthandler.signingCertAlias%</td>
        </tr>
        <tr>
            <td>IS Truststore Name</td>
            <td>
                %value pg.keystore.trustStoreHandle%
            </td>
        </tr>
        <!--<tr>
              <td>Alias (encryption)</td>
              <td><input name="encAlias" type="text"/></td>
          </tr>-->
        </tbody>
    </table>
</div>

                                <!-- EMAIL CONFIG -->

<div id="emailConfig" class="config">
    <table summary="Table showing Email config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">Email Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>SMTP Host Name/IP Address</td>
            <td>%value pg.email.smtpHost%</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>%value pg.email.smtpPort%</td>
        </tr>
        <tr>
            <td>User</td>
            <td>%value pg.email.userName%</td>
        </tr>
        <tr>
            <td>From</td>
            <td>%value pg.email.from%</td>
        </tr>
        <tr>
            <td colspan=2>
                <input name="tlsEnabled" id="tlsEnabled" type="checkbox" disabled readonly
                %ifvar pg.email.TLSEnabled equals('true')% checked %endif%/> TLS Enabled
            </td>
        </tr>
    </table>

</div>
                                    <!-- CS SNMP CONFIG -->

<div id="csSNMPConfig" class="config">
    <table summary="Table showing CentraSite SNMP runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">CentraSite SNMP Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Host Name/IP Address</td>
            <td>%value pg.cs.snmpTarget.ipAddress%</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>%value pg.cs.snmpTarget.port%</td>
        </tr>
        <tr>
            <td>Transport</td>
            <td>
                %value pg.cs.snmpTarget.transportProtocol%
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td>%value pg.cs.snmpTarget.userName%</td>
        </tr>
        </tbody>
    </table>
</div>

                                <!-- 3rd party / CUSTOM SNMP CONFIG -->

<div id="customSNMPConfig" class="config">
    <table summary="Table showing 3rd party SNMP target config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">3rd Party SNMP Config</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>SNMP Target Type:</td>
            <td>
                %ifvar pg.snmp.customTarget equals('communityTarget')%
                    Community
                %else if pg.snmp.customTarget equals('userTarget')%
                    User
                %endif%
            </td>
        </tr>
        </tbody>
    </table>
    <table id="customUserTarget"
             %ifvar pg.snmp.customTarget equals('communityTarget')% class='hidden' %endif%>
        <tbody>
        <tr>
            <td>Host Name/IP Address</td>
            <td>%value pg.snmp.userTarget.ipAddress%</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>%value pg.snmp.userTarget.port%</td>
        </tr>
        <tr>
            <td>Transport</td>
            <td>
                %value pg.snmp.userTarget.transportProtocol%
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td>%value pg.snmp.userTarget.userName%</td>
        </tr>
        </tbody>
    </table>
    
    <table id="customCommunityTarget"
             %ifvar pg.snmp.customTarget equals('userTarget')% class='hidden' %endif%>
        <tbody>
        <tr>
            <td>Host Name/IP Address</td>
            <td>%value pg.snmp.communityTarget.ipAddress%</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>%value pg.snmp.communityTarget.port%</td>
        </tr>
        <tr>
            <td>Transport</td>
            <td>
                %value pg.snmp.communityTarget.transportProtocol%
            </td>
        </tr>
        <tr>
            <td>Community Name</td>
            <td>%value pg.snmp.communityTarget.communityName%</td>
        </tr>
        </tbody>
    </table>
</div>

</div>

%endinvoke%
</body>
</html>
