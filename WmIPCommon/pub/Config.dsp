<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
<SCRIPT LANGUAGE="JavaScript">
  function validate ()
  {
	var dest = document.getElementById("Default Destination ID").value;
	var orig = document.getElementById("Default Origination ID").value;          	
	if (isValidID(dest)==false)
	{          	
		alert ("Invalid value specified for Destination ID");
		return false;
	}
	if (isValidID(orig)==false)
	{
		alert ("Invalid value specified for Origination ID");
		return false;
	}
	return true;              	
  }
  function isValidID (str)
  {
	var zero = "0";
	var nine = "9";
	var start;
	if (str.length == 9)
	{
		start = 0;
	}
	else
	if (str.length == 10)
	{
		if (str.charAt(0) != ' ')
		{
			return false;
		}
		start = 1;
	}
	else
	{
		return false;
	}
	for (i = start; i < str.length; i++)
	{
		if ( ( str.charCodeAt(i) < zero.charCodeAt(0) ) || ( str.charCodeAt(i) > nine.charCodeAt(0) ))
		{
			return false;
		}
	}
	return true;
  }
</SCRIPT>
</HEAD>
<BODY>
<TABLE width="100%">

<FORM METHOD="POST" ACTION="/invoke/wm.ip.config/setConfig">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      %ifvar productKey%
      	%value productKey% &gt;
      %else%
      	IP Finance &gt;
	  %endif%
      Configuration
    </td>
  </tr>
  <TR></TR>
  <TR></TR>
    <TR></TR>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD>
<HR>
<TABLE>
	<TR>
		<TH CLASS="heading" COLSPAN="2">Current Configuration</TH>
	</TR>
      %ifvar productKey%
		<INPUT TYPE="HIDDEN" NAME=productKey VALUE="%value productKey%">
	  %endif%

	%invoke wm.ip.config:getConfig%
	%loop config%
			<TR>
				<TD CLASS="rowlabel"><B>%value key%</B></TD>
				<TD CLASS="rowdata">
					%ifvar choiceList%
						<SELECT NAME="%value key%">
							<option></option>
							%loop choiceList%
								<option%ifvar choiceList vequals(value)% SELECTED %endif%>%value choiceList%%ifvar value vequals(choiceList)% SELECTED %endif%</option>
							%endloop%
						</select>
					%else%
						<INPUT NAME="%value key%" %ifvar value%VALUE="%value value%"%endif%>
					%endif%
				</TD>
			</TR>
	%endloop%
	%endinvoke%
	<TR>


	<TD class="action" COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Save" onclick="return validate();"></TD>
	</TR>
</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>

