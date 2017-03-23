<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - General Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
</head>

<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Mediator Configuration
</div>

<ul>
	<li><a href="general-config-edit.dsp">Edit</a></li>	
</ul>
<div id="container">

    <div id="mediatorConfig" class="config">
        <table summary="Table showing Mediator runtime config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">HTTP Config</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Load Balancer URL (HTTP)</td>
                <td>%value pg.lb.http.url%</td>
            </tr>
            <tr>
                <td>Load Balancer URL (HTTPS)</td>
                <td>%value pg.lb.https.url%</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div id="keystoreConfig" class="config">
        <table summary="Table showing Mediator Keystore runtime config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Keystore Config</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>IS Keystore Name</td>
                <td>
                    %value pg.keystore.keyStoreHandle%
                </td>
            </tr>
            <tr>
                <td>Alias (signing)</td>
                <td>%value pg.rampartdeploymenthandler.signingCertAlias%</td>
            </tr>
            <tr>
                <td>IS Truststore Name</td>
                <td>
                    %value pg.keystore.trustStoreHandle%
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div id="portsConfig" class="config">
        %invoke pg.UIConfig:getPorts%
        <table summary="Table showing Mediator HTTP and HTTPS ports information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Ports Config</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>HTTP Ports</td>
                <td>%loop SelectedHttpPorts%
                         %value port%&nbsp;&nbsp;
                    %endloop%</td>
            </tr>
            <tr>
                <td>HTTPS Ports</td>
                <td>%loop SelectedHttpsPorts%
                             %value port%&nbsp;&nbsp;
                    %endloop%</td>
            </tr>
           </tbody>
        </table>
        %onerror%
          <div class="message">Error [%value error%: %value errorMessage%] occurred while loading ports information!</div>
        %endinvoke%
    </div>

</div>
%endinvoke%

</body>
</html>