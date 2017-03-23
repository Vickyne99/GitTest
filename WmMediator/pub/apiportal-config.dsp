<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - API-Portal Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	<link rel="stylesheet" href="css/api-portal.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
	<script src="js/messages.js" type="text/javascript"></script>
	<script src="js/apiportal-config.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; API-Portal Configuration
</div>

%ifvar action -equals('delete')%
    %invoke pg.APIPortal:deleteConfig%
        %ifvar status -equals('deleted')%
            <div class="message">Succesfully deleted API-Portal configuration [%value name%]</div>
        %else%
            <div class="message">Error occurred when deleting API-Portal configuration [%value error%].</div>
        %endif%
    %endinvoke%
%endif%

<ul>
	<li><a href="apiportal-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">
	%invoke pg.UIConfig:getConfigProps%
	<div id="eventTypes" class="config">
        <table summary="Mediator event types config information" class="tableView">
            <thead>
				<tr>
					<th colspan="2" class="heading">
                    <span>Event Types</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishErrorEvents" disabled readonly
                    %ifvar pg.apiportal.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Error
					<BR/>
                    <input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishLifeCycleEvents" disabled readonly
                    %ifvar pg.apiportal.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Lifecycle
					<BR/>
                    <input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishPolicyViolationEvents" disabled readonly
                    %ifvar pg.apiportal.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked' value='true' 
					%endif%/>
                    Policy Violation
					<br/>
				<td></td>
            </tr>
            </tbody>
        </table>
    </div>
	
	<div id="metrics" class="config">
		<table summary="Mediator PerformanceMetrics Configuration" class="tableView">
			<thead>
					<tr>
						<th colspan="3" class="heading">
							<span>Performance Metrics</span>
						</th>
					</tr>
			</thead>
			<tbody>
			<tr>
				<td>
					<input type="checkbox" name="pg.apiportal.PgMenConfiguration.perfDataEnabled" disabled readonly
                    %ifvar pg.apiportal.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                    %endif%/>
					Publish Interval (minutes)
				</td>
				<td>
				%ifvar pg.apiportal.PgMenConfiguration.reportInterval -notempty%
                        <span>%value pg.apiportal.PgMenConfiguration.reportInterval%</span>
                %else%
						<span>10</span>
                %endif%
				</td>
			</tr>
			</tbody>
		</table>
	</div>
	%endinvoke%
		
	<div id="instances" class="config">
        <table summary="Table showing API-Portal config information" class="tableView">
            <thead>
            <tr>
                <th class="heading" colspan="11"><span>API-Portal Instances</span></th>
            </tr>
            </thead>
            <tbody>
            %invoke pg.APIPortal:getAllConfigs%
            %ifvar configs -notempty%
				<tr class="subheading2">
					<td>Name</td>
					<td>URL</td>
					<td>Tenant</td>
					<td>User Name</td>
					<td>Action</td>
				</tr>
                %loop configs%
                <tr>
                    <td><a href="apiportal-instance-edit.dsp?action=view&ID=%value ID%">%value name%</a></td>
                    <td>%value url%</td>
					<td>%value tenant%</td>
					<td>%value userName%</td>
                    <td>
                        <a id='deleteConfig' href="apiportal-config.dsp?action=delete&ID=%value ID%&name=%value name%">
                            <img src="images/delete.gif" alt="delete" style="border:none;"/>
                        </a>
                    </td>
                </tr>
                %endloop%
            %else%
                 <tr><td colspan="3">
					<div class="info">No API-Portal instance is configured</div>
				</td></tr>
            %endif%
            %endinvoke%
            </tbody>
        </table>
    </div>
	
</div>
</body>
</html>