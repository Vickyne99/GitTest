<html>

<head>
<title>Conversation Scripts</title>
%include ../../WmRoot/pub/b2bStyle.css%
</head>

<body LINK="#0000ff" VLINK="#800080">

<table width=100%>

<tr class="title">
	<th colspan="8">Conversation Scripts</th>
</tr>

%ifvar saveScript -notempty%
    %invoke wm.ip.cm:editScript2%
        %ifvar success -notempty%
        <tr bgcolor=white class="title">
	        <th colspan="8">Script "%value name%" saved successfully</th>
        </tr>
        %else%
        <tr bgcolor=white class="title">
	        <th colspan="8">Failed to save script "%value name%"</th>
        </tr>
        %endif%
    %endinvoke%
%endif%

<p ALIGN="CENTER">%invoke wm.ip.cm:getScriptInfo%</p>

<tr>
	<th class="heading">Name</th>
	<th class="heading">Focal Role</th>
	<th class="heading">Second Role</th>
</tr>
%loop scriptInfo%
<tr bgcolor=white>
    <td class="position" align=left><a href="rn-viewscript.dsp?name=%value name encode(url)%">%value name%</a></td>
    <td class="position" align=left>%value focalRole%</td>
    <td class="position" align=left>%value secondRole%</td>
</tr>
%endloop%
</table>


<p ALIGN="CENTER">%endinvoke% </p>
</body>
</html>
