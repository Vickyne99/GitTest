<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - CentraSite Communication Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
	<link rel="stylesheet" href="css/snmp-config.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/centrasite-config.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; CentraSite UDDI Publish Configuration
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
        <li><a href="centrasite-config.dsp">Return</a></li>
    </ul>

    <!-- CS UDDI LOGIN CONFIG -->
    <div class="required-msg">Fields marked with <span class="required">*</span> are required</div>
    <form action="centrasite-config-edit.dsp" method="post">
    	<input type="hidden" id="form-tag" name="form-tag" value="centrasite-config-edit"/>
        <div id="csLoginConfig" class="config">
            <table summary="CentraSite Login config information" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">CentraSite UDDI Publish Configuration</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Protocol</td>
                    <td>
                        <input id="httpProtocol" type="radio" name="pg.uddiClient.protocol"
                        %ifvar pg.uddiClient.protocol equals('http')% checked='checked' %endif% value='http' />
                        <label for="httpProtocol">HTTP</label>

                        <input id="httpsProtocol" type="radio" name="pg.uddiClient.protocol"
                        %ifvar pg.uddiClient.protocol equals('https')% checked='checked' %endif% value='https'/>
                        <label for="httpsProtocol">HTTPS</label>
                    </td>
                </tr>
                <tr>
                    <td>Host Name</td>
                    <td><input class="url" name="pg.uddiClient.hostName" type="text"
                               value="%value pg.uddiClient.hostName%"/></td>
                </tr>
                <tr>
                    <td>Target Name<span class="required">*</span></td>
                    <td><input name="pg.policygateway.targetName" type="text" class="url"
                               value="%value pg.policygateway.targetName%"/></td>
                </tr>
                <tr>
                    <td>UDDI Port</td>
                    <td><input type="text" name="pg.uddiClient.uddiPort"
                               value="%value pg.uddiClient.uddiPort%"/></td>
                </tr>
                <tr>
                    <td>User Name</td>
                    <td><input name="pg.uddiClient.userName" type="text"
                               value="%value pg.uddiClient.userName%"/></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input name="pg.uddiClient.password" type="password"
                        %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% id="password1"/>
                    </td>
                </tr>
                <tr>
                    <td>Retype Password</td>
                    <td>
                        <div id="cs-password">
                            <input name="check.pg.uddiClient.password" type="password"
                            %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% id="password2"/>
                            <span class="hidden">Passwords don't match!</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.perfDataEnabled"
                        %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                        %endif%/>
                        Report Performance Data
                    </td>
                </tr>
                <tr>
                    <td>Publish Interval (minutes)</td>
                    <td>
                        <div id="report-interval">
                            <input name="pg.PgMenConfiguration.reportInterval" type="text"
                                   value="%value pg.PgMenConfiguration.reportInterval%"
								   %ifvar pg.PgMenConfiguration.perfDataEnabled equals('false')% disabled %endif%/>
                            <span class="hidden">Interval must be between 1 and 60</span>
                        </div>
                    </td>
                </tr>
				<tr>
					<td class="action" colspan="3">
						<input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
					</td>
				</tr>
                </tbody>
            </table>
        </div>
    </form>

</div>
</div>
%endinvoke%
</body>
</html>