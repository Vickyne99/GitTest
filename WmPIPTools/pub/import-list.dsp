<TABLE WIDTH=100%>
<TR CLASS="title">
  <TH>Modular PIP Import Files</TH>
</TR>
%invoke wm.ip.file:listImportableFiles%
%ifvar -notempty files%
<FORM NAME="pipList" ACTION="rn-import.dsp" METHOD="POST">
%loop files%
<TR>
  <TD CLASS="rowdata">
    <INPUT TYPE="CHECKBOX" NAME="file" VALUE="%value%">%value%<BR>
  </TD>
</TR>
%endloop%
<TR><TD></TD></TR>
<TR>
  <TD>Please select the files for which you would like to see the contents and
    then press the 'View' button:<BR>
    <INPUT TYPE="HIDDEN" NAME="action" VALUE="view">
    <INPUT TYPE="SUBMIT" VALUE="View">
  </TD>
</TR>
</FORM>
%else%
<TR>
  <TD CLASS="coldata"><I>There are no files to import.  In order to import
  a PIP, an importable archive file must be downloaded from the product
  website.  For information about archive access, please contact webMethods
  Support at
  <A HREF="mailto:wm-support@webmethods.com">wm-support@webmethods.com</A>.
  </I></TD>
</TR>
%endif%
%onerror%
	%value error%
%endinvoke%

</TABLE>
