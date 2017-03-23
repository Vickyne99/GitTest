<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator NERV Configuration</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	 <link rel="stylesheet" href="css/nerv-config.css" type="text/css"/>
	<script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
	<script src="js/nerv-config.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt;  Edit EDA/Database Configuration
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
             <span>Successfully saved Mediator EDA Configuration!</span>
         </div>
      %endif%
    %endinvoke%
%endif%

%invoke pg.UIConfig:getConfigProps%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li><a href="nerv-config.dsp">Return</a></li>
    </ul>
	<form name="saveNERVConfig" method="post" action="nerv-config-edit.dsp">
		<input type="hidden" id="form-tag" name="form-tag" value="nerv-config-edit"/>
		<input type="hidden" id="poolalias" name="pg.nerv.jdbc.functional.pool.alias" value="%value pg.nerv.jdbc.functional.pool.alias%"/>
		
		<div id="eventGeneration" class="config">
			<table summary="Mediator NERV Configuration" class="tableView"> 
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
							<input type="checkbox" name="pg.nerv.PgMenConfiguration.publishErrorEvents"
							%ifvar pg.nerv.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Error
							<br/>
							<input type="checkbox" name="pg.nerv.PgMenConfiguration.publishLifeCycleEvents"
							%ifvar pg.nerv.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Lifecycle
							<br/>
							<input type="checkbox" name="pg.nerv.PgMenConfiguration.publishPolicyViolationEvents"
							%ifvar pg.nerv.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
							value='true' %endif%/>
							Policy Violation
							<br/>
						</td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div id="metricGeneration" class="config">
			<table summary="Mediator NERV Configuration" class="tableView"> 
				<thead>
					<tr>
						<th colspan="3" class="heading">
							<span>Performance Metrics</span>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan=2>
						<input id="perfEnabled" type="checkbox" name="pg.nerv.PgMenConfiguration.perfDataEnabled" 
							%ifvar pg.nerv.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true' %endif% />
						Publish Interval (minutes)
						</td>
						<td>
						<div id="report-interval">
						<input id="reportInterval" name="pg.nerv.PgMenConfiguration.reportInterval" type="text"
						value = "%value pg.nerv.PgMenConfiguration.reportInterval%" 
						%ifvar pg.nerv.PgMenConfiguration.perfDataEnabled equals('false')% disabled %endif%/>
						<span class="hidden">Interval must be between 1 and 60</span>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
		<div id="dbNERVConfig" class="config">
			<table summary="Database NERV config information" class="tableView">
				<thead>
					<tr>
						<th colspan="2" class="heading">Destinations</th>
					</tr>
				</thead>
				<tbody>
					<tr class="subheading2">
						<td colspan=2>Database</td>
					</tr>	
										
					<tr>
						<td>
						<input type="checkbox" name="pg.nerv.PgMenConfiguration.emitToSqlEndpoint"
						%ifvar pg.nerv.PgMenConfiguration.emitToSqlEndpoint equals('true')% checked='checked' value='true'
						%endif%/>
						Emit to Database
					</td>	
					<td>
				  	</td>
					</tr>					
					<!--<tr>
						<td nowrap>Connection Pool Alias</td>
						<td>
                        <select name="pg.nerv.jdbc.functional.pool.alias" style="width:250px">
                            %invoke wm.server.jdbcpool:getPoolDefinitions%
                                %loop pools%
                                    <option %ifvar ../pg.nerv.jdbc.functional.pool.alias vequals(pool.name)% selected %endif% />%value pool.name%
                                %endloop%
                            %endinvoke%
                        </select>
						</td>
					</tr>-->
					<tr class="subheading2">
						<td colspan=2>EDA Endpoint</td>
					</tr>					
					<tr>
						<td>
							<input type="checkbox" name="pg.nerv.PgMenConfiguration.emitToDefaultEndpoint"
							%ifvar pg.nerv.PgMenConfiguration.emitToDefaultEndpoint equals('true')% checked='checked' value='true'
							%endif%/>
							Emit to Default EDA Endpoint
						</td>	
						<td></td>
					</tr>
					<tr></tr>
					<tr>
						<td class="space" colspan=3>Note: For <i>Emit to Database</i>, the IS connection pool associated with <i>Mediator</i> functional alias is used.</td>
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
