<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - API Portal Instance Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
	<link rel="stylesheet" href="css/snmp-config.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/apiportal-config.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Settings &gt; Edit API Portal Instance Configuration
</div>

<div id="config.error">
</div>

<div>
%ifvar action equals('save')%
    %invoke pg.APIPortal:saveConfig%
        %ifvar status equals('saved')%
            <div id="saveSuccessMessage" class="message">Successfully saved API-Portal configuration [%value name%]</div>
        %else%
			<div id="saveFailureInfo" class="message">
				<span>Following errors were reported during save:</span>
				<ul style="margin-left:-10px; width:39%">
					<li>%value error%</li>
				</ul>
			</div>
        %endif%
    %endinvoke%
%endif%
<div id="container">
	<ul style="margin-left:-10px; width:39%">
        <li><a href="apiportal-config.dsp">Return</a></li>
    </ul>
	<div class="required-msg">Fields marked with <span class="required">*</span> are required</div>
	<form action="apiportal-instance-edit.dsp" method="POST">
		<input type="hidden" id="form-tag" name="form-tag" value="apiportal-instance-edit"/>
		%invoke pg.APIPortal:getConfig%
		%rename url endpoint -copy%
		<div id="apiportalInstanceConfig" class="config">
			<table id="basicConfigTable" summary="API Portal Configuration" class="tableView">
				<thead>
				<tr>
					<th colspan="2" class="heading">%value name% Configuration</th>
				</tr>
				</thead>
				<tbody>
				<tr>
                    <td>Name<span class="required">*</span></td>
                    <td><input type="text" name="name" value="%value name%"/></td>
                </tr>
				<tr>
                    <td>URL</td>
                    <td><input class="url" type="text" name="url" value="%value endpoint%"/></td>
                </tr>
				<tr>
                    <td>Tenant</td>
                    <td><input type="text" name="tenant" value="%value tenant%"/></td>
                </tr>
				<tr>
                    <td>User Name</td>
                    <td><input type="text" name="userName" value="%value userName%"/></td>
                </tr>
				<tr>
                    <td>Password</td>
                    <td><input name="password" type="password" value=""/>
                    </td>
                </tr>
                <tr>
                    <td>Retype Password</td>
                    <td>
                        <div id="apiportal-password">
                            <input name="check.password" type="password" value=""/>
                            <span class="hidden">Passwords don't match!</span>
                        </div>
                    </td>
                </tr>
				</tbody>
			</table>		
		</div>
		<input type ="hidden" name="ID" value="%value ID%"/>
		<input type ="hidden" name="passwordHandle" value="%value passwordHandle%"/>
		%endinvoke%
		<div id="formButtons">
			<table class="tableView">
				<tr>
					<td class="action" colspan="3">
						<input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
					</td>
				</tr>
			</table>
        </div>
	</form>
</div>
</div>
</body>
</html>