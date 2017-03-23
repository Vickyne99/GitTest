<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Mediator - STS Configuration Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/mediator.js" type="text/javascript"></script>
    <script src="js/sts-config.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb" style="height:1em">
    Settings &gt; Security Token Service (STS) Configuration
</div>

%ifvar action -equals('delete')%
    %invoke pg.stsconfig:deleteConfig%
        %ifvar status -equals('deleted')%
            <div class="message">Succesfully deleted STS configuration [%value name%]</div>
        %else%
            <div class="message">Error occurred when deleting STS configuration [%value error%].</div>
        %endif%
    %endinvoke%
%endif%

<ul>
	<li>
		<a href="sts-config-edit.dsp">Add new STS configuration</a>
	</li>
</ul>
<div id="container">

    <div id="stsConfig" class="config">
        <table summary="Table showing STS config information" class="tableView">
            <thead>
			<tr>
				<td class="heading" colspan="3">
					Security Token Service (STS) Configuration
				</td>
			</tr>
            <tr class="subheading2">
                <td>Name</td>
                <td>Endpoint</td>
                <td>Delete</td>
            </tr>
            </thead>
            <tbody>
            %invoke pg.stsconfig:getAllConfigs%
            %ifvar configs -notempty%
                %loop configs%
                <tr>
                    %rename config/name stsName -copy%
                    <td><a href="sts-config-edit.dsp?action=edit&name=%value config/name%">%value stsName%</a></td>
                    <td>%value config/endpoint%</td>
                    <td>
                        <a id='deleteConfig' href="sts-config.dsp?action=delete&name=%value stsName%">
                            <img src="images/delete.gif" alt="delete" style="border:none;"/>
                        </a>
                    </td>
                </tr>
                %endloop%
            %else%
                 <tr><td colspan="3">
					<div class="info">No STS configured</div>
				</td></tr> 
            %endif%
            %endinvoke%
            </tbody>
        </table>
    </div>

</div>

</body>
</html>