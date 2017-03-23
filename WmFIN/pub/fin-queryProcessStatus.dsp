<html>
<head>
<!-- fin-queryErrors.dsp -->
<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script language=javascript>
	var rowCount=0;
	var oddRow=false;
	var pageName="querySessStatus";
        var firstTime=true;
     
        function setFirstTime() {
            if (firstTime) {

                      document.write('Errors</TD>');
                      firstTime=false;
            }
            else {
                   
                      document.write('</TD>');
            }
        }

	function writeTdClassTag(){
		
		if (oddRow){
			document.write ('<td class=oddrow-l>');
		}
		else {
			document.write('<td class=evenrow-l>');
		}
	
	}
	function newRow(){
		rowCount++;
		if ((rowCount % 2) >0){
			oddRow=true;
		}
		else{
			oddRow=false;
		}
	}
	function resetRowCount(){
		rowCount=0;
	}
	function resolveName() {
		if ('%value srcPage%' != null) {
			if ('%value srcPage%' == "Statistics") {
				pageName = "statistics";
			} else if ('%value srcPage%' == "Summary") {
				pageName = "queryAlerts";
			}
		}
		
		return pageName;	
	}
	function reloadPage(id) {
		document.chooseform.processID.value = id;
		document.chooseform.subprocessNodeID.value = "0";
		
		document.chooseform.submit();
	}
	function callQueryProcessStatus(srcPage, processID, subprocessNodeID) {
		document.chooseform.srcPage.value = srcPage;
		document.chooseform.processID.value = processID;
		document.chooseform.subprocessNodeID.value = subprocessNodeID;
		
		document.chooseform.submit();
	}
	function callStepStatus(srcPage, processID, stepID, cid, statusDecode, status,
					iiter, stepiter) {
		document.stepDetail.srcPage.value = srcPage;
		document.stepDetail.processID.value = processID;
		document.stepDetail.targetStepID.value = stepID;
		document.stepDetail.qcid.value = cid;
		document.stepDetail.statusDecode.value = statusDecode;
		document.stepDetail.status.value = status;
		document.stepDetail.iiter.value = iiter;
		document.stepDetail.stepiter.value = stepiter;
		
		//document.stepDetail.submit();
	}
	
	function processControl(srcPage, instanceId,  controlAction, status){
		document.chooseform.srcPage.value = srcPage;
		document.chooseform.processID.value = instanceId;
		document.chooseform.controlAction.value = controlAction;
		document.chooseform.subprocessNodeID.value = "0";
		
		document.chooseform.submit();
	}
	function filterCustom(instanceId) {
		document.custom.processID.value = instanceId;
		document.custom.subprocessNodeID.value = "0";
		document.custom.fil.value = "true";
		if (actmsgRetrieved == 'true')
			document.custom.actMsg.value = "prev";
		else
			document.custom.actMsg.value = actmsgRetrieved;
		document.custom.custFld.value = "prev";
		
		document.custom.submit();
	}
	function sortCustom(sb, s) {
		document.location.replace("queryProcessStatus.dsp?processID="+iid+"&sort="+s+"&sortBy="+sb+"&recent="+rec+
						"&docName="+doc+"&fieldName="+field+"&fil=true&custFld=prev");
	}

	var iid="";
	var rec="";
	var doc="";
	var field="";
	
	function setVars(id, r, d, f){
		iid = id;
		rec = r;
		doc = d;
		field = f;
	}

	var actmsgRetrieved = 'false';	//indicates if activity message table has been retrieved
	var custfldRetrieved = 'false';	//indicates if custom fields table has been retrieved

	function setFlags(am, cf){
		if (am != '')
			actmsgRetrieved = am;
		if (cf != '')
			custfldRetrieved = cf;
		//alert("fil = %value fil%; actMsg = %value actMsg%; custFld = %value custFld%; processID = %value processID%; processName = %value processName%; processKey = %value processKey%; subprocessNodeID = %value subprocessNodeID%");
	}

	// determines if activity log table should be expanded or collapsed on page load
	function determineActMsgStatus()
	{
		var colobj = document.getElementById('colactmsg');
		var expobj = document.getElementById('expactmsg');
		if (actmsgRetrieved == "false")
		{
			//alert("collapse activity messages");
			colobj.style.display = 'block';
			expobj.style.display = 'none';
		}
		else
		{
			//alert("expand activity messages");
			colobj.style.display = 'none';
			expobj.style.display = 'block';
		}
	}

	// toggles activity message table between expanded and collapsed
	function toggleActMsg()
	{
		// if this is the first time the activity table has been expanded,
		// we have to reload the page in order to run the activity log query
		if (actmsgRetrieved == 'false')
			if (custfldRetrieved == 'true') {
				//alert("actMsg set to true");
				document.location.href = "queryProcessStatus.dsp?fil=true&actMsg=true&custFld=prev&subprocessNodeID=0&processID=" + iid;
			} else {
				//alert("actMsg set to true");
				document.location.href = "queryProcessStatus.dsp?fil=true&actMsg=true&custFld=" + custfldRetrieved + "&subprocessNodeID=0&processID=" + iid;
			}
		else
		{
			var colobj = document.getElementById('colactmsg');
			var expobj = document.getElementById('expactmsg');
			if (colobj.style.display == 'none')
			{
				colobj.style.display = 'block';
				expobj.style.display = 'none';
			}
			else
			{
				colobj.style.display = 'none';
				expobj.style.display = 'block';
			}
		}
	}

	// determines if custom fields table should be expanded or collapsed on page load
	function determineCustFldStatus()
	{
		var colobj = document.getElementById('colcustfld');
		var expobj = document.getElementById('expcustfld');
		if (custfldRetrieved == 'false')
		{
			//alert("collapse custom fields");
			colobj.style.display = 'block';
			expobj.style.display = 'none';
		}
		else
		{
			//alert("expand custom fields");
			colobj.style.display = 'none';
			expobj.style.display = 'block';
		}
	}

	// toggles custom fields table between expanded and collapsed
	function toggleCustFld()
	{
		// if this is the first time the custom fields table has been expanded,
		// we have to reload the page in order to run the custom fields query
		if (custfldRetrieved == 'false')
			if (actmsgRetrieved == 'true')
				document.location.href = "queryProcessStatus.dsp?fil=true&custFld=true&actMsg=prev&subprocessNodeID=0&processID=" + iid;
			else
				document.location.href = "queryProcessStatus.dsp?fil=true&custFld=true&actMsg=" + actmsgRetrieved + "&subprocessNodeID=0&processID=" + iid;
		else
		{
			var colobj = document.getElementById('colcustfld');
			var expobj = document.getElementById('expcustfld');
			if (colobj.style.display == 'none')
			{
				colobj.style.display = 'block';
				expobj.style.display = 'none';
			}
			else
			{
				colobj.style.display = 'none';
				expobj.style.display = 'block';
			}
		}
	}
</script>
<title>Monitor</title>

%include ../../WmRoot/pub/b2bStyle.css%
<SCRIPT SRC="/WmMonitor/scripts/webMethods.js"></SCRIPT>
%invoke wm.fin.resubmit:getStepErrors% 
<map name="process_map">
%ifvar ../displaySettings/viewSubprocess equals('true')%
	%loop subprocBounds%
		<area shape="rect" 
		href="javascript:callQueryProcessStatus('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', 
			'%ifvar subId%%value subId%%else%%value ../processID%%endif%',
			'%value procID%')" coords="%value x%,%value y%,%value x2%,%value y2%" alt="Subprocess">
	%endloop%
%endif ../displaySettings/viewSubprocess equals('true')%
</map>
</HEAD>
<body>
<script>
	setVars('%value processID%', '%value recent%', '%value docName%', '%value fieldName%');
	setFlags('%value actMsg%', '%value custFld%');
</script>
<table width="100%">
	<tr>
	<td class="menusection-Adapters">SWIFT &gt; Repair Messages &gt;
			Error Step
	%ifvar processName% &gt; %value processName%%endif% &nbsp;</td></tr>
	%ifvar errorMessage%
		<tr>
		  <td class="message"> %value errorMessage% </td>
		</tr>
	%else%
		%ifvar message%
			<tr><td class="message">
				%value message%
			</td>
			</tr>
		%endif%
	%ifvar imageErrorText%
		<tr><td class="message">
			%value imageErrorText%
		</td>
		</tr>
	%endif%
</table>
<TABLE width="100%">
	<tr>
	<td class="heading" colspan=3>Process Instance Status</td>
	</tr>
	<tr>
	<TD class="oddrow" colspan="1" width="20%">Process Name</td>
  %loop data%
	<TD class="oddrowdata-l" colspan="2">
		%ifvar modelName%
			%value modelName%
		%else%
			-
		%endif%
	</TD>
	</tr>
	
	<TR>
	<TD class="evenrow" colspan="1" nowrap>Instance ID</TD>
	<TD class="evenrowdata-l" colspan="2">
		%ifvar instanceID%
			%value instanceID%
		%else%
			-
		%endif%
	</TD>
	</TR>
	
	<TR>
	<TD class="oddrow" colspan="1" nowrap>Parent Process ID</TD>
	<TD class="oddrowdata-l" colspan="2">
		%ifvar parentInstanceID%
			%value parentInstanceID%
		%else%
			-
		%endif%
	</TD>
	</TR>
	<TR>
	<TD class="oddrow" colspan="1" nowrap>Status</TD>
	<TD class="oddrowdata-l" colspan"2">
		%ifvar statusDecode%
			%value statusDecode%
		%else%
			-
		%endif%
	</TD>
	</TR>
	<TR>
	<TD class="evenrow" colspan="1" nowrap>Timestamp</TD>
	<TD class="evenrowdata-l" colspan"2">
		%ifvar timestamp%
			%value timestamp%
		%else%
			-
		%endif%
	</TD>
	</TR>
   %endLoop%
	<TR>
	<TD class="evenrow" colspan="1" nowrap>Process Iteration</TD>
	<TD class="evenrowdata-l" colspan"2">
		%ifvar iiter%
			%value iiter%
		%else%
			-
		%endif%
	</TD>
	</TR>
	
	%ifvar conversationID%
	 	<TR>
		<TD class="oddrow" colspan="1" nowrap>Conversation ID</TD>
		<TD class="oddrowdata-l" colspan"2">
			%ifvar conversationID%
				%value conversationID%
			%else%
				-
			%endif%
		</TD>
		</TR>
	%endif conversationID%
		
                 
        %ifvar errors%
           %loop errors%

	   <TR>
	      <TD class="oddrow" colspan="1" nowrap>
                         
                      <script>
                	setFirstTime();
                      </script>

	         <TD class="oddrowdata-l" colspan"2">
	         %value pathName% - %value errorCode% %value errorMessage% %value data%
		</TD>
	    </TR>
            %endLoop%
                 
 	 %endif%


	
	%ifvar workflowProcess equals('true')%
	%else%
		%ifvar ../displaySettings/canControlProcess equals('true')%
		    %ifvar status%
			    %ifvar status equals('8')%
			    <TR>
			    <TD class=action colspan=3> <!--add filtering for button display based on status-->
				<input type=button value="Resume" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%',   'RESUME', '%value status%')">
				<input type=button value="Stop" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%',  'CANCEL', '%value status%')">
			     </TD>
		            </TR>
			    %endif status equals('8')%
		        %ifvar status equals('1')%
		            <TR>
			    <TD class=action colspan=3> <!--add filtering for button display based on status-->
			 	<input type=button value="Suspend" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%', 'SUSPEND', '%value status%')">
			 	<input type=button value="Stop" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%', 'CANCEL', '%value status%')">
			    </TD>
		            </TR>
			   %endif status equals('1')%
			   %ifvar status equals('2048')%
		            <TR>
			    <TD class=action colspan=3> <!--add filtering for button display based on status-->
			 	<input type=button value="Suspend" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%', 'SUSPEND', '%value status%')">
			 	<input type=button value="Stop" 
				onClick="javascript:processControl('%ifvar srcPage%%value srcPage%%else%%value ../srcPage%%endif%', '%value processID%', 'CANCEL', '%value status%')">
			    </TD>
		            </TR>
		   	    %endif status equals('2048')%
      	    %endif status%
        %endif ../displaySettings/canControlProcess equals('true')%
    %endif not workflowProcess equals('true')%
</TABLE>


%comment%
	<input type=hidden name=srcPage></input>
	<input type=hidden name=processID></input>
	<input type=hidden name=iiter></input>
	<input type=hidden name=subprocessNodeID></input>
	<input type=hidden name=status></input>
	<input type=hidden name=controlAction></input>
%endcomment%


%invoke wm.fin.resubmit:editIData%
	<table width="100%">

		<table width="100%">
			<br>
			<tr><td class=heading>Pipeline Data</td></tr>
		</table>

		<SCRIPT>
			messageInit();
			messageAdd("%value message%", 1);
			messageShow();
		</SCRIPT>

		<table>
			%value IDataPageOut%
		</table>

		<TR>
			<TD>%value formSubmitValue%
			</TD>
		</TR>
	</table>

%onerror%
	<P>error:        %value error%
	<P>errorMessage: %value errorMessage%
	<P>errorInput:   %value errorInput%
	<P>errorOutput:  %value errorOutput%
	<P>errorService: %value errorService%
%endinvoke%

<FORM name="stepDetail" action="fin-queryStepStatus.dsp" method="POST">

<script>
	resetRowCount();
</script>
	<input type=hidden name=srcPage></input>
	<input type=hidden name=processID></input>
	<input type=hidden name=targetStepID></input>
	<input type=hidden name=qcid></input>
	<input type=hidden name=statusDecode></input>
	<input type=hidden name=status></input>
	<input type=hidden name=iiter></input>
	<input type=hidden name=stepiter></input>
</FORM>
<p>

%endif no errorMessage%
%endinvoke wm.monitor.process:queryProcessStatus%
</BODY>


<script>
function collapse(basename)
{
	var colobj = document.getElementById(basename);
	var imgobj = document.getElementById("img" + basename);

	if (colobj.style.display == 'none')
	{
		colobj.style.display = 'block';
		imgobj.src = "images/tree_minus.gif";
	}
	else
	{
		colobj.style.display = 'none';
		imgobj.src = "images/tree_plus.gif";
	}
}
</script>

</HTML>
