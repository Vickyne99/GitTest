<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
<SCRIPT language="Javascript">

var today = new Date();
var thisMonth = today.getMonth();
var thisYear = today.getFullYear();
var thisDate = today.getDate();


function todayDate()
{
  var td;

  yyyy = thisYear;
  mm = "0" + (thisMonth+1);
  mm = mm.substring(mm.length-2);
  dd = "0" + today.getDate();
  dd = dd.substring(dd.length-2);

  td = yyyy + "-" + mm + "-" + dd;
  return td;
}


</SCRIPT>
</HEAD>
<BODY>
<TABLE width="100%">

<FORM METHOD="POST" ACTION="ViewDocs.dsp">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      %ifvar productKey%
      	%value productKey% &gt;
      %else%
      	IP Finance &gt;
	  %endif%
      Persistence &gt;
	  Query
    </td>
  </tr>
  <TR></TR>
  <TR></TR>
    <TR></TR>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD>

<TABLE>
	<TR>
		<TH CLASS="heading" COLSPAN="2">Search Criteria (Inputs are Optional)</TH>
	</TR>
    %ifvar productKey%
			<INPUT TYPE=HIDDEN NAME="productKey" VALUE=%value productKey%>
    %else%
		<TR>
			<TD CLASS="rowlabel">Product</TD>
			<TD CLASS="rowdata">
				<INPUT NAME="productKey" VALUE=%value productKey%>
			</TD>
		</TR>
	%endif%

	<TR>
		<TD CLASS="evenrow">Message Type</TD>
		<TD CLASS="evenrow-l">
			<INPUT NAME="msgType" VALUE="">
		</TD>
	</TR>
	<TR>
		<TD CLASS="oddrow">Message Version</TD>
		<TD CLASS="oddrow-l">
			<INPUT NAME="version" VALUE="">
		</TD>
	</TR>
	<TR>
		<TD CLASS="evenrow">Sender ID</TD>
		<TD CLASS="evenrow-l"><INPUT NAME="senderId" VALUE=""></TD>
	</TR>
	<TR>
		<TD CLASS="rowlabel">Receiver ID</TD>
		<TD CLASS="rowdata"><INPUT NAME="receiverId" VALUE=""></TD>
	</TR>
	<TR>
		<TD CLASS="evenrow">Begin Date Range (yyyy-MM-dd HH:mm:ss)</TD>
		<TD CLASS="evenrow-l">
		<SCRIPT language="Javascript">
			document.write('<INPUT NAME="fromDate" VALUE="', todayDate(), ' 00:00:00">')
		</SCRIPT>
		</TD>
	</TR>
	<TR>
		<TD CLASS="rowlabel">End Date Range (yyyy-MM-dd HH:mm:ss)</TD>
		<TD CLASS="rowdata">
		<SCRIPT language="Javascript">
			document.write('<INPUT NAME="toDate" VALUE="', todayDate(), ' 23:59:59">')
		</SCRIPT>
		</TD>
	</TR>
	<TR>
		<TD CLASS="evenrow">Maximum Results</TD>
		<TD CLASS="evenrow-l"><INPUT NAME="maxResults" VALUE="100">
		</TD>
	</TR>
	%invoke wm.ip.config:getAdditionalQueryFields%
	%loop -struct additionalQueryFields%
			<TR>
				<TD CLASS="rowlabel"><B>%value $key%</B></TD>
				<TD CLASS="rowdata">
						<INPUT NAME="%value $key%" VALUE="">
				</TD>
			</TR>
	%endloop%
	<TR>
	<TD class="action" COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Search"></TD>
	</TR>

</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>

