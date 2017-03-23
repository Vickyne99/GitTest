<!DOCTYPE HTML PUBLIC "-//SoftQuad Software//DTD HoTMetaL PRO 
5.0::19981217::extensions to HTML 4.0//EN" "hmpro5.dtd">
<!-- $Revision: 1.5 $ --> 
<HTML>
 
<HEAD>
<TITLE>Purchase Order</TITLE>
<LINK REL="stylesheet" HREF="sampleStyle.css" TYPE="text/css"> 
</HEAD>

<BODY>
<IMG SRC="/WmRoot/webMLogo.JPG" BORDER="0" ALT="webMethods" WIDTH="227"
 HEIGHT="39"> <H2>Sample Document Generator</H2>
<FORM METHOD="POST" ACTION="bp-view">
<INPUT TYPE="HIDDEN" NAME="recordName" VALUE="%value recordName%">
<TABLE>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD>
<TABLE>
<TR>
<TD CLASS="rowlabel">From:</TD>
<TD CLASS="rowtext"><INPUT NAME="sender" VALUE="123456789"></TD>
</TR>
<TR>
<TD CLASS="rowlabel">To:</TD>
<TD CLASS="rowtext"><INPUT NAME="receiver" VALUE="987654321"></TD>

<TD COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Post Document"></TD>
</FORM>
</TR>
</TABLE>

<HR>
<TABLE>
%invoke wm.ip.record:recordToSample%
<TR>
<TH align=left>
	%value nodeName%
</TH>
</TR>
%loop nodePath%
	<TR>
		<TH CLASS="heading" COLSPAN="2">%value name%</TH>
	</TR>
	%loop node%
		<TR>
			<TD CLASS="rowlabel">%value name%</TD>
			%ifvar choiceList%
				<TD>
				<SELECT NAME="@%value ../../nodeName%>%value ../name%%value name%" 
VALUE="%value 
value%">
					%ifvar value%
						<OPTION SELECTED>%value value%</OPTION>
					%endifvar%	
					%loop choiceList%
						<OPTION>%value choiceList%</OPTION>
					%endloop%
				</TD>
			%else%
				<TD><INPUT NAME="@%value ../../nodeName%>%value ../name%%value name%" 
VALUE="%value value%"></TD>
			%endifvar%
		</TR>
	%endloop%
	<TR><TD>&nbsp;</TD></TR>
%endloop%
<TR>

</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>

