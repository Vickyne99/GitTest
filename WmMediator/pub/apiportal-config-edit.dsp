<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - API Portal Settings</title>
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
    Administration &gt; API Portal Configuration
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
    <span>Successfully saved API Portal configuration</span>
</div>
%endif%
%endinvoke%
%endif%

%invoke pg.UIConfig:getConfigProps%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li><a href="apiportal-config.dsp">Return</a></li>
    </ul>
	
    <form action="apiportal-config-edit.dsp" method="post">
    	<input type="hidden" id="form-tag" name="form-tag" value="apiportal-config-edit"/>
		
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
							<input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishErrorEvents"
							%ifvar pg.apiportal.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Error
							<br/>
							<input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishLifeCycleEvents"
							%ifvar pg.apiportal.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Lifecycle
							<br/>
							<input type="checkbox" name="pg.apiportal.PgMenConfiguration.publishPolicyViolationEvents"
							%ifvar pg.apiportal.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
							value='true' %endif%/>
							Policy Violation
							<br/>
						</td>
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
                    <td colspan=2><input type="checkbox" name="pg.apiportal.PgMenConfiguration.perfDataEnabled"
                        %ifvar pg.apiportal.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                        %endif%/>
                        Report Performance Data
                    </td>
                </tr>
                <tr>
                    <td>Publish Interval (minutes)</td>
                    <td>
                        <div id="report-interval">
                            <input name="pg.apiportal.PgMenConfiguration.reportInterval" type="text"
								value="%value pg.apiportal.PgMenConfiguration.reportInterval%"
								%ifvar pg.apiportal.PgMenConfiguration.perfDataEnabled equals('false')% disabled %endif%/>	
                            <span class="hidden">Interval must be between 1 and 60</span>
                        </div>
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

    </form>

</div>
</div>
%endinvoke%
</body>
</html>