<html>
<head>
%scope param(package='WmHL7')%
%include ../../WmRoot/pub/b2bStyle.css%
</head>
<body>
<div class="position">
<table width="100%">
	<tr>
		<td class="menusection-Solutions" colspan=7>HL7 Module &gt; About</td>
	</tr>

%invoke wm.ip.hl7.ui:getVersion%	
	<tr><TH class="heading" colspan=4>Copyright</TH></tr>
	<tr>
		<td class="rowdata" width=120><img src="../WmRoot/images/SAG_emblem_79x31.gif" border="0"></td>
	    <td class="rowdata" colspan=3>
	    
		Copyright &copy; 2001 - 2011 Software AG, Darmstadt, Germany and/or Software AG USA, Inc., Reston, VA, United States of America, and/or their licensors.
		<p>
		The name Software AG, webMethods and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA, Inc. and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners.
	    <p>
	    This software may include portions of third-party products. For third-party copyright notices and license terms, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products". This document is part of the product documentation, located at <a href="http://documentation.softwareag.com/legal">http://documentation.softwareag.com/legal</a>  and/or in the root installation directory of the licensed product(s).
		</td>
	</tr>
	<tr><TH class="heading" colspan=4>Version</TH></tr>
	<tr>
		<td class="rowlabel" width="10%">Product</td>
		<td class="rowdata" colspan=3>%value description%</td>
	</tr>
	<tr>
		<td class="rowlabel">Version</td>
		<td class="rowdata" colspan=3>%value version% &nbsp;&nbsp;&nbsp;</td>
	</tr>
%endinvoke%
%endscope%
</table>
</div>
</body>
</html>

