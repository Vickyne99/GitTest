<TABLE WIDTH=100%>
<TR CLASS="title">
  <TH>Sample Import Files</TH>
</TR>
%invoke wm.estd.rosettaNet.impt:listSampleFiles%
%ifvar -notempty files%
<FORM NAME="pipList" ACTION="rn-import-sample.dsp" METHOD="POST">
%loop files%
<TR>
  <TD CLASS="rowdata">
    <INPUT TYPE="CHECKBOX" NAME="file" VALUE="%value%">%value%<BR>
  </TD>
</TR>
%endloop%
<TR><TD></TD></TR>
<TR>
  <TD>Please select the files for which you would like to import and
    then press the 'Import' button:<BR>
    <INPUT TYPE="HIDDEN" NAME="action" VALUE="import">
    <INPUT TYPE="SUBMIT" VALUE="Import">
  </TD>
</TR>
</FORM>
%else%
<TR>
  <TD CLASS="coldata"><I>There are no files to import.  In order to import
  a Sample, an importable archive file must be downloaded from the product
  website.  For information about archive access, please contact Software AG
  Support at
  <A HREF="mailto:empower@softwareag.com">empower@softwareag.com</A>.
  </I></TD>
</TR>
%endif%
%onerror%
	%value error%
%endinvoke%

</TABLE>
