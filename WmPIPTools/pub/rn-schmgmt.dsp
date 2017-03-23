<HTML>

<HEAD>
  <TITLE>RosettaNet PIP Builder Facility</TITLE>
</HEAD>

<BODY>
  %include ../../WmRoot/pub/b2bStyle.css%
<table width=100%">
  <tr>
    <td class="menusection-adapters" colspan="2">
      RosettaNet &gt;
      Schema Management
    </td>
  </tr>
    <TR></TR>
  <TR></TR>
<TR>  
<TD>&nbsp;&nbsp;</TD>
%switch formAction%
%case export%
<TD class="message">
	%invoke wm.ip.rn.schema:exportSchema%
	IS Schema successfully exported
	%end invoke%
%case import%
<TD class="message">
 	%invoke wm.ip.rn.file:importSchema%
		%ifvar isSuccessful equals('false')%
			Errors occured while importing the following entries:
			%loop errors%
				<LI>%value identifier%</LI>
			%endloop%			
		%else%
			XML File sucessfully imported
		%endif%
	%end invoke%
%case migrate%
<TD class="message">
 	%invoke wm.ip.rn.schema:migrateSchema%
			IS Doc Type sucessfully migrated to a new IS Schema
	%end invoke%
%case%
<TD>
 	%include rn-schmgmt-main.dsp%
%endswitch%
</TD>
</TR>
</table>
</body>
</html>
