<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - Service Fault Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/centrasite-config.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Service Fault Configuration
</div>
<div id="config.error">
</div>

<div>
%ifvar action equals('save')%
%invoke pg.UIConfig:saveServiceFaultConfig%
%ifvar messages -notempty%
<div id="saveFailureInfo" class="message">
    <span>Following errors were reported during Mediator configuration save:</span>
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
%invoke pg.UIConfig:getServiceFaultConfig%

<div id="container">
    <ul style="margin-left:-10px; width:39%">
        <li><a href="service-fault-config.dsp">Return</a></li>
    </ul>

    <!-- SERVICE FAULT CONFIG -->
    <form action="service-fault-config-edit.dsp" method="post">
        <div id="serviceFaultConfig" class="config">
            <table summary="Service fault config information" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">Service Fault Configuration</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Default Fault Response</td>
                    <td><textarea class="right faultReason" name="pg.providerFault.reason">%value pg.providerFault.reason%</textarea></td>
                </tr>
                <tr>
                    <td colspan=2><input type="checkbox" name="pg.providerFault.enabled"
                        %ifvar pg.providerFault.enabled equals('true')% checked='checked' value='true'
                        %endif%/>
                        Send native provider fault (when available)
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