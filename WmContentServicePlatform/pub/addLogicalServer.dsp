<HTML>
  <HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>

  <BODY>
<SCRIPT>
	function confirmAdd()
	{
		var name = document.registerform.name.value;
		
		if ( isblank(name) ) {
			alert( "Name is required.");
			return false;
		}
		
		//document.registerform.submit();
		return true;
	}
</SCRIPT>
<TABLE width="100%">
  <TR>
  	<TD height="5"></TD>
  </TR>
  <TR>
    %ifvar usage equals('wmcsp')%
		%ifvar overwrite equals('true')%
			<TD class=menusection-Packages>Content Service Platform Servers &gt; Update Server (WmContentServicePlatform usage)</TD>
		%else%
			<TD class=menusection-Packages>Content Service Platform Servers &gt; Add Server (WmContentServicePlatform usage)</TD>
		%end if%
	%else%
		<TD class=menusection-Packages>Content Service Platform Servers &gt; Add Server (Process usage)</TD>
	%end if%
  </tr>
</table>

<table>
	%ifvar usage equals('wmcsp')%
		%ifvar action equals('add')%
			%invoke pub.csp.connection:addConnection%
				%ifvar status%
					<script>writeMessage("%value status%");</script>
				%end if%
			%onerror%
				%loop -struct%
					<tr><td>%value $key%=%value%</td></tr>
				%endloop%
			%end invoke%
		%end if%
	%else%
		%ifvar action equals('add')%
			%invoke wm.econtent.econtent:btManager%
				%ifvar status%
					<script>writeMessage("%value status%");</script>
				%end if%
			%onerror%
				%loop -struct%
					<tr><td>%value $key%=%value%</td></tr>
				%endloop%
			%end invoke%
		%end if%
	%end if%
</table>

<table>
  <TR>
	<TD colspan="2">
	  <UL>
	     <LI><A HREF="logicalServers.dsp">Return to Content Service Platform Servers</A></LI>
	  </UL>
	</TD>
  </TR>
</table>

<TABLE>
	<TR>
		<td>&nbsp;</td>
        %ifvar action equals('save')%
			<TD colspan="2" class="heading">Update Content Service Platform Server</TD>
		%else%
			<TD colspan="2" class="heading">Add Content Service Platform Server</TD>
		%end if%
		<td>&nbsp;</td>
	</TR>

    <FORM NAME="registerform" ACTION="addLogicalServer.dsp" METHOD="POST">
          <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Friendly Name</TD>
            <TD class="oddrowdata-l">
				%ifvar action equals('save')%
					<class="oddrowdata-l" nowrap>%value friendlyName%</TD>
					<INPUT type="hidden" NAME="friendlyName" VALUE="%value friendlyName%">
				%else%
					<INPUT NAME="friendlyName" VALUE="%value friendlyName%"> </TD>
				%end if%
            <td>&nbsp;</td>
          </TR>
          <TR>
          	<td>&nbsp;</td>
            <TD class="evenrow">Host</TD>
            <TD class="evenrowdata-l">
              <INPUT NAME="host" VALUE="%value host%"> </TD>
			</TD>
            <td>&nbsp;</td>
          </TR>
          <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Port</TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="port" VALUE="%value port%"></TD>
            <td>&nbsp;</td>
          </TR>
         <TR>
          	<td>&nbsp;</td>
            <TD class="evenrow">User Name</TD>
            <TD class="evenrowdata-l">
              <INPUT NAME="userName" VALUE="%value userName%"></TD>
             <td>&nbsp;</td>
          </TR>
         <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Password</TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="password" type="password" VALUE="%value password%"></TD>
             <td>&nbsp;</td>
          </TR>
          <TR>
          	<td>&nbsp;</td>
            <TD colspan=2 class="action">           
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT TYPE="hidden" NAME="usage" VALUE="%value usage%">
              <INPUT TYPE="hidden" NAME="overwrite" VALUE="%value overwrite%">
              %ifvar action equals('save')%
			  	<INPUT type="submit" value="Update Content Service Platform Server" onclick="return confirmAdd()">
			  %else%
			  	<INPUT type="submit" value="Add Content Service Platform Server" onclick="return confirmAdd()">
			  %end if%
            </TD>
            <td>&nbsp;</td>
          </TR>
      </FORM>
</TABLE>


    </BODY>
  </HTML>

