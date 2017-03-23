<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>




<FORM NAME="form1" ACTION="index.dsp" method="POST">
<TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          SWIFTNet &gt;
          User Configuration 
      </TD>
    </TR>
  
    <TR>
      <TD colspan="2">        
      </TD>
    </TR>
    <TR> 
       <TD>
        <IMG SRC="images/blank.gif" height=10 width=10 border=0>
      </TD>
      <TD>
        %ifvar funct equals(Display)%
          <TABLE class="tableView">
        %else%
          <TABLE class="tableForm">
        %endif%
          <TR>
            <TD class="heading" colspan="2">SWIFTNet User Configuration Saved SuccessFullly</TD>
          </TR>          
          				%invoke wm.swiftnet.server.util:retrieveConnectionInfo%
	                <tr>
	            	   <td class="oddrow">User Name</td>
	                  <td class="oddrowdata-l">%value userName%</td>
              </tr>
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Return">
              </TD>
            </TR>
          %endif%
          
        </TABLE>
      </TD>
    </TR>
  </TABLE>      
</FORM>
</BODY>
</HTML>
