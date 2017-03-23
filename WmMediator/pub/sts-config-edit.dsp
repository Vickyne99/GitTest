<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - STS Configuration Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <link rel="stylesheet" href="css/sts-config.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/sts-config.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Settings &gt; Edit Security Token Service (STS) Configuration
</div>
<div id="config.error">
</div>

<div>
%ifvar action equals('save')%
    %invoke pg.stsconfig:saveConfig%
        %ifvar status equals('saved')%
            <div id="saveSuccessMessage" class="message">Successfully saved STS configuration [%value name%]</div>
        %else%
            <div id="saveFailureInfo" class="message">Error occurred when saving STS configuration details. Please check the server log more information</div>
        %endif%
    %endinvoke%
%endif%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li>
            <a href="sts-config.dsp">Return</a>
        </li>
    </ul>
    <div class="required-msg">Fields marked with <span class="required">*</span> are required</div>
    <form action="sts-config-edit.dsp" method="POST">
        <div id="stsConfig" class="config">
            <table id="basicConfigTable" class="tableView">
                <thead>
                <tr>
                    <th  class="heading" colspan="2">%value name% Configuration</th>
                </tr>
                </thead>
                <tbody>
                %invoke pg.stsconfig:getConfig%
                <tr>
                    <td>Name<span class="required">*</span></td>
                    <td><input type="text" name="stsName" value="%value name%"/></td>
                </tr>
                <tr>
                    <td>Endpoint<span class="required">*</span></td>
                    <td><input class="url" type="text" name="endpoint" value="%value endpoint%"/></td>
                </tr>
                <tr>
                    <td>Token Type</td>
                    <td>
                        <select name="tokenType">
                            %loop tokenTypes%
                            <option
                            %ifvar ../tokenType vequals(tokenType)% selected %endif%/>%value tokenType%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>WS-Trust Version</td>
                    <td>
                        <select name="trustVersion">
                            %loop versions%
                            <option
                            %ifvar ../trustVersion vequals(version)% selected %endif%/>%value version%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Time-To-Live (TTL) (seconds)</td>
                    <td><input type="text" value="%value ttl%" name="ttl"/></td>
                </tr>
                <tr>
                    <td>KeyStore</td>
                    <td>
                        <select name="ksHandle">
                            %loop keystores%
                            <option
                            %ifvar ../ksHandle vequals(keystoreName)% selected %endif% />%value keystoreName%
                            %endloop%
                        </select>
                         <div id="busy"><img src="images/ajax_busy_sm.gif" alt="busy"/></div>
                    </td>
                </tr>
                %rename ../ksHandle ksName -copy%
                %invoke pg.stsconfig:getKeyStoreAliases%
                <tr>
                    <td colspan="2"><input name="isSignRequest" type="checkbox"
                        %ifvar isSignRequest equals('true')% checked='checked' value='true' %endif% />Sign Request?
                    </td>
                </tr>
                <tr>
                    <td>Signing Alias</td>
                    <td>
                        <select name="signingAlias">
                            %loop pkAliases%
                            <option
                            %ifvar ../signingAlias vequals(alias)% selected %endif% />%value alias%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input name="isEncRequest" type="checkbox"
                        %ifvar isEncRequest equals('true')% checked='checked' value='true' %endif% />Encrypt Request?
                    </td>
                </tr>
                <tr>
                    <td>Encryption Alias</td>
                    <td>
                        <select name="encryptionAlias">
                            %loop certAliases%
                            <option
                            %ifvar ../encryptionAlias vequals(alias)% selected %endif%/>%value alias%
                            %endloop%
                        </select>
                    </td>
                </tr>
                %endinvoke getKeyStoreAliases%

                </tbody>
            </table>
            <table id="httpAuthTable" class="tableView">
                <thead>
                <tr>
                    <th  class="heading" colspan="2">HTTP Basic Authentication</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Username</td>
                    <td><input type="text" name="httpUser" value="%value httpUser%"></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="httpPwd" value=""></td>
                </tr>
                </tbody>
            </table>
            <table id="usernameTokenTable" class="tableView">
                <thead>
                <tr>
                    <th  class="heading" colspan="2">WS-Security Username Token</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Username</td>
                    <td><input type="text" name="wsUser" value="%value wsUser%"></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="wsPwd" value=""></td>
                </tr>
                <tr>
                    <td>Password Type</td>
                    <td>
                        <select name="wsPwdType">
                            %loop pwdTypes%
                              <option %ifvar ../wsPwdType vequals(pwdType)% selected %endif% value=%value pwdType%>
                                %value pwdTypeDisplay%</option>
                            %endloop%
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
            %endinvoke getConfig%
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

        <input type ="hidden" name="name" value="%value name%"/>
        <input type="hidden" id="action" name="action" value="save"/>
        
    </form>

</div>
</div>
</body>
</html>