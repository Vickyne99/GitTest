<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - Elasticsearch Communication Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
	 <script src="js/es-config.js" type="text/javascript"></script>
</head>
<body>
%invoke pg.UIConfig:getConfigProps%

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Elasticsearch Destination Configuration
</div>

<ul>
	<li><a href="elasticsearch-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">

	 <div id="esLoginConfig" class="config">
        <table summary="Elasticsearch Destination Configuration" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Elasticsearch Destination Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Protocol</td>
                <td>%value pg.es.protocol%</td>
            </tr>
            <tr>
                <td>Host Name</td>
                <td>%value pg.es.hostName%</td>
            </tr>
            <tr>
                <td>Port</td>
                <td>%value pg.es.port%</td>
            </tr>
            <tr>
                <td>User Name</td>
                <td>%value pg.es.userName%</td>
            </tr>
            </tbody>
        </table>
		
		<!--<table id="AliasTable" %ifvar pg.es.protocol equals('http')% class='hidden' %endif%>
                <tbody>
				<tr>
						<td nowrap>Keystore Alias</td>
						<td>%value pg.es.keyStoreHandle%</td>
				</tr>
				<tr>
						<td nowrap>Certificate Alias</td>
						<td>%value pg.es.signingCertAlias%</td>
				</tr>
				<tr>
						<td nowrap>Truststore Alias</td>
						<td>%value pg.es.trustStoreHandle%</td>
				</tr>
			 </tbody>	
		</table> -->
		
    </div>

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
                    <input type="checkbox" name="pg.es.PgMenConfiguration.publishErrorEvents" disabled readonly
                    %ifvar pg.es.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Error
					<BR/>
                    <input type="checkbox" name="pg.es.PgMenConfiguration.publishLifeCycleEvents" disabled readonly
                    %ifvar pg.es.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Lifecycle
					<BR/>
                    <input type="checkbox" name="pg.es.PgMenConfiguration.publishPolicyViolationEvents" disabled readonly
                    %ifvar pg.es.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked' value='true' 
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
					<input type="checkbox" name="pg.es.PgMenConfiguration.perfDataEnabled" disabled readonly
                    %ifvar pg.es.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                    %endif%/>
					Publish Interval (minutes)
				</td>
				<td>
				%ifvar pg.es.PgMenConfiguration.reportInterval -notempty%
                        <span>%value pg.es.PgMenConfiguration.reportInterval%</span>
                %else%
						<span>10</span>
                %endif%
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
%endinvoke%
</body>
</html>