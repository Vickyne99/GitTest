<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>
<BODY>
%scope param(package='WmRosettaNet')%
%invoke wm.estd.common.archive:getPackageInfo%
<div class="position">
<TABLE width="100%"><TR><TD>
<TABLE width="100%">
  <TR><TH class="title" colspan=4>About webMethods RosettaNet Module</TH>
</TR>
<TR align=center>
    <TD  colspan=4 align=center><A  onmouseover='this.style.cursor="hand"' onClick="window.open('http://www.rosettanet.org')"><img src="./images/registration.jpg" border=0></A>
	</TD>	    
  </TR>
  <TR><TH class="heading" colspan=4>Copyright</TH></TR>
  <TR>
    <TD class="rowdata" width=120><img src="/WmRoot/images/SAG_emblem_79x31.gif" border=0>



	</TD>
	    <TD class="rowdata" colspan=3>
Copyright &copy; 2000 - 2012 Software AG, Darmstadt, Germany and/or Software AG USA, Inc., Reston, VA, United States of America, and/or their licensors.

The name Software AG, webMethods and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA, Inc. and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners.


    </TD>
  </TR>
  

  <TR><TH class="heading" colspan=4>Version</TH></TR>
  <TR>
    <TD class="rowlabel" width="10%">Product</TD>
    <TD class="rowdata" colspan=3>webMethods RosettaNet Module</TD>
  </TR>
  <TR>
    <TD class="rowlabel">Version</TD>
    <TD class="rowdata" colspan=3>%value version% &nbsp;&nbsp;&nbsp;
       </TD>
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
                   
