<HTML>

<HEAD>
  <TITLE>RosettaNet PIP Builder Facility</TITLE>
  %include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>
<table width=100%">
  <tr>
    <td class="menusection-adapters" colspan="2">
      RosettaNet &gt;
      PIP Builder
    </td>
  </tr>
  <TR></TR>
  <TR></TR>
<TR>  
<TD>&nbsp;&nbsp;</TD><TD>
%invoke wm.ip.rn.pip:checkBuildPIPInput%
%endinvoke%

%switch formAction%
%case preview%
  	%switch isValid%
  	%value isValid%
		%case true%
	  		%include bp-view.dsp%
		%case%
	  		%include bp-build.dsp%
	%endswitch%	
%case commit%
 	%include bp-commit.dsp%

%case%
  	%include bp-build.dsp%

%endswitch%


</table>
</BODY>

</HTML>
