<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>
<BODY>
%scope param(package='WmChem')%
%invoke wm.estd.common.archive:getPackageInfo%
<div class="position">
<TABLE width="100%"><TR><TD>
<TABLE width="100%">
  <TR><TH class="title" colspan=4>About webMethods Chem eStandards Module</TH>
</TR>
  <TR align=center>
    <TD  colspan=4 align=center><A HREF="http://www.cidx.org"><img src="./images/registration.gif"
border=0></a>
	</TD>	    
  </TR>
  <TR><TH class="heading" colspan=4>Copyright</TH></TR>
  <TR>
    <TD class="rowdata" width=120><img src="/WmRoot/images/wmlogo.gif" border=0>
	</TD>
	    <TD class="rowdata" colspan=3>
	      Copyright &copy; 2007, <A HREF="http://www.webmethods.com">
webMethods Inc.</A>  All Rights Reserved.<BR>
      <p>
      B2B Integration Server is a trademark and webMethods is a registered 
      trademark of webMethods, Inc. Other product and brand names are 
      trademarks of their respective owners.
    </TD>
  </TR>
  <TR><TH class="heading" colspan=4>Version</TH></TR>
  <TR>
    <TD class="rowlabel" width="10%">Product</TD>
    <TD class="rowdata" colspan=3>webMethods Chem eStandards Module</TD>
  </TR>
  <TR>
    <TD class="rowlabel">Version</TD>
    <TD class="rowdata" colspan=3>%value version% &nbsp;&nbsp;&nbsp;</TD>
  </TR>
  <TR>
    <TD class="rowlabel">Build Number</TD>
    <TD class="rowdata" colspan=3>%value build%</TD>
  </TR>

  
  
            
  
</TABLE>
</TD></TR></TABLE>
%endscope%
%endinvoke%
</div>
</BODY></HTML>

