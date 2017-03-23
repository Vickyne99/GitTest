<html>
<body onLoad="toggleResponse();">

<script language="JavaScript">

function selectResponse() {
	document.getElementById('noResponse').checked=false;
	toggleResponse();	
	
}


function selectNoResponse() {
	document.getElementById('hasResponse').checked=false;
	toggleResponse();	
	
}



function toggleResponse() {
	if (document.getElementById('hasResponse').checked==true){
		document.getElementById('rAction').style.visibility = "visible";
		document.getElementById('rDTD').style.visibility = "visible";
	} else {	
		document.getElementById('rAction').style.visibility = "hidden";
		document.getElementById('rDTD').style.visibility = "hidden";
	}
}

function openWindow(windowText) {
	alert(windowText);
}

</script>
%invoke wm.ip.rn.ns:listB2BSchemas%
%ifvar b2bSchemaNames%
%else%
	<TABLE WIDTH="85%">
		<TR><TD CLASS="message">Warning: IS Schema MUST be imported before building Pip</TD></TR>
	</TABLE>	
%end ifvar%
%onerror%
	<TABLE WIDTH="85%">
		<TR><TD CLASS="message">Warning: IS Schema MUST be imported before building Pip</TD></TR>
	</TABLE>
%end invoke%
%invoke wm.ip.file:listDTDs%
%ifvar files%
%else%
	<TABLE WIDTH="85%">
		<TR><TD CLASS="message">Warning: A DTD MUST be in the PIP Tools import directory before building a Pip</TD></TR>
	</TABLE>
	
%end ifvar%
%end invoke%

<FORM METHOD="POST" ACTION="rn-build.dsp" name="bpbuild">
<INPUT TYPE="HIDDEN" NAME="formAction" VALUE="preview">
%invoke wm.ip.rn.pip:checkBuildPIPInput%
<table border="0" width="90%">
    <TH class="heading" colspan="2">Build PIP</TH>
  <tr>
    <td class="rowlabel" width="25%">Pip Name</td>
    <td class="rowdata" width="82%"><input type="text" name="description" 
value="%value description%" size="20"><img border="0" 
src="images/help_icon.gif" align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('This is the full name of the PIP (eg. \'Request Purchase Order\')\nIt can be found on the front page of the Pip Specification');">%ifvar descriptionError%
    	    <span>%value descriptionError%</span>
    %end ifvar%</td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">Pip Number</td>
    <td class="rowdata" width="82%"><input type="text" name="code" 
value="%value code%" 
size="20"><img border="0" src="images/help_icon.gif" align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('The code given to this PIP (eg. \'3A4\')\nIt can be found on the front page of the Pip Specification');">
      %ifvar codeError%
    	    <span>%value codeError%</span>
    %end ifvar%
    </td>    
  </tr>
  <tr>
    <td class="rowlabel" width="18%">Pip Version</td>
    <td class="rowdata" width="82%"><input type="text" name="version" 
value="%value version%" size="20"><img border="0" src="images/help_icon.gif" 
align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('The version of this PIP (eg. \'R02.00\')\nIt may be found on the front page of the Pip Specification.  It must follow the correct format.\nPlease see RNIF Technical Advisory A for more information');">
      %ifvar versionError%
    	    <span>%value versionError%</span>
    %end ifvar%
    </td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">Transaction</td>
    <td CLASS="rowdata" width="82%"><input type="text" name="transaction" 
value="%value transaction%" size="20"><img border="0" 
src="images/help_icon.gif" align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('The PIP transaction being built (eg. \'Purchase Order Request\')\nA PIP transaction is combination of one or more actions\nIt may be found as \'ActivityName\' in table 3-2 of the Pip Specification.');">
      %ifvar transactionError%
    	    <span>%value transactionError%</span>
    %end ifvar%
	</td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">Action</td>
    <td CLASS="rowdata" width="82%"><input type="text" name="action" 
value="%value action%" size="20"><img border="0" src="images/help_icon.gif" 
align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('The PIP action for the request document (eg. \'Request Purchase Order Action\')\nIt may be found as \'Business Action\' in table 4-2 of the Pip Specification.');">
      %ifvar actionError%
    	    <span>%value actionError%</span>
    %end ifvar%
    </td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">DTD</td>
    <td CLASS="rowdata" width="82%"><select size="1" name="requestDTD">
       	<option>%value requestDTD%</option>
		%invoke wm.ip.file:listDTDs%
    	%loop files%
       	<option>%value files%</option>
       %end files%         
    </select><img border="0" src="images/help_icon.gif" align="top"
     onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
     onclick="openWindow('DTD for the request document.\nIt should be included with the Pip specification.\nThe DTD must be put in packages \'Import\' directory');"></td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">From Role</td>
    <td CLASS="rowdata" width="82%"><select size="1" name="fromRole">
       	<option>%value fromRole%</option>
		%invoke wm.ip.rn.pip:getRoles%
    	%loop roles%
       	<option>%value roles%</option>
       %end loop%         
    </select><img border="0" src="images/help_icon.gif" align="top"
     onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
     onclick="openWindow('Role of the initiating partner (eg. \'Buyer\').\nIt may be found in Table 3-1: Partner Role Descriptions of the Pip specification');">
        %ifvar fromRoleError%
    	    <span>%value fromRoleError%</span>
    	%end ifvar%
</td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">To Role</td>
    <td CLASS="rowdata" width="82%"><select size="1" name="toRole">
       	<option>%value toRole%</option>
      	%invoke wm.ip.rn.pip:getRoles%
    	%loop roles%
       	<option>%value roles%</option>
       %end loop%
      </select><img border="0" src="images/help_icon.gif" align="top"
       onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
       onclick="openWindow('Role of the furfiller partner (eg. \'Seller\').\nIt may be found in Table 3-1: Partner Role Descriptions of the Pip specification');">
       %ifvar toRoleError%
    	    <span>%value toRoleError%</span>
    	%end ifvar%
    </td>
  </tr>
    <tr>
    <td class="rowlabel" width="18%">IS Schema Dictionary</td>
    <td CLASS="rowdata" width="82%"><select size="1" name="schemaNodeName">
		<option>%value schemaNodeName%</option>
		%invoke wm.ip.rn.ns:listB2BSchemas%
    	%loop b2bSchemaNames%
       	<option>%value b2bSchemaNames%</option>
       %end loop%         
    </select>
    <input type="radio" value="false" name="referenceB2BSchema" checked>Static
    <input type="radio" value="true" name="referenceB2BSchema">Reference<img 
border="0" 
src="images/help_icon.gif" align="top"
     onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
     onclick="openWindow('The RosettaNet Business Dictionary Schema to apply values from or reference');">
    %ifvar schemaNodeNameError%
    	    <span>%value schemaNodeNameError%</span>
    %end ifvar%
</td>
  </tr>
  <tr>
    <td class="rowlabel" width="18%">Has Response Document</td>
    <td CLASS="rowdata" width="82%">
    <input type="radio" name="hasResponse" id="hasResponse" 
onclick="selectResponse();"
%ifvar hasResponse equals('true')%
 checked
%else%
	%ifvar hasResponse equals('on')%
 		checked
	%end ifvar%
%end ifvar%
>True<input type="radio" value="false" 
name="hasReponse" id="noResponse" 
onclick="selectNoResponse();"
%ifvar hasResponse equals('true')%
%else%
	%ifvar hasResponse equals('on')%
	%else%
		checked
	%end ifvar%
%end ifvar%
>False</td>
  </tr>
  <tr ID="rAction" style="visibility: hidden;" checked>
    <td class="rowlabel" width="18%">Response Action</td>
    <td CLASS="rowdata" width="82%"><input type="text" name="responseAction" 
value="%value responseAction%" size="20"><img border="0" 
src="images/help_icon.gif" align="top"
 onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
 onclick="openWindow('The PIP action for the response document (eg. \'Confirm Purchase Order Action\')');"></td>
  </tr>
  <tr ID="rDTD" style="visibility: hidden;">
    <td class="rowlabel" width="18%">Response DTD</td>
    <td CLASS="rowdata" width="82%"><select size="1" name="responseDTD" ID="rd">
       	<option>%value requestDTD%</option>
        %invoke wm.ip.file:listDTDs%
    	%loop files%
       	<option>%value files%</option>
       %end files%         
    </select><img border="0" src="images/help_icon.gif" align="top"
     onmouseover="this.src='images/help_icon_pushed.gif'" 
onmouseout="this.src='images/help_icon.gif'"
     onclick="openWindow('DTD for the response document\nThe DTD must be put in packages \'Import\' directory');"></td>
  </tr>
  <tr>
%end invoke%
    <td class="action" colspan="2" width="18%">	<INPUT TYPE="SUBMIT" 
value="Preview PIP"></td>
  </tr>
</table>
</FORM>


</body>
</html>
