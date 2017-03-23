<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - Email Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
</head>

<body>
%invoke pg.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb" style="height:1em">
    Administration &gt; Email Configuration
</div>

<ul>
	<li><a href="email-config-edit.dsp">Edit</a></li>
</ul>
<div id="container">

    <!-- Email (SMTP) CONFIG -->

    <div id="emailConfig" class="config">
    <table summary="Email config information" class="tableView">
        <thead>
        <tr>
            <th colspan="2" class="heading">Email Configuration</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>SMTP Host Name/IP Address</td>
            <td>%value pg.email.smtpHost%</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>%value pg.email.smtpPort%</td>
        </tr>
        <tr>
            <td>User</td>
            <td>%value pg.email.userName%</td>
        </tr>
        <tr>
            <td>From</td>
            <td>%value pg.email.from%</td>
        </tr>
        <tr>
            <td colspan=2>
                <input name="tlsEnabled" id="tlsEnabled" type="checkbox" disabled readonly
                %ifvar pg.email.TLSEnabled equals('true')% checked %endif%/> TLS Enabled
            </td>
        </tr>
    </table>

</div>

</div>
%endinvoke%

</body>
</html>