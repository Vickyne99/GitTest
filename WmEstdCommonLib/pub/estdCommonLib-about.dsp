<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>
<BODY>
%scope param(package='WmEstdCommonLib')%
%invoke wm.estd.common.archive:getPackageInfo%
<div class="position">
<TABLE width="100%"><TR><TD>
<TABLE width="100%">
  <TR><TH class="title" colspan=4>About EstdCommonLib </TH>
</TR>
  <TR><TH class="heading" colspan=4>Copyright</TH></TR>
  <TR>
    <TD class="rowdata" width=120><img src="/WmRoot/images/SAG_emblem_79x31.gif" border=0>



	</TD>
	    <TD class="rowdata" colspan=3>
Copyright &copy; 2007 webMethods, Inc. All rights reserved.
This program is protected by U.S. and International copyright law as described in Help About. 
    </TD>
  </TR>
  <TR><TH class="heading" colspan=4>Version</TH></TR>
  <TR>
    <TD class="rowlabel" width="10%">Product</TD>
    <TD class="rowdata" colspan=3>Estandard Common Library package</TD>
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

