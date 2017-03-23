<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - Elasticsearch Communication Settings</title>
   <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
	<link rel="stylesheet" href="css/snmp-config.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/es-config.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Elasticsearch Destination information
</div>
<div id="config.error">
</div>

<div>
%ifvar action equals('save')%
%invoke pg.UIConfig:saveConfigProps%
%ifvar messages -notempty%
<div id="saveFailureInfo" class="message">
    <span>Following errors were reported during save:</span>
    <ul style="margin-left:-10px; width:39%">
        %loop messages%
        <li>%value message%</li>
        %endloop%
    </ul>
</div>
%else%
<div id="saveSuccessMessage" class="message">
    <span>Successfully saved Elasticsearch configuration!</span>
</div>
%endif%
%endinvoke%
%endif%
%invoke pg.UIConfig:getConfigProps%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li><a href="elasticsearch-config.dsp">Return</a></li>
    </ul>

	<div class="required-msg">Fields marked with <span class="required">*</span> are required</div>	
    <form action="elasticsearch-config-edit.dsp" method="post">
    	<input type="hidden" id="form-tag" name="form-tag" value="elasticsearch-config-edit"/>
       
	   <div id="esLoginConfig" class="config">
            <table summary="Elasticsearch Destination information" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">Elasticsearch Destination Configuration</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Protocol</td>
                    <td>
                        <input id="httpProtocol" type="radio" name="pg.es.protocol"
                        %ifvar pg.es.protocol equals('http')% checked='checked' %endif% value='http' />
                        <label for="httpProtocol">HTTP</label>

                        <input id="httpsProtocol" type="radio" name="pg.es.protocol"
                        %ifvar pg.es.protocol equals('https')% checked='checked' %endif% value='https'/>
                        <label for="httpsProtocol">HTTPS</label>
                    </td>
                </tr>
                <tr>
                    <td>Host Name<span class="required">*</span></td>
                    <td><input class="url" name="pg.es.hostName" type="text"
                               value="%value pg.es.hostName%"/></td>
                </tr>
                <tr>
                    <td>Port</td>
                    <td><input type="text" name="pg.es.port"
                               value="%value pg.es.port%"/></td>
                </tr>
                <tr>
                    <td>User Name</td>
                    <td><input name="pg.es.userName" type="text"
                               value="%value pg.es.userName%"/></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input name="pg.es.password" type="password"
                        %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% id="password1"/>
                    </td>
                </tr>
                <tr>
                    <td>Retype Password</td>
                    <td>
                        <div id="es-password">
                            <input name="check.pg.es.password" type="password"
                            %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% id="password2"/>
                            <span class="hidden">Passwords don't match!</span>
                        </div>
                    </td>
                </tr>
					 </tbody>	
				</table>
				
		<!--	<table id="AliasTable" %ifvar pg.es.protocol equals('http')% class='hidden' %endif%>
                <tbody>
                <tr>
                    <td>IS Keystore Name</td>
                    <td>
                        <select name="pg.es.keyStoreHandle">
                            %invoke pg.UIConfig:getKeystoreNames%
                                %loop keyStoreNames%
                                    <option %ifvar ../pg.es.keyStoreHandle vequals(name)% selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Alias (signing)</td>
                    <td>
                        <select name="pg.es.signingCertAlias">
                            %invoke pg.UIConfig:getAliases%
                                %loop aliasNames%
                                    <option %ifvar ../pg.es.signingCertAlias vequals(name)%
                                            selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>

                        <div id="busy"><img src="images/ajax_busy_sm.gif" alt="busy"/></div>
                    </td>
                </tr>
                <tr>
                    <td>IS Truststore Name</td>
                    <td>
                        <select name="pg.es.trustStoreHandle">
                            %invoke pg.UIConfig:getTrustStoreNames%
                                %loop trustStoreNames%
                                    <option %ifvar ../pg.es.trustStoreHandle vequals(name)% selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>
                    </td>
                </tr>
                </tbody>
		</table>
		</div> -->
		
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
							<input type="checkbox" name="pg.es.PgMenConfiguration.publishErrorEvents"
							%ifvar pg.es.PgMenConfiguration.publishErrorEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Error
							<br/>
							<input type="checkbox" name="pg.es.PgMenConfiguration.publishLifeCycleEvents"
							%ifvar pg.es.PgMenConfiguration.publishLifeCycleEvents equals('true')% checked='checked' value='true'
							%endif%/>
							Lifecycle
							<br/>
							<input type="checkbox" name="pg.es.PgMenConfiguration.publishPolicyViolationEvents"
							%ifvar pg.es.PgMenConfiguration.publishPolicyViolationEvents equals('true')% checked='checked'
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
                    <td colspan=2><input type="checkbox" name="pg.es.PgMenConfiguration.perfDataEnabled"
                        %ifvar pg.es.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                        %endif%/>
                        Report Performance Data
                    </td>
                </tr>
                <tr>
                    <td>Publish Interval (minutes)</td>
                    <td>
                        <div id="report-interval">
                            <input name="pg.es.PgMenConfiguration.reportInterval" type="text"
                                value="%value pg.es.PgMenConfiguration.reportInterval%"
								%ifvar pg.es.PgMenConfiguration.perfDataEnabled equals('false')% disabled %endif%/>
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