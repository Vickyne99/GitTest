<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - NERV Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
</head>

<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; EDA/Database Configuration
</div>

<ul>
	<li><a href="nerv-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">
    
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
                    <input type="checkbox" name="pg.nerv.PgMenConfiguration.publishErrorEvents" disabled readonly
                    %ifvar pg.nerv.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Error
					<BR/>
                    <input type="checkbox" name="pg.nerv.PgMenConfiguration.publishLifeCycleEvents" disabled readonly
                    %ifvar pg.nerv.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
                    %endif%/>
                    Lifecycle
					<BR/>
                    <input type="checkbox" name="pg.nerv.PgMenConfiguration.publishPolicyViolationEvents" disabled readonly
                    %ifvar pg.nerv.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
                    value='true' %endif%/>
                    Policy Violation
					<br/>
				</td>
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
					<input type="checkbox" name="pg.nerv.PgMenConfiguration.perfDataEnabled" disabled readonly
                    %ifvar pg.nerv.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                    %endif%/>
					Publish Interval (minutes)
				</td>
				<td>
				%ifvar pg.nerv.PgMenConfiguration.reportInterval -notempty%
                        <span>%value pg.nerv.PgMenConfiguration.reportInterval%</span>
                %else%
						<span>10</span>
                %endif%
				</td>
			</tr>
			</tbody>
		</table>
	</div>
	
    <!-- Database NERV CONFIG -->
    <div id="dbNERVConfig" class="config">
        <table summary="Database NERV config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Destinations</th>
            </tr>
            </thead>
            <tbody>
			<tr class="subheading2">
				<td colspan=2>
					Database
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="pg.nerv.PgMenConfiguration.emitToSqlEndpoint" disabled readonly
					%ifvar pg.nerv.PgMenConfiguration.emitToSqlEndpoint equals('true')% checked='checked' value='true'
					%endif%/>
					Emit to Database
				</td>
			</tr>
			<!--<tr>
              <td nowrap>Connection Pool Alias</td>
			  <td>
                    %ifvar pg.nerv.jdbc.functional.pool.alias -notempty%
                        <span>%value pg.nerv.jdbc.functional.pool.alias%</span>
                    %else%
                        <span class="nopool">Not configured</span>
                    %endif%
			  </td>
			</tr>-->
			<tr class="subheading2">
				<td colspan=2>
					EDA Endpoint
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="checkbox" name="pg.nerv.PgMenConfiguration.emitToDefaultEndpoint" disabled readonly
					%ifvar pg.nerv.PgMenConfiguration.emitToDefaultEndpoint equals('true')% checked='checked' value='true'
					%endif%/>
					Emit to Default EDA Endpoint				
				</td>
			</tr>
			<tr>
				<td class="space" colspan=3>&nbsp;</td>
            </tr>            
            </tbody>
        </table>
    </div>
</div>
%endinvoke%

</body>
</html>
