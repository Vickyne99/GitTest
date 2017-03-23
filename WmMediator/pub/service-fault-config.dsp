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
</head>
<body>
%invoke pg.UIConfig:getServiceFaultConfig%
%ifvar messages -notempty%
<div class="message">
    <span>Following errors were reported during Mediator configuration load:</span>
    <ul>
        %loop messages%
        <li>%value message%</li>
        %endloop%
    </ul>
</div>
%endif%
%endinvoke%

<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Service Fault Configuration
</div>

<ul>
	<li><a href="service-fault-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">
    <!-- SERVICE FAULT CONFIG -->
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
                <td><textarea class="right faultReason" readonly="readonly">%value pg.providerFault.reason%</textarea></td>
            </tr>
            <tr>
                <td colspan=2><input type="checkbox" name="pg.providerFault.enabled" disabled readonly="readonly"
                    %ifvar pg.providerFault.enabled equals('true')% checked='checked' value='true'
                    %endif%/>
                    Send Native Provider Fault (when available)
                </td>
            </tr>
            </tbody>
        </table>

    </div>

</div>
%endinvoke%
</body>
</html>