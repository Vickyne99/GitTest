<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Integration Server - Mediator Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/jquery.tooltip.css" type="text/css"/>
    <script src="js/jquery.js"></script>
    <script src="js/mediator.js"></script>
    <script src="js/jquery.tooltip.js"></script>
    <script src="js/tooltips.js"></script>
</head>
<body>

<div id="heading" class="menusection-Solutions">
    Administration &gt; Edit Mediator Config
</div>
<div id="config.error">
</div>

<div id="container">
%ifvar action equals('save')%
    %invoke pg.UIConfig:saveConfigProps%
     <div class="message">
         %ifvar messages -notempty%
              <span>Following errors were reported during save:</span><br>
              %loop messages%
                    <span>%value message%</span>
              %endloop%
         %else%
               <span>Successfully saved Mediator configuration!</span>
         %endif%
     </div>
    %endinvoke%
%endif%
%invoke pg.UIConfig:getConfigProps%

<ul>
    <li><a href="mediator-config.dsp">Return to Mediator Home</a></li>
</ul>

<form action="mediator-config-edit.dsp" method="post">
<!--<div id="mediatorConfig" class="config">
    <table summary="Table to input Mediator runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>HTTP Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Load Balancer URL (HTTP)</td>
            <td><input class="url" name="pg.lb.http.url" type="text" value="%value pg.lb.http.url%"/></td>
        </tr>
        <tr>
            <td>Load Balancer URL (HTTPS)</td>
            <td><input class="url" name="pg.lb.https.url" type="text" value="%value pg.lb.https.url%"/></td>
        </tr>
        </tbody>
    </table>
</div>-->


<div id="csLoginConfig" class="config">
    <table summary="Table to input CentraSite Login config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>CentraSite Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Mediator Name</td>
            <td><input name="pg.policygateway.targetName" type="text"
                    value ="%value pg.policygateway.targetName%"/></td>
        </tr>
        <tr>
            <td>Host Name</td>
            <td><input class="url" name="pg.uddiClient.hostName" type="text"
                       value="%value pg.uddiClient.hostName%"/></td>
        </tr>
        <tr>
            <td>User Name</td>
            <td><input name="pg.uddiClient.userName" type="text"
                       value="%value pg.uddiClient.userName%"/></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input name="pg.uddiClient.password" type="password" value=""/></td>
        </tr>
		 <tr>
            <td colspan=2><input type="checkbox" name="pg.policygateway.disableCsComm"
                %ifvar pg.policygateway.disableCsComm equals('false')% checked='checked' value='false' %endif%/>
                Enable CentraSite communication
            </td>
        </tr>
		<tr>
            <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.perfDataEnabled"
                %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true' %endif%/>
                Enable Performance Data Reporting
            </td>
        </tr>
        <tr>
            <td>Publish Interval (in minutes)</td>
            <td>
                <div id="report-interval">
                    <input name="pg.PgMenConfiguration.reportInterval" type="text"
                           value="%value pg.PgMenConfiguration.reportInterval%"/>
                    <span class="hidden">Interval must be between 1 and 60</span>
                </div>
            </td>
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
                <input type="checkbox" name="pg.PgMenConfiguration.publishLifeCycleEvents"
                %ifvar pg.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true' %endif%/>
                    Enable Life Cycle Events
            </td>
        </tr>
        <tr>
            <td colspan=2>
               <input type="checkbox" name="pg.PgMenConfiguration.publishErrorEvents"
                %ifvar pg.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true' %endif%/>
                Enable Error Events
            </td>
        </tr>
        <tr>
            <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.publishPolicyViolationEvents"
                %ifvar pg.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
                            value='true' %endif%/>
                Enable Policy Violation Events
            </td>
        </tr>
       </tbody>
       </table>
</div>

<div id="keystoreConfig" class="config">
    <table summary="Table to input Mediator Keystore runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>Keystore Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>IS Keystore Name</td>
            <td>
                <select name="pg.keystore.keyStoreHandle">
                    %invoke pg.UIConfig:getKeystoreNames%
                        %loop keyStoreNames%
                            <option %ifvar ../pg.keystore.keyStoreHandle vequals(name)% selected %endif% />%value name%
                        %endloop%
                    %endinvoke%
                </select>
            </td>
        </tr>
        <tr>
            <td>Alias (signing)</td>
            <td>
                <select name="pg.rampartdeploymenthandler.signingCertAlias">
                    %invoke pg.UIConfig:getAliases%
                        %loop aliasNames%
                            <option %ifvar ../pg.rampartdeploymenthandler.signingCertAlias vequals(name)%
                                    selected %endif% />%value name%
                        %endloop%
                    %endinvoke%
                </select>

                <div id="busy"><img src="images/ajax_busy_sm.gif"/></div>
            </td>
        </tr>
        <tr>
            <td>IS Truststore Name</td>
            <td>
                <select name="pg.keystore.trustStoreHandle">
                    %invoke pg.UIConfig:getTrustStoreNames%
                        %loop trustStoreNames%
                            <option %ifvar ../pg.keystore.trustStoreHandle vequals(name)% selected %endif% />%value name%
                        %endloop%
                    %endinvoke%
                </select>
            </td>
        </tr>
        </tbody>
    </table>
</div>


<div id="emailConfig" class="config">
    <table summary="Table to input Email config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>Email Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>SMTP Host Name/IP Address</td>
            <td><input class="url" name="pg.email.smtpHost" type="text" value="%value pg.email.smtpHost%"/></td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input name="pg.email.smtpPort" type="text" value="%value pg.email.smtpPort%"/></td>
        </tr>
        <tr>
            <td>User</td>
            <td><input name="pg.email.userName" type="text" value="%value pg.email.userName%"/></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input name="pg.email.password" type="password" value=""/></td>
        </tr>
        <tr>
            <td>From</td>
            <td><input name="pg.email.from" type="text" value="%value pg.email.from%"/></td>
        </tr>
        <tr>
            <td colspan=2><input name="pg.email.TLSEnabled" type="checkbox"
                %ifvar pg.email.TLSEnabled equals('true')% checked='checked' value='true' %endif%/> TLS Enabled
            </td>
        </tr>
        </tbody>
    </table>
</div>


<div id="csSNMPConfig" class="config">
    <table summary="Table to input SNMP runtime config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>CentraSite SNMP Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Host Name/IP Address</td>
            <td><input class="url" name="pg.cs.snmpTarget.ipAddress" type="text"
                       value="%value pg.cs.snmpTarget.ipAddress%"/></td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input name="pg.cs.snmpTarget.port" type="text"
                       value="%value pg.cs.snmpTarget.port%"/></td>
        </tr>
        <tr>
            <td>Transport</td>
            <td>
                <select name="pg.cs.snmpTarget.transportProtocol">
                    <option %ifvar pg.cs.snmpTarget.transportProtocol equals('tcp')% selected %endif% value="tcp"/>TCP
                    <option %ifvar pg.cs.snmpTarget.transportProtocol equals('udp')% selected %endif% value="udp"/>UDP
                </select>
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td><input name="pg.cs.snmpTarget.userName" type="text"
                       value="%value pg.cs.snmpTarget.userName%"/></td>
        </tr>
        <tr>
            <td>Authorization Password</td>
            <td><input name="pg.cs.snmpTarget.authKey" type="password" value=""/></td>
        </tr>
        <tr>
            <td>Privilege Password</td>
            <td><input name="pg.cs.snmpTarget.privKey" type="password" value=""/></td>
        </tr>
        </tbody>
    </table>
</div>


<!-- 3rd party / CUSTOM SNMP CONFIG -->

<div id="customSNMPConfig" class="config">
    <table summary="Table showing 3rd party SNMP target config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">
                <span>3rd Party SNMP Config</span>
            </th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>SNMP Target Type</td>
            <td>
                <input id="userRadio" type="radio" name="pg.snmp.customTarget"
                        %ifvar pg.snmp.customTarget equals('userTarget')% checked='checked' value='userTarget' %endif% />
                <label for="userRadio">User</label>

                <input id="communityRadio" type="radio" name="pg.snmp.customTarget"
                     %ifvar pg.snmp.customTarget equals('communityTarget')% checked='checked' value='communityTarget'
                        %endif%/>
                <label for="communityRadio">Community</label>
            </td>
        </tr>
        </tbody>
    </table>

    <table id="customUserTarget"
    %ifvar pg.snmp.customTarget equals('communityTarget')% class='hidden' %endif%>
    <tbody>
    <tr>
        <td>Host Name/IP Address</td>
        <td>
            <input class="url" name="pg.snmp.userTarget.ipAddress" type="text"
                   value="%value pg.snmp.userTarget.ipAddress%"/>
        </td>
    </tr>
    <tr>
        <td>Port</td>
        <td><input name="pg.snmp.userTarget.port" type="text" value="%value pg.snmp.userTarget.port%"/></td>
    </tr>
    <tr>
        <td>Transport</td>
        <td>
            <select name="pg.snmp.userTarget.transportProtocol">
                <option %ifvar pg.snmp.userTarget.transportProtocol equals('tcp')% selected %endif% value="tcp"/>TCP
                <option %ifvar pg.snmp.userTarget.transportProtocol equals('udp')% selected %endif% value="udp"/>UDP
            </select>
        </td>
    </tr>
    <tr>
        <td>User Name</td>
        <td>
            <input name="pg.snmp.userTarget.userName" type="text" value="%value pg.snmp.userTarget.userName%"/>
        </td>
    </tr>
    <tr>
        <td>Authorization Password</td>
        <td>
            <input name="pg.snmp.userTarget.authKey" type="password" value=""/>
        </td>
    </tr>
    <tr>
        <td>Privilege Password</td>
        <td>
            <input name="pg.snmp.userTarget.privKey" type="password" value=""/>
        </td>
    </tr>
    </tbody>
    </table>

    <table id="customCommunityTarget"
    %ifvar pg.snmp.customTarget equals('userTarget')% class='hidden' %endif% >
    <tbody>
    <tr>
        <td>Host Name/IP Address</td>
        <td>
            <input class="url" name="pg.snmp.communityTarget.ipAddress" type="text"
                   value="%value pg.snmp.communityTarget.ipAddress%"/>
        </td>
    </tr>
    <tr>
        <td>Port</td>
        <td>
            <input name="pg.snmp.communityTarget.port" type="text"
                   value="%value pg.snmp.communityTarget.port%"/>
        </td>
    </tr>
    <tr>
        <td>Transport</td>
        <td>
            <select name="pg.snmp.communityTarget.transportProtocol">
                <option
                %ifvar pg.snmp.communityTarget.transportProtocol equals('tcp')% selected %endif% value="tcp"/>TCP
                <option
                %ifvar pg.snmp.communityTarget.transportProtocol equals('udp')% selected %endif% value="udp"/>UDP
            </select>
        </td>
    </tr>
    <tr>
        <td>Community Name</td>
        <td>
            <input name="pg.snmp.communityTarget.communityName" type="text"
                   value="%value pg.snmp.communityTarget.communityName%"/>
        </td>
    </tr>
    </tbody>
    </table>
    <div id="formButtons">
        <input type="submit" name="btnSubmit" id="btnSubmit" value="Save Changes"/>
    </div>
</div>

<div class="saving">Saving...</div>
<input type="hidden" id="action" name="action" value="save"/>

</form>
%endinvoke%

</div>
</body>
</html>
