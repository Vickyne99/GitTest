<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - SNMP Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
</head>

<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; SNMP Configuration
</div>

<ul>
	<li><a href="snmp-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">
    

    <!-- CS SNMP CONFIG -->

    <div id="csSNMPConfig" class="config">
        <table summary="CentraSite SNMP runtime config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">CentraSite SNMP Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.cs.snmpTarget.sendTraps" disabled readonly
                    %ifvar pg.cs.snmpTarget.sendTraps equals('true')% checked='checked' %endif%/>
                    Send TRAPs to CentraSite
                </td>
            </tr>
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
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.cs.snmpTarget.useAuth" disabled readonly
                    %ifvar pg.cs.snmpTarget.useAuth equals('true')% checked='checked' %endif%/>
                    Use Authorization
                </td>
            </tr>
             <tr>
                <td>Authorization Protocol</td>
                <td>%value pg.cs.snmpTarget.authProtocol%</td>
            </tr>
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.cs.snmpTarget.usePrivacy" disabled readonly
                    %ifvar pg.cs.snmpTarget.usePrivacy equals('true')% checked='checked' %endif%/>
                    Use Privacy
                </td>
            </tr>
              <tr>
                <td>Privacy Protocol</td>
                <td>%value pg.cs.snmpTarget.privProtocol%</td>
            </tr>
            </tbody>
        </table>
    </div>

    <!-- 3rd party / CUSTOM SNMP CONFIG -->

    <div id="customSNMPConfig" class="config">
        <table summary="3rd party SNMP target config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">3rd Party SNMP Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.snmp.customTarget.sendTraps" disabled readonly
                    %ifvar pg.snmp.customTarget.sendTraps equals('true')% checked='checked' %endif%/>
                    Send TRAPs to 3rd party SNMP Server
                </td>
            </tr>
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

		<div %ifvar pg.snmp.customTarget equals('communityTarget')% class='hidden' %endif%>
			<table id="customUserTarget" class="tableView">
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
				<tr>
					<td colspan="2"><input type="checkbox" name="pg.snmp.userTarget.useAuth" disabled readonly
						%ifvar pg.snmp.userTarget.useAuth equals('true')% checked='checked' %endif%/>
						Use Authorization
					</td>
				</tr>
				<tr>
					<td>Authorization Protocol</td>
					<td>%value pg.snmp.userTarget.authProtocol%</td>
				</tr>
				<tr>
					<td colspan="2"><input type="checkbox" name="pg.snmp.userTarget.usePrivacy" disabled readonly
						%ifvar pg.snmp.userTarget.usePrivacy equals('true')% checked='checked' %endif%/>
						Use Privacy
					</td>
				</tr>
				 <tr>
					<td>Privacy Protocol</td>
					<td>%value pg.snmp.userTarget.privProtocol%</td>
				</tr>
				</tbody>
			</table>
		</div>

		<div %ifvar pg.snmp.customTarget equals('userTarget')% class='hidden' %endif%>
			<table id="customCommunityTarget" class="tableView">
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

    <div id="eventGeneration" class="config">
        <table summary="Mediator event generation config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">
                    <span>Event Generation</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Publish Events:</td>
                <td>
                    <input type="checkbox" name="pg.PgMenConfiguration.publishLifeCycleEvents" disabled readonly
                    %ifvar pg.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Lifecycle

                    <input type="checkbox" name="pg.PgMenConfiguration.publishErrorEvents" disabled readonly
                    %ifvar pg.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Error

                    <input type="checkbox" name="pg.PgMenConfiguration.publishPolicyViolationEvents" disabled readonly
                    %ifvar pg.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
                    value='true' %endif%/>
                    Policy Violation
                </td>
            </tr>
            </tbody>
        </table>
    </div>

</div>
%endinvoke%

</body>
</html>