<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT>
	  function checkValidity() {
	    		if(document.getElementById("validationFailed")!=null && document.getElementById("validationFailed").value == 'true'){
	    		document.getElementById("form1").action= 'edit.dsp';
	    		document.getElementById("form1").submit();
	    		}
    }
</SCRIPT>
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>

 %ifvar saveMessage equals('infoSaved')%
    %invoke wm.swiftnet.server.util:saveSettings%
    %endinvoke%
  %endif%

%ifvar saveMessage equals('infoSaved')%
<TD class="heading" colspan="2">Connection configuration information has been saved successfully. Please reload the package to apply changes.</TD>
%endif%


<BODY onload="checkValidity()">
<FORM NAME="form1" ACTION="edit.dsp" id="form1"  method="POST">

   %ifvar funct equals('validationFailed')%
          <INPUT name = "validationFailed" id = "validationFailed" TYPE="TEXT" VALUE="%value validationFailed%" SIZE="25">
          <INPUT name = "result" id = "result" TYPE="HIDDEN" VALUE="%value result%" SIZE="200">
   %endif%
   
<TABLE width="100%">
    <TR>
      <TD class="menusection-adapters" colspan="2">
          SWIFT &gt; SWIFTNet 
          Server Configuration 
      </TD>
    </TR>
    <TR>
      <TD colspan="2">        
      </TD>
    </TR>
    <TR> 
      
      <TD>
        %ifvar funct equals(Display)%
          <TABLE class="tableView">
        %else%
          <TABLE class="tableForm">
        %endif%
          <TR>
            <TD class="heading" colspan="2">SWIFTNet Remote Process Connection Configuration </TD>
          </TR>          

          		    %invoke wm.swiftnet.server.util:retrieveConnectionInfo%
			    
			    
		          <tr>
	            	  <td class="oddrow">User Name</td>
	                  <td class="oddrowdata-l">%value userName%</td>
              		</tr>
	                <tr>
	            	  <td class="oddrow">Password</td>
	                  <td class="oddrowdata-l">*******</td>
              		</tr>
	                <tr>
	            	   <td class="oddrow">Host</td>
	                  <td class="oddrowdata-l">%value host%</td>
              		</tr>
	                <tr>
	            	   <td class="oddrow">Port</td>
	                  <td class="oddrowdata-l">%value port%</td>
              		</tr>              		
              		
              		 <TR>
			            <TD class="heading" colspan="2">SWIFTNet Server Environment Information </TD>
          		</TR> 
          		<tr>
						   <td class="oddrow">SWNET_CFG_PATH</td>
						  <td class="oddrowdata-l">%value SWNET_CFG_PATH%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">SystemRoot</td>
						  <td class="oddrowdata-l">%value SystemRoot%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">SWNET_BIN_PATH</td>
						  <td class="oddrowdata-l">%value SWNET_BIN_PATH%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">SWNET_HOME</td>
						  <td class="oddrowdata-l">%value SWNET_HOME%</td>
              		</tr>

              		<tr>
						   <td class="oddrow">PROCESS_INSTANCES</td>
						  <td class="oddrowdata-l">%value PROCESS_INSTANCES%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">RMI Port</td>
						  <td class="oddrowdata-l">%value RMIPort%</td>
              		</tr>
              		 <TR>
			            <TD class="heading" colspan="2">SWIFTNet Server SAG Connection Properties </TD>
          		</TR> 
          		<tr>
						   <td class="oddrow">SAGMessagePartner</td>
						  <td class="oddrowdata-l">%value SAGMessagePartner%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">server_pki_profile</td>
						  <td class="oddrowdata-l">%value server_pki_profile%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">server_pki_password</td>
						  <td class="oddrowdata-l">*******</td>
              		</tr>
					<tr>
						   <td class="oddrow">userDN</td>
						  <td class="oddrowdata-l">%value SwSecUserDN%</td>
              		</tr>
					<tr>
						   <td class="oddrow">encryptDN</td>
						  <td class="oddrowdata-l">%value encryptDN%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">Sign</td>
						  <td class="oddrowdata-l">%value Sign%</td>
              		</tr>

              		<tr>
						   <td class="oddrow">Decrypt</td>
						  <td class="oddrowdata-l">%value Decrypt%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">Authorization</td>
						  <td class="oddrowdata-l">%value Authorisation%</td>
              		</tr>

              		<tr>
						   <td class="oddrow">AllFileEvents</td>
						  <td class="oddrowdata-l">%value AllFileEvents%</td>
              		</tr>

              		<tr>
						   <td class="oddrow">FullFileStatus</td>
						  <td class="oddrowdata-l">%value FullFileStatus%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">SwEventEP</td>
						  <td class="oddrowdata-l">%value SwEventEP%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">ReceptionFolder</td>
						  <td class="oddrowdata-l">%value ReceptionFolder%</td>
              		</tr>
              		<tr>
						   <td class="oddrow">SwTransferEP</td>
						  <td class="oddrowdata-l">%value SwTransferEP%</td>
              		</tr>
              		
              		<tr>
						   <td class="oddrow">cryptoMode</td>
						  <td class="oddrowdata-l">%value cryptoMode%</td>
						  
              		</tr>
              		
              		<tr>
									   <td class="oddrow">Transport</td>
									  <td class="oddrowdata-l">%value Transport%</td>
									  
              		</tr>
              		
              		<tr>
									   <td class="oddrow">MQ Request Reply Client Service</td>
									  <td class="oddrowdata-l">%value MQ_Request_Reply_Client_Service%</td>
									  
              		</tr>
              		
              		<tr>
									   <td class="oddrow">MQ Put Server Service</td>
									  <td class="oddrowdata-l">%value MQ_Put_Server_Service%</td>
									  
              		</tr>
              		
					<tr>
									   <td class="oddrow">MQ Listener Notification Document</td>
									  <td class="oddrowdata-l">%value MQ_Listener_Notification_Document%</td>
									  
              		</tr>
       		
              		
			    %endinvoke%
              		
            <TR>
              <TD colspan="2" class="action">
                <INPUT type="submit" value="Edit"> 
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
