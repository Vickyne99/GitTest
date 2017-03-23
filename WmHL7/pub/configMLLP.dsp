%ifvar mode equals('edit')%
	%ifvar disableport equals('true')%
		%invoke wm.server.net.listeners:disableListener%
		%endinvoke%
	%endif%
%endif%

%invoke wm.server.net.listeners:getListener%

<HTML>
	<HEAD>
	<META http-equiv="Pragma" content="no-cache">
	<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META http-equiv="Expires" content="-1">

	<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">

	<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

	<TITLE>Integration Server -- Port Access Management</TITLE>
	
	<SCRIPT Language="JavaScript">
        function confirmDisable() {
				var enabled = "%value ../listening%";
				
				if(enabled == "primary") {
				  alert("Port must be disabled to edit these settings.  Primary port cannot be disabled.  To edit these settings, please select a new primary port");
				  return false;
				}
				else if(enabled == "true") {
				 
				  if(confirm("Port must be disabled so that you can edit these settings.  Would you like to disable the port?")) {
				    document.location.replace("configMLLP.dsp?listenerKey=%value -code listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code listenerType%%endif%&mode=edit&disableport=true");
				  }
				}
				else {
				  document.location.replace("configMLLP.dsp?listenerKey=%value -code listenerKey%&pkg=%value pkg%%ifvar listenerType%&listenerType=%value -code listenerType%%endif%&mode=edit");
				}
				
				return false;
	        }
	
	        function setupData() {
	            %ifvar port%
		            document.properties.operation.value = "update";
		            document.properties.oldPkg.value = "%value pkg%";
	            %else%
		            document.properties.operation.value = "add";
			    document.properties.isservice.value = "wm.ip.hl7.tn.service:receive";
	            %endif%
				var syncin = document.properties.syncModevalue.value;
				if ( syncin == "Yes")
				   document.properties.syncMode[0].checked = true;
				 else
				  document.properties.syncMode[1].checked = true;
	        }
		  function onAdd() {
			var type = "";
			// (1) validate service name
			var svc = document.properties.isservice.value;
			var port = document.properties.port.value;
			var user = document.properties.runAsUser.value;
			
			
			if (port == "" ){
				alert ("Specify port value in the form.");
			      	document.properties.port.focus();
		      		return false;
			}
			var idx = svc.lastIndexOf(":");

			if (svc == "" || idx < 0 || idx > svc.length-1) {
			      	alert (
			        "Specify service name in the form:\n\n"+
			        "          folder.subfolder:service\n"
			      	);
			      	document.properties.isservice.focus();
		      		return false;
		    	}
			if (user == "" ){
				alert ("Specify user in the form.");
			      	document.properties.runAsUser.focus();
		      		return false;
			}
				
			//return true;
				document.properties.submit();
		  }

		function clickReturntoPorts() {
			window.location = document.getElementById('ReturntoPorts').href;
			return false;
		}

	    </SCRIPT>
	</HEAD>

	<BODY onLoad="setupData();setNavigation('/WmRoot/security-ports.dsp', '', '');">
		<TABLE width="100%">
			<TR>
				<TD class="menusection-Security" colspan=2>
					Security &gt; Ports	&gt; 
						%ifvar ../mode equals('view')%
							View MLLP Listener Details
						%else%
							Edit MLLP Listener Configuration
						%endif%
				</TD>
			</TR>
			<TR>
				<TD colspan="2">
				<UL>
		            <LI><A ID="ReturntoPorts" HREF="/WmRoot/security-ports.dsp">Return to Ports</A></LI>
		            %ifvar ../mode equals('view')%
		              %ifvar ../listening equals('primary')%
		              %else%
						<LI>
							<A onclick="return confirmDisable();" HREF="">Edit MLLP Listener Configuration</A>
						</LI>
		              %endif%
		            %endif%
				</UL>
				</TD>
			</TR>
			<TR>
				<TD><IMG SRC="/WmRoot/images/blank.gif" height=10 width=10></TD>
				<TD>
					<TABLE class="%ifvar ../mode equals('view')%tableView%else%tableForm%endif%" width='100%'>
						<TR>
							<TD class="heading" colspan="2">MLLP Listener Configuration</TD>
						<TR>
							<FORM onLoad="setupData();" id="properties" name="properties" action="/WmRoot/security-ports.dsp" method="POST">
							<input type="hidden" name="factoryKey" value="webMethods/MLLP">
							<input type="hidden" name="operation">
							<input type="hidden" name="listenerKey" value="%value listenerKey%">
							<input type="hidden" name="oldPkg">
							%ifvar listenerType%
								<input type="hidden" name="listenerType" value="%value listenerType%">
							%endif%
							<TD class="oddrow">Port</TD>
							<TD class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
								%ifvar ../mode equals('view')%
									%value port%
								%else%
									<input name="port" size="26" value="%value port%">
								%endif%
							</TD>
						</TR>
						<TR>
							<TD class="evenrow">Package Name</TD>
							<TD class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				              %ifvar ../mode equals('view')%
				                %value pkg%
				              %else%
				                %invoke wm.server.packages:packageList%
					                <select name="pkg" style="width: 15em;">
					                %loop packages%
					                    %ifvar enabled equals('false')%
					                    %else%
						                    %ifvar ../pkg -notempty%
						                    <option %ifvar ../pkg vequals(name)%selected %endif%value="%value name%">%value name%</option>
						                    %else%
						                    <option %ifvar name equals('WmHL7')%selected %endif%value="%value name%">%value name%</option>
						                    %endif%
					                    %endif%
					                %endloop%
					                </select>
				                %endinvoke%
				              %endif%
							</TD>
						</TR>
						<TR>
							<TD class="oddrow">Bind Address</TD>
							<TD class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
								%ifvar ../mode equals('view')%
									%value bindAddress%
								%else%
									<input name="bindAddress" size="26" value="%value bindAddress%">(optional)
								%endif%
							</TD>
						</TR>
						<TR>
							<TD class="evenrow">Service</TD>
							<TD class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				              %ifvar ../mode equals('view')%
				                %value isservice%
				              %else%
							<input name="isservice" size="26" value="%value isservice%">(folder.subfolder:service)
				              %endif%
							</TD>
						</TR>
						
						<TR>
							<TD class="evenrow">Synchronous ACK</TD>
							<TD class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
							<input type="hidden" name="syncModevalue" value = "%value syncMode%">
							%ifvar ../mode equals('view')%
				                %value syncMode%
				              %else%
							     	<input type="radio" name="syncMode" value="true" >Yes</input>
									<input type="radio" name="syncMode" value="false" >No</input>
								
							%endif%
							</TD>
						</TR>
						<TR>
							<TD class="oddrow">Run As User </TD>
							<TD class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
								%ifvar ../mode equals('view')%
									%value runAsUser%
								%else%
									<SCRIPT>
										function callback(val,nodeID){  
											document.getElementById('runAsUser').value=val;
										}
								        </SCRIPT>		    

			    <!--  RUN AS USER SUB CHANGES START-->

								<input name='runAsUser' size="26" id="runAsUser" value="%value runAsUser%"></input>
								<link rel="stylesheet" type="text/css" href="/WmRoot/subUserLookup.css" />
								<script type="text/javascript" src="/WmHL7/subUserLookup.js"></script>
								<a class="submodal" href="/WmHL7/subUserLookup.dsp"><img border=0 align="bottom" src="/WmRoot/icons/magnifyglass.gif"/></a> 
				<!--  RUN AS USER SUB END-->
								%endif%
							</TD>
						</TR>
						%ifvar mode equals('view')%
						%else%
							<TR>
								<TD colspan="2" class="action">
									<input type="button" value="Save Changes" onclick="return onAdd();">
									<input type="button" value="Cancel" onclick="return clickReturntoPorts();">
								</TD>
							</TR>
						%endif%
						</FORM>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
%endinvoke%
