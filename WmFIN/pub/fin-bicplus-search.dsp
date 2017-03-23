<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>


<BODY>
<TABLE width="100%">

<FORM METHOD="POST"
	ACTION="fin-search-iban-list.dsp">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      SWIFT &gt;
      Search BankDirectoryPlus Information
    </td>
  </tr>
  <TR></TR>
  <TR></TR>
    <TR></TR>


<TR>
<TD WIDTH="30">&nbsp;</TD>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD> 
<TABLE>
	<TR>
		<TH CLASS="heading" COLSPAN="2">BankDirectoryPlus Search Criteria</TH>
	</TR>
        
        <TR>
	   <td class="evenrowdata-l" colspan="6">
	   Note: For partial search, enter '%partial search string%'.</td>
	</TR>
		
	
	<TR id="code">
		<TD CLASS="rowlabel">Code</TD>
		<TD CLASS="rowdata"><INPUT NAME="code" VALUE=""></TD>
	</TR>			
	
	<TR id="institution">
		<TD CLASS="rowlabel">Institution</TD>
		<TD CLASS="rowdata"><INPUT NAME="institution" VALUE=""></TD>
	</TR>	
	
	<TR id="branch">
		<TD CLASS="rowlabel">Branch</TD>
		<TD CLASS="rowdata"><INPUT NAME="branch" VALUE=""></TD>
	</TR>	
	
	<TR id="city">
		<TD CLASS="rowlabel">City</TD>
		<TD CLASS="rowdata"><INPUT NAME="city" VALUE=""></TD>
	</TR>	
	
	<TR id="modFlag">
		<TD CLASS="rowlabel">Modified Flag</TD>

		<TD CLASS="rowdata"> <SELECT id="modFlag" NAME="modFlag" >
			<OPTION SELECTED="SELECTED" VALUE=""></OPTION>
			<OPTION VALUE="A">New</OPTION>
			<OPTION VALUE="U">Update</OPTION>
			<OPTION VALUE="M">Modified</OPTION>
			<OPTION VALUE="D">Deleted</OPTION>
	</TR>
	
	
	<TR id="location">
		<TD CLASS="rowlabel">Location</TD>
		<TD CLASS="rowdata"><INPUT NAME="location" VALUE=""></TD>
	</TR>	
	
	<TR id="countryName">
		<TD CLASS="rowlabel">Country Name</TD>
		<TD CLASS="rowdata"><INPUT NAME="countryName" VALUE=""></TD>
	</TR>	

<TR id="button">
<TD class="action" COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Search"></TD>
</TR>
</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>
                   
