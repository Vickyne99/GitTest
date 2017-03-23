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
    	
      if (!verifyRequiredField("form1","SWNET_CFG_PATH"))
      {
         alert("SWnet Config path Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","SWNET_BIN_PATH"))
      {
         alert("SWIFT Bin path Must be specified");
         return false;
      }
      if (!verifyRequiredField("form1","SWNET_HOME"))
      {
         alert("SWIFT home Must be specified");
         return false;
      }
      if (!verifyRequiredNonNegNumber("form1","RMIPort"))
      {
         alert("RMI Port must be a non-negative number");
         return false;
      }      
      return true;
    }
    
    function cancel() {
		document.getElementById("saveMessage").value='cancel';
    	document.getElementById("form1").action = 'index.dsp';
    	document.getElementById("form1").submit();
    }
    
 
    
</SCRIPT>
</HEAD>

 
<BODY>

<FORM NAME="form1" id= "form1" action="index.dsp" method="POST">
    %invoke wm.swiftnet.client.util:retrieveConfigInfo%
    %endinvoke%

  <TABLE width="100%">
    <TR>
      <TD class="menusection-adapters" colspan="2">
          SWIFT &gt; Edit SWIFTNet
          Client Configuration 
      </TD>
    </TR>
    
    <TR><TD colspan="2" class="keymessage">%value result%</TD></TR>
  
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
	              <TD class="heading" colspan="2">SWIFTNet Client Environment Information</TD>
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
          </TR>  
          <TR>
           <SCRIPT>swapRows();</SCRIPT>
	  	            <TR>
	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                RMI Port</TD>
	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	  	                  <INPUT NAME="RMIPort" TYPE="TEXT" VALUE="%value RMIPort%" SIZE="25">
	  	              </TD>
          </TR>
          
          
                     <TR>
	  	              <TD class="heading" colspan="2">SWIFTNet Client SAG Connection Configuration</TD>
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
	                client_pki_profile</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="client_pki_profile" TYPE="TEXT" VALUE="%value client_pki_profile%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                client_pki_password</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="client_pki_password" TYPE="password" VALUE="%value client_pki_password%" SIZE="25">
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
	            <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                requestor</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="requestor" TYPE="TEXT" VALUE="%value requestor%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                responder</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="responder" TYPE="TEXT" VALUE="%value responder%" SIZE="25">
	              </TD>
	            </TR>
	            
	            
	            
	             <SCRIPT>swapRows();</SCRIPT>
	  	            <TR>
	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                service</TD>
	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	  	                  <INPUT NAME="service" TYPE="TEXT" VALUE="%value service%" SIZE="25">
	  	              </TD>
	            </TR>
	             <SCRIPT>swapRows();</SCRIPT>
	  	            <TR>
	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                encryptDN</TD>
	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	  	                  <INPUT NAME="encryptDN" TYPE="TEXT" VALUE="%value encryptDN%" SIZE="35">
	  	              </TD>
	            </TR>
	             <SCRIPT>swapRows();</SCRIPT>
	  	            <TR>
	  	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	  	                userDN</TD>
	  	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	  	                  <INPUT NAME="userDN" TYPE="TEXT" VALUE="%value userDN%" SIZE="35">
	  	              </TD>
	            </TR>

	             <SCRIPT>swapRows();</SCRIPT>
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
	                ReceptionFolder</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="ReceptionFolder" TYPE="TEXT" VALUE="%value ReceptionFolder%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
				
				<TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                physicalName</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="physicalName" TYPE="TEXT" VALUE="%value physicalName%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
				
				<TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                logicalName</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="logicalName" TYPE="TEXT" VALUE="%value logicalName%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
				
				
				
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                SwTransferEP</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="SwTransferEP" TYPE="TEXT" VALUE="%value SwTransferEP%" SIZE="25">
	              </TD>
	            </TR> <SCRIPT>swapRows();</SCRIPT>
	            <TR>
	              <SCRIPT>writeTDnowrap("row");</SCRIPT>
	                SwEventEP</TD>
	              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	                  <INPUT NAME="SwEventEP" TYPE="TEXT" VALUE="%value SwEventEP%" SIZE="25">
	              </TD>
	            </TR><SCRIPT>swapRows();</SCRIPT>
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