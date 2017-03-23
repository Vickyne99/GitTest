<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>


 

<SCRIPT>
    function update()
    {
    	
      if (!verifyRequiredField("form1","userName"))
      {
         alert("User Name Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","password"))
      {
         alert("Password Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","host"))
      {
         alert("Host Must be specified");
         return false;
      }
      if (!verifyRequiredNonNegNumber("form1","port"))
      {
         alert("Port must be greater than 0");
         return false;
      }   
	  if (!verifyRequiredNonNegNumber("form1","RMIPort"))
      {
         alert("RMI Port must be a non-negative number");
         return false;
      }      
     
      return true;
    }
    
    function fillPassword(){
    	var oldPass  = document.getElementById('form1').oldPassword.value;   
    	if(oldPass.length>1) {
    		document.getElementById('form1').password.value = oldPass;
    		}
    	}
    	
  
    
    function testParams() {
    		document.getElementById("funct").value = 'test';		
    		document.getElementById("form1").action= 'edit.dsp?funct=test';
    		document.getElementById("form1").submit();
    }
    
    
    function cancel() {
			document.getElementById("saveMessage").value='cancel';
    		document.getElementById("form1").action= 'index.dsp';
    		document.getElementById("form1").submit();
    }
 
    
</SCRIPT>
</HEAD>

 
<BODY onload="fillPassword()">

<FORM NAME="form1" id ="form1" action="index.dsp" method="POST">
   
  <TABLE width="100%">
  

    <TR>
      <TD class="menusection-adapters" colspan="2">
          SWIFT &gt; Edit SWIFTNet
          Server Configuration 
      </TD>
    </TR>
    %ifvar result equals('')%
    test
    %else%
    <TR><TD colspan="2" class="keymessage">%value result%</TD></TR>
    %end%
   %switch funct%
        %case 'test'%
          %invoke wm.swiftnet.server.util:testConnectionInfo%
          %endinvoke%
              <TR><TD colspan="2" class="keymessage">%value result%</TD></TR>             
     %endswitch%
   
    <TR> 
       
      <TD>
        %ifvar funct equals(Display)%
          <TABLE class="tableView">
        %else%
          <TABLE class="tableForm">
        %endif%
        
         %invoke wm.swiftnet.server.util:retrieveConnectionInfo%
	    %endinvoke%

          <TR>
            <TD class="heading" colspan="2">SWIFTNet Remote Process Connection Configuration</TD>
          </TR>          
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              User Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="userName" TYPE="TEXT" VALUE="%value userName%" SIZE="25">
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                Password</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>	              
	                  <INPUT NAME="password" TYPE="PASSWORD" VALUE="%value password%" SIZE="25">
	              </TD>
	            </TR>
	            <TR>
	            <input name ="oldPassword" type = "hidden" value = "%value passwordHandle%"/>
	            <input name ="funct" id = "funct" type = "hidden" />
	            </TR>

          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Host IP</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>            
                <INPUT NAME="host" TYPE="TEXT" VALUE="%value host%" SIZE="25">              
            </TD>
          </TR>         
          
           <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                Host Port</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="port" TYPE="TEXT" VALUE="%value port%" SIZE="25">
	              </TD>
          </TR>
          
           <TR>
	                <TD colspan="2" align = "center" class="action" >
	                <a href = "#" onclick= "testParams()">Test Connection Settings</a>	                   
	                </TD>
            </TR>
          
          
           <TR>
	              <TD class="heading" colspan="2">SWIFTNet Server Environment Information</TD>
          </TR> 
           <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                SWNET_CFG_PATH</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="SWNET_CFG_PATH" TYPE="TEXT" VALUE="%value SWNET_CFG_PATH%" SIZE="25">
	              </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SystemRoot</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SystemRoot" TYPE="TEXT" VALUE="%value SystemRoot%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SWNET_BIN_PATH</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SWNET_BIN_PATH" TYPE="TEXT" VALUE="%value SWNET_BIN_PATH%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SWNET_HOME</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SWNET_HOME" TYPE="TEXT" VALUE="%value SWNET_HOME%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              PROCESS_INSTANCES</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="PROCESS_INSTANCES" TYPE="TEXT" VALUE="%value PROCESS_INSTANCES%" SIZE="25">
            </TD>
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              RMI Port</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="RMIPort" TYPE="TEXT" VALUE="%value RMIPort%" SIZE="25">
            </TD>
          </TR>
          
          <TR>
	  			            <TD class="heading" colspan="2">SWIFTNet Server SAG Connection Properties </TD>
          		</TR>
          
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SAGMessagePartner</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SAGMessagePartner" TYPE="TEXT" VALUE="%value SAGMessagePartner%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              server_pki_profile</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="server_pki_profile" TYPE="TEXT" VALUE="%value server_pki_profile%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              server_pki_password</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="server_pki_password" TYPE="password" VALUE="%value server_pki_password%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
		  
		  <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              userDN</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SwSecUserDN" TYPE="TEXT" VALUE="%value SwSecUserDN%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
		  <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              encryptDN</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="encryptDN" TYPE="TEXT" VALUE="%value encryptDN%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
		  
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Sign</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                 <SELECT NAME="Sign">
		      <OPTION %ifvar Sign vequals(valueFalse)% SELECTED %endif%>FALSE</option>
		<OPTION %ifvar Sign vequals(valueTrue)% SELECTED %endif%>TRUE</option>

		</SELECT>
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Decrypt</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>           
                  <SELECT NAME="Decrypt">
			 <OPTION %ifvar Decrypt vequals(valueFalse)% SELECTED %endif%>FALSE</option>
			<OPTION %ifvar Decrypt vequals(valueTrue)% SELECTED %endif%>TRUE</option>
			                	
            </SELECT>
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Authorization</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <SELECT NAME="Authorisation">
	                 <OPTION %ifvar Authorisation vequals(valueFalse)% SELECTED %endif%>FALSE</option>
	                   	<OPTION %ifvar Authorisation vequals(valueTrue)% SELECTED %endif%>TRUE</option>
	                   	
            </SELECT>
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              AllFileEvents</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <SELECT NAME="AllFileEvents">
			                 <OPTION %ifvar AllFileEvents vequals(valueFalse)% SELECTED %endif%>FALSE</option>
			                   	<OPTION %ifvar AllFileEvents vequals(valueTrue)% SELECTED %endif%>TRUE</option>
			                   	
            </SELECT>
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              FullFileStatus</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                 <SELECT NAME="FullFileStatus">
		          <OPTION %ifvar FullFileStatus vequals(valueFalse)% SELECTED %endif%>FALSE</option>
		            	<OPTION %ifvar FullFileStatus vequals(valueTrue)% SELECTED %endif%>TRUE</option>
		            	
            </SELECT>
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SwEventEP</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SwEventEP" TYPE="TEXT" VALUE="%value SwEventEP%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              ReceptionFolder</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="ReceptionFolder" TYPE="TEXT" VALUE="%value ReceptionFolder%" SIZE="25">
            </TD>
          </TR> <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              SwTransferEP</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="SwTransferEP" TYPE="TEXT" VALUE="%value SwTransferEP%" SIZE="25">
            </TD>
          </TR>
          
           <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                cryptoMode</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="cryptoMode" TYPE="TEXT" VALUE="%value cryptoMode%" SIZE="25">
	              </TD>
          </TR>
           <TR>
	  	             <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                Transport</TD> <SCRIPT>writeTDnowrap("row-l");</SCRIPT><SELECT NAME="Transport">
	            <OPTION %ifvar Transport vequals(valueRA)% SELECTED %endif%>RAHA</option>
	              	<OPTION %ifvar Transport vequals(valueMQHA)% SELECTED %endif%>MQHA</option>
	              	
	              </SELECT>
	  	              </TD>
	            </TR><SCRIPT>swapRows();</SCRIPT>
	            <TR>
	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                MQ Request Reply Client Service</TD>
	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	  	                  <INPUT NAME="MQ_Request_Reply_Client_Service" TYPE="TEXT" VALUE="%value MQ_Request_Reply_Client_Service%" SIZE="25">
	  	              </TD>
	            </TR><SCRIPT>swapRows();</SCRIPT>
	            
		    	            <TR>
		    	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
		    	  	                MQ Put Server Service</TD>
		    	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
		    	  	                  <INPUT NAME="MQ_Put_Server_Service" TYPE="TEXT" VALUE="%value MQ_Put_Server_Service%" SIZE="25">
		    	  	              </TD>
		    	            </TR><SCRIPT>swapRows();</SCRIPT>
		    	            
	            </TR><SCRIPT>swapRows();</SCRIPT>
		    	            <TR>
		    	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
		    	  	                MQ Listener Notification Document</TD>
		    	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
		    	  	                 <INPUT NAME="MQ_Listener_Notification_Document" TYPE="TEXT" VALUE="%value MQ_Listener_Notification_Document%" SIZE="25">
		    	  	              </TD>
		    	            </TR><SCRIPT>swapRows();</SCRIPT>
		    	            
                    
          <SCRIPT>swapRows();</SCRIPT>
            <TR>
              <TD colspan="2" align = "center" class="action" >
              <INPUT type="submit" value="  Save  " onClick="return update();">              
	           <INPUT type="button" value="  Cancel  " onClick="return cancel();">
              </TD>
            </TR>
        </TABLE>
      </TD>
    </TR>
     <INPUT type="hidden" name="saveMessage" id="saveMessage" value = "infoSaved"/>
  </TABLE>      
</FORM>
</BODY>
</HTML>