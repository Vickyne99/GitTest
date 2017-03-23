<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - General Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <link rel="stylesheet" href="css/general-config-edit.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/general-config.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Mediator Configuration
</div>

<div id="primaryPort-remove-error">
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
        <li><a href="general-config.dsp">Return</a></li>
    </ul>

    <form action="general-config-edit.dsp" method="post">
        <input type="hidden" id="form-tag" name="form-tag" value="general-config-edit"/>
        <div id="mediatorConfig" class="config">
            <table summary="Table to input Mediator runtime config information" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>HTTP Config</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Load Balancer URL (HTTP)</td>
                    <td><input class="url" name="pg.lb.http.url" type="text" value="%value pg.lb.http.url%"/></td>
                </tr>
                <tr>
                    <td>Load Balancer URL (HTTPS)</td>
                    <td><input class="url" name="pg.lb.https.url" type="text" value="%value pg.lb.https.url%"/></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div id="keystoreConfig" class="config">
            <table class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>Keystore Config</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>IS Keystore Name</td>
                    <td>
                        <select name="pg.keystore.keyStoreHandle">
                            %invoke pg.UIConfig:getKeystoreNames%
                                %loop keyStoreNames%
                                    <option %ifvar ../pg.keystore.keyStoreHandle vequals(name)% selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Alias (signing)</td>
                    <td>
                        <select name="pg.rampartdeploymenthandler.signingCertAlias">
                            %invoke pg.UIConfig:getAliases%
                                %loop aliasNames%
                                    <option %ifvar ../pg.rampartdeploymenthandler.signingCertAlias vequals(name)%
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
                        <select name="pg.keystore.trustStoreHandle">
                            %invoke pg.UIConfig:getTrustStoreNames%
                                %loop trustStoreNames%
                                    <option %ifvar ../pg.keystore.trustStoreHandle vequals(name)% selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div>
            %invoke pg.UIConfig:getPorts%
            %invoke pg.UIConfig:getPrimaryPort%
            
            <table class="tableView">
                <thead>
                <tr>
                    <th colspan="3" class="heading">HTTP Ports Configuration</th>
				</tr>
				</thead>
			</table>
			<div id="httpPortsConfig" class="config">
                <div class="ports">
                    <label>Available Ports</label>
                    <select id="availableHttpPorts" multiple="multiple">
                        %loop AvailableHttpPorts%
                            <option>%value port%</option>
                        %endloop%
                    </select>
                    <a href="#" id='addHttp' class='ports'>Add &#187;</a>
                </div>
                <div class="ports right">
                    <label>Selected Ports</label>
                    <select id="selectedHttpPorts" name="pg.http.ports" multiple="multiple">
                        %loop SelectedHttpPorts%
                            <option %ifvar /primaryPort vequals(port)% class='primary' %endif%>%value port%</option>
                        %endloop%
                    </select>
                    <a href="#" id="removeHttp" class='ports'>&#171; Remove</a>
                </div>
            </div>
			
			
			<table summary="Table to input Mediator Keystore runtime config information" class="tableView">
				<thead>
				<tr>
					<th colspan="3" class="heading">HTTPS Ports Configuration</th>
				</tr>
				</thead>
			</table>
			
			<div id="httpsPortsConfig" class="config">
                <div class="ports">
                    <label>Available Ports</label>
                    <select id="availableHttpsPorts" multiple="multiple">
                        %loop AvailableHttpsPorts%
                             <option>%value port%</option>
                        %endloop%
                    </select>
                    <a href="#" id="addHttps" class='ports'>Add &#187;</a>
                </div>
                <div class="ports right">
                    <label>Selected Ports</label>
                    <select id="selectedHttpsPorts" name="pg.https.ports" multiple="multiple">
                        %loop SelectedHttpsPorts%
                             <option>%value port%</option>
                        %endloop%
                    </select>
                    <a href="#" id="removeHttps" class='ports'>&#171; Remove</a>
                </div>
            </div>
            %endinvoke%
            %onerror%
                   <div class="message">Error [%value error%: %value errorMessage%] occurred while loading ports information!</div>
            %endinvoke%
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