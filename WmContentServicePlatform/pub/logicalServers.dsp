<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Logical Servers</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js.txt"></SCRIPT>

<BODY>
<TABLE width="100%">
  <TR>
  	<TD height="5"></TD>
  </TR>
  <TR>
    <TD class=menusection-Packages>Content Service Platform Servers</TD>
  </tr>
</table>

<table>
	%ifvar action equals('delete')%
		%invoke pub.csp.connection:deleteConnection%
			%ifvar status%
			  <script>writeMessage("%value status%");</script>
			%end if%
		%onerror%
			<script>writeMessage("%value status%");</script>
		%end invoke%
	%end if%
	%ifvar action equals('deletePE')%
		%invoke wm.econtent.econtent:deleteRepo%
		%onerror%
			<script>writeMessage("%value status%");</script>
		%end invoke%
	%end if%	
</table>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD>
      <ul>
		<li><a href="addLogicalServer.dsp?usage=wmcsp&userName=csp&password=operating&port=9010&host=localhost&overwrite=false">Add Content Service Platform Server (WmContentServicePlatform package usage)</a></li>
      </ul>
    </TD>
  </TR>
  </TBODY>
</TABLE>

<table>
  <tr>
    <td><img border="0" src="images/blank.gif" width="20" height="1"></td>
    <td class="heading" colspan="7" valign="top">
      Content Service Platform Servers (WmContentServicePlatform)
    </td>
    <td valign="top">
    <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </tr>
  <tr>
    <td valign="top"></td>
    <td class="oddcol-l" nowrap>Content Server Name&nbsp;&nbsp;</td>
    <td width="100%" class="oddcol" nowrap align="center">Host</td>
	<td width="10%" class="oddcol" nowrap align="center">Status</td>
	<td width="100%" class="oddcol" nowrap align="center">User Name</td>
	<td width="100%" class="oddcol" nowrap align="center">Port</td>
    <td class="oddcol" nowrap>&nbsp;Edit&nbsp;</td>
    <td class="oddcol" nowrap>Remove</td>
    <td valign="top" ></td>
  </tr>
%invoke pub.csp.connection:listConnections%
%loop connectionDetails%
  <tr> 
	<td>&nbsp;</td>
	<script>writeTD("rowdata-l", "nowrap valign=\"top\"");</script>
	%value friendlyName%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"");</script>
	%value host%
	</td>
	<script>writeTD('rowdata\" width=\"10%', "nowrap valign=\"top\"");</script>
		%switch status%
			%case '0'%
				<img src="images/red-ball.gif" border="0">
			%case '1'%
				<img src="images/green-ball.gif" border="0">
		%end%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	%value userName%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	%value port%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	<a HREF="addLogicalServer.dsp?action=save&usage=wmcsp&friendlyName=%value friendlyName -urlencode%&host=%value host%&userName=%value userName%&port=%value port%&password=&overwrite=true">Edit</a>
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	<a class="imagelink" HREF="logicalServers.dsp?action=delete&friendlyName=%value friendlyName -urlencode%" onclick="return confirmDelete('%value name%', 'true');"><img border="0" src="images/delete.gif" width="14" height="14"></a>
	</td>
	<td valign="top"></td>
	<script>
        	swapRows();
	</script> 
  </tr>
%endloop%

</table>

</BODY></HTML>
