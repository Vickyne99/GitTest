<!DOCTYPE HTML PUBLIC "-//SoftQuad Software//DTD HoTMetaL PRO 
5.0::19981217::extensions to HTML 4.0//EN" "hmpro5.dtd">
<!-- $Revision: 1.5 $ --> 
<HTML>
 
<HEAD>
<TITLE>Sample</TITLE>
<LINK REL="stylesheet" HREF="sampleStyle.css" TYPE="text/css"> 
</HEAD>

<BODY>
<IMG SRC="/WmRoot/webMLogo.JPG" BORDER="0" ALT="webMethods" WIDTH="227"
 HEIGHT="39"> <H2>Sample Document Generator</H2>
<FORM METHOD="POST" ACTION="sample.dsp">
<TABLE>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD>
<TABLE>
<TR>
<TD COLSPAN="2"></TD>
</TR>
</TABLE>
<HR>
<TABLE>
%invoke wm.ip.rn:listRecords%
<TR>
</TR>
		<TR>
				<TD CLASS="rowlabel">
					Record:
				<TD>
				<TD>
					<SELECT NAME="recordName">
				%loop nodeName%
						<OPTION VALUE="%value rootFolder%.%value nodeName%">%value nodeName%</OPTION>
				%endloop%
				</TD>
				<TD><INPUT TYPE="SUBMIT" VALUE="Customize Document"></TD>
		</TR>
<TR>

</TABLE>
<HR>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY>
</HTML>

