<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - SNMP Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/snmp-config.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/snmp-config.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; SNMP Configuration
</div>
<div id="config.error">
</div>

<div>
%ifvar action equals('save')%
    %invoke pg.UIConfig:saveConfigProps%
        %ifvar messages -notempty%
           <div id="saveFailureInfo" class="message">
              <span>Following errors were reported during save:</span>
              <ul>
              %loop messages%
                    <li>%value message%</li>
              %endloop%
              </ul>
           </div>
        %else%
           <div id="saveSuccessMessage" class="message">
               <span>Successfully saved Mediator configuration!</span>
           </div>
        %endif%
    %endinvoke%
%endif%

%invoke pg.UIConfig:getConfigProps%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li>
            <a href="snmp-config.dsp">Return</a>
        </li>
    </ul>
<div class="required-msg">Fields marked with <span class="required">*</span> are required</div>
<form action="snmp-config-edit.dsp" method="post">
	<input type="hidden" id="form-tag" name="form-tag" value="snmp-config-edit"/>
    <div id="csSNMPConfig" class="config">
        <table summary="CentraSite SNMP runtime config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">
                    <span>CentraSite SNMP Configuration</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.cs.snmpTarget.sendTraps" id="toggle-cs-snmp"
                    %ifvar pg.cs.snmpTarget.sendTraps equals('true')% checked='checked' %endif%/>
                    Send TRAPs to CentraSite
                </td>
            </tr>
            <tr>
                <td>Host Name/IP Address<span class="required">*</span></td>
                <td><input type="text" name="pg.cs.snmpTarget.ipAddress" class="url"
                           value="%value pg.cs.snmpTarget.ipAddress%"/></td>
            </tr>
            <tr>
                <td>Port<span class="required">*</span></td>
                <td><input name="pg.cs.snmpTarget.port" type="text"
                           value="%value pg.cs.snmpTarget.port%"/></td>
            </tr>
            <tr>
                <td>Transport</td>
                <td>
                    <select name="pg.cs.snmpTarget.transportProtocol">
                        <option
                        %ifvar pg.cs.snmpTarget.transportProtocol equals('tcp')% selected %endif% value="tcp"/>TCP
                        <option
                        %ifvar pg.cs.snmpTarget.transportProtocol equals('udp')% selected %endif% value="udp"/>UDP
                    </select>
                </td>
            </tr>
            <tr>
                <td>User Name<span class="required">*</span></td>
                <td><input name="pg.cs.snmpTarget.userName" type="text"
                           value="%value pg.cs.snmpTarget.userName%"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="checkboxWrap">
                        <input id="csUseAuth" type="checkbox" name="pg.cs.snmpTarget.useAuth" disabled readonly
                    %ifvar pg.cs.snmpTarget.useAuth equals('true')% checked='checked' %endif%/>
                    </div>
                    Use Authorization
                </td>
            </tr>
            <tr>
                <td>Authorization Password</td>
                <td><input name="pg.cs.snmpTarget.authKey" type="password" value=""/></td>
            </tr>
             <tr>
                <td>Retype Authorization Password</td>
                <td>
                    <div id="check-cs-auth-pwd">
                        <input name="check.pg.cs.snmpTarget.authKey" type="password" value=""/>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Authorization Protocol</td>
                <td>
                    <select name="pg.cs.snmpTarget.authProtocol">
                       <option %ifvar pg.cs.snmpTarget.authProtocol equals('MD5')% selected %endif%/>MD5
                       <option %ifvar pg.cs.snmpTarget.authProtocol equals('SHA')% selected %endif%/>SHA
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="checkboxWrap">
                        <input id="csUsePriv" type="checkbox" name="pg.cs.snmpTarget.usePrivacy" disabled readonly
                        %ifvar pg.cs.snmpTarget.usePrivacy equals('true')% checked='checked' %endif%/>
                    </div>
                    Use Privacy
                </td>
            </tr>
            <tr>
                <td>Privacy Password</td>
                <td><input name="pg.cs.snmpTarget.privKey" type="password" value=""/></td>
            </tr>
            <tr>
                <td>Retype Privacy Password</td>
                <td>
                    <div id="check-cs-priv-pwd">
                        <input name="check.pg.cs.snmpTarget.privKey" type="password" value=""/>
                    </div>
                </td>
            </tr>
             <tr>
                <td>Privacy Protocol</td>
                <td>
                    <select name="pg.cs.snmpTarget.privProtocol">
                       <option %ifvar pg.cs.snmpTarget.privProtocol equals('DES')% selected %endif%/>DES
                       <option %ifvar pg.cs.snmpTarget.privProtocol equals('AES128')% selected %endif%/>AES128
                       <option %ifvar pg.cs.snmpTarget.privProtocol equals('AES192')% selected %endif%/>AES192
                       <option %ifvar pg.cs.snmpTarget.privProtocol equals('AES256')% selected %endif%/>AES256
                    </select>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <!-- 3rd party / CUSTOM SNMP CONFIG -->

    <div id="customSNMPConfig" class="config">
        <table summary="3rd party SNMP target config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">
                    <span>3rd Party SNMP Configuration</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2"><input type="checkbox" name="pg.snmp.customTarget.sendTraps" id="toggle-3p-snmp"
                    %ifvar pg.snmp.customTarget.sendTraps equals('true')% checked='checked' %endif%/>
                    Send TRAPs to 3rd party SNMP Server
                </td>
            </tr>
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

		<p style="display:inline" %ifvar pg.snmp.customTarget equals('communityTarget')% class='hidden' %endif%>
			<table id="customUserTarget" class="tableView">
			<tbody>
			<tr>
				<td>Host Name/IP Address<span class="required">*</span></td>
				<td>
					<input class="url" name="pg.snmp.userTarget.ipAddress" type="text"
						   value="%value pg.snmp.userTarget.ipAddress%"/>
				</td>
			</tr>
			<tr>
				<td>Port<span class="required">*</span></td>
				<td><input name="pg.snmp.userTarget.port" type="text" value="%value pg.snmp.userTarget.port%"/></td>
			</tr>
			<tr>
				<td>Transport</td>
				<td>
					<select name="pg.snmp.userTarget.transportProtocol">
						<option
						%ifvar pg.snmp.userTarget.transportProtocol equals('tcp')% selected %endif% value="tcp"/>TCP
						<option
						%ifvar pg.snmp.userTarget.transportProtocol equals('udp')% selected %endif% value="udp"/>UDP
					</select>
				</td>
			</tr>
			<tr>
				<td>User Name<span class="required">*</span></td>
				<td>
					<input name="pg.snmp.userTarget.userName" type="text" value="%value pg.snmp.userTarget.userName%"/>
				</td>
			</tr>
			 <tr>
				<td colspan="2">
					<div class="checkboxWrap">
						<input id="3pUseAuth" type="checkbox" name="pg.snmp.userTarget.useAuth" disabled readonly
								%ifvar pg.snmp.userTarget.useAuth equals('true')% checked='checked' %endif%/>
					</div>
					Use Authorization
				</td>
			</tr>
			<tr>
				<td>Authorization Password</td>
				<td>
					 <input name="pg.snmp.userTarget.authKey" type="password" value=""/>
				</td>
			</tr>
			  <tr>
				<td>Retype Authorization Password</td>
				<td>
				   <div id="check-3p-auth-pwd">
						<input name="check.pg.snmp.userTarget.authKey" type="password" value=""/>
					</div>
				</td>
			</tr>
			<tr>
				<td>Authorization Protocol</td>
				<td>
					<select name="pg.snmp.userTarget.authProtocol">
					   <option %ifvar pg.snmp.userTarget.authProtocol equals('MD5')% selected %endif%/>MD5
					   <option %ifvar pg.snmp.userTarget.authProtocol equals('SHA')% selected %endif%/>SHA
					</select>
				</td>
			</tr>
			<tr>
				 <td colspan="2">
					 <div class="checkboxWrap">
						 <input id="3pUsePriv" type="checkbox" name="pg.snmp.userTarget.usePrivacy" disabled readonly
						 %ifvar pg.snmp.userTarget.usePrivacy equals('true')% checked='checked' %endif%/>
					 </div>
					 Use Privacy
				 </td>
			</tr>
			<tr>
			<td>Privacy Password</td>
				<td>
					<input name="pg.snmp.userTarget.privKey" type="password" value=""/>
				</td>
			</tr>
			 <tr>
				<td>Retype Privacy Password</td>
				<td>
				   <div id="check-3p-priv-pwd">
						<input name="check.pg.snmp.userTarget.privKey" type="password" value=""/>
					</div>
				</td>
			</tr>
			 <tr>
				<td>Privacy Protocol</td>
				<td>
					<select name="pg.snmp.userTarget.privProtocol">
					   <option %ifvar pg.snmp.userTarget.privProtocol equals('DES')% selected %endif%/>DES
					   <option %ifvar pg.snmp.userTarget.privProtocol equals('AES128')% selected %endif%/>AES128
					   <option %ifvar pg.snmp.userTarget.privProtocol equals('AES192')% selected %endif%/>AES192
					   <option %ifvar pg.snmp.userTarget.privProtocol equals('AES256')% selected %endif%/>AES256
					</select>
				</td>
			   </tr>
			</tbody>
			</table>
		</p>
		
		<p style="display:inline" %ifvar pg.snmp.customTarget equals('userTarget')% class='hidden' %endif%>
			<table id="customCommunityTarget" class="tableView">
			<tbody>
			<tr>
				<td>Host Name/IP Address<span class="required">*</span></td>
				<td>
					<input class="url" name="pg.snmp.communityTarget.ipAddress" type="text"
						   value="%value pg.snmp.communityTarget.ipAddress%"/>
				</td>
			</tr>
			<tr>
				<td>Port<span class="required">*</span></td>
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
				<td>Community Name<span class="required">*</span></td>
				<td>
					<input name="pg.snmp.communityTarget.communityName" type="text"
						   value="%value pg.snmp.communityTarget.communityName%"/>
				</td>
			</tr>
			</tbody>
			</table>
		</p>

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
                    <input type="checkbox" name="pg.PgMenConfiguration.publishLifeCycleEvents"
                    %ifvar pg.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Lifecycle

                    <input type="checkbox" name="pg.PgMenConfiguration.publishErrorEvents"
                    %ifvar pg.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Error

                    <input type="checkbox" name="pg.PgMenConfiguration.publishPolicyViolationEvents"
                    %ifvar pg.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
                    value='true' %endif%/>
                    Policy Violation
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div id="formButtons">
        	<table class="tableView">
				<tr>
					<td class="action" colspan="3">
						<input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
					</td>
				</tr>
			</table>
    </div>

    <input type="hidden" id="action" name="action" value="save"/>

</form>
</div>
</div>
%endinvoke%

</body>
</html>