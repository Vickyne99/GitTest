<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>Mediator - CentraSite Communication Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
</head>
<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; CentraSite Configuration
</div>

<ul>
	<li><a href="centrasite-config-edit.dsp">Edit</a></li>
</ul>
<div id="container" >
    <!-- CS UDDI LOGIN CONFIG -->
    <div id="csLoginConfig" class="config">
        <table summary="CentraSite Login config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">CentraSite UDDI Publisher Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Protocol</td>
                <td>%value pg.uddiClient.protocol%</td>
            </tr>
            <tr>
                <td>Host Name</td>
                <td>%value pg.uddiClient.hostName%</td>
            </tr>
            <tr>
                <td>Target Name</td>
                <td>%value pg.policygateway.targetName%</td>
            </tr>
            <tr>
                <td>UDDI Port</td>
                <td>%value pg.uddiClient.uddiPort%</td>
            </tr>
            <tr>
                <td>User Name</td>
                <td>%value pg.uddiClient.userName%</td>
            </tr>
            <tr>
                <td colspan=2><input type="checkbox" name="pg.PgMenConfiguration.perfDataEnabled" disabled readonly
                    %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true'
                    %endif%/>
                    Report Performance Data
                </td>
            </tr>
            <tr>
                <td>Publish Interval (minutes)</td>
                <td>%value pg.PgMenConfiguration.reportInterval%</td>
            </tr>
            </tbody>
        </table>

    </div>

</div>
%endinvoke%
</body>
</html>