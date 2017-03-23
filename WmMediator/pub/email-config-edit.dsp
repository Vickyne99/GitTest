<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - Email Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/email-config.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Email Configuration
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
%else%
     %ifvar action equals('test')%
        %invoke pg.Email:testEmailConnection%
             %ifvar errorMessages -notempty%
                <div id="saveFailureInfo" class="message">
                  <span>Failed to send test email! Following errors were reported:</span>
                  <ul>
                  %loop errorMessages%
                        <li>%value errorMessages%</li>
                  %endloop%
                  </ul>
                </div>
             %else%
               <div id="saveSuccessMessage" class="message">
                   <span>Success! Test email sent to recipient address: %value pg.email.test.recipient%</span>
               </div>
             %endif%
        %endinvoke%
    %endif%
%endif%
%invoke pg.UIConfig:getConfigProps%

<div id="container">   
    <ul style="margin-left:-10px; width:39%">
        <li><a href="email-config.dsp">Return</a></li>
    </ul>

    <!-- Email (SMTP) CONFIG -->
<form action="email-config-edit.dsp" method="post">
	<input type="hidden" id="form-tag" name="form-tag" value="email-config-edit"/>
    <div id="emailConfig" class="config">
        <table summary="Table to input Email config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">
                    <span>Email Configuration</span>
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
                <td><input name="pg.email.password" type="password"
                            %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% /></td>
            </tr>
            <tr>
                <td>Retype Password</td>
                <td>
                    <div>
                        <input name="check.pg.email.password" type="password"
                                 %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% />
                         <span class="hidden">Passwords don't match!</span>
                    </div>
                </td>
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
            <tr>
                <td>Test Recipient</td>
                <td><input name="pg.email.test.recipient" type="text" value="%value pg.email.test.recipient%"/></td>
            </tr>
			<tr>
				<td class="action" colspan="2">
					<input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
					<input type="button" name="btnTest" id="btnTest" value="Test"/>
				</td>
			</tr>
            </tbody>
        </table>
    </div>

    <input type="hidden" id="action" name="action" value="save"/>
</form>    
</div>
</div>
%endinvoke%

</body>
</html>