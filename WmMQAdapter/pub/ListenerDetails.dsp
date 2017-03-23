%comment%------ Display configured Listener node ------%endcomment%
%comment%----- LG TRAX 1-MHXZY -----%endcomment%
%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
%comment%----- display lines in form have alternating colors -----%endcomment%

<SCRIPT language="JavaScript">
		var connExist="";
</SCRIPT>
<SCRIPT src="artconnjs.txt"></SCRIPT>
<html>
	<SCRIPT>
		function check(){
			if (connExist == ""){
				var mess= document.getElementById("error");
				mess.innerHTML  = "Connection previously associated with this listener is not found";
			}
			return message;
		}
	</SCRIPT>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
		 <link rel="stylesheet" TYPE="text/css" HREF="/WmART/webMethods.css"></link>    
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="artconnjs.txt"></script>
    </head>
	
	
    <body onload="disableDeadLetterFields();">
	%comment%------ LG TRAX 1-MHXP3 ------%endcomment%
	%comment%------ Removed onSubmit="return validate(form) ------%endcomment%
        <form name="form" action="ListListeners.dsp" method="POST">
            <input type="hidden" name="action"         value="editListener">
            <input type="hidden" name="passwordChange" value="false">
            <!-- ION -->
			<input type="hidden" name="searchListenerName" value="%value searchListenerName%">

            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%
          
            <table width=100%>
                <tr>
                    %ifvar readOnly equals('true')%
                        <td class="menusection-Adapters" colspan=2>Adapters &gt; %value displayName% &gt; View Listener</td>
                    %else%       
                        <td class="menusection-Adapters" colspan=2>Adapters &gt; %value displayName% &gt; Edit Listener</td>
                    %endif%    
                </tr>
              
                <tr>
                    <td colspan=2>
                        <ul>
                            <li>
                            	<!-- ION -->
                                <a href="ListListeners.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchListenerName=%value -urlencode searchListenerName%&dspName=.LISTRESOURCES">
                                    Return to %value displayName% Listeners
                                </a>
                            </li>
                            <li>
                                %ifvar readOnly equals('true')%
				    				<a href="NotificationOrder.dsp?readOnly=true&adapterDisplayName=%value displayName%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%">
                                        View Notification Order
                                    </a>
                                %else%       
                					%invoke wm.mqseries.admin:isChildListenerInheritingNotifications%
	                					%ifvar isInheritingNotifications equals('false')%
		                                    <a href="NotificationOrder.dsp?readOnly=false&adapterDisplayName=%value displayName%&adapterTypeName=%value -urlencode adapterTypeName%&listenerNodeName=%value listenerNodeName%">
		                                        Edit Notification Order
		                                    </a>
		                                %else%
		                                    Edit Notification Order (Cannot edit the order as there are no Notifications registered)
		                                %endif%
            						%onerror%
                                    %endinvoke%
                                %endif%
                            </li>
                        </ul>
                    </td>
                </tr>
			</table>
             <table width=100%  class="tableView">
               
                %invoke wm.art.ns:getListenerConfiguration%

                    <tr>
                        <td class="heading" colspan=2>%value listenerNodeName% Details</td>
                    </tr>
                      
                    <tr>
                        <script>writeTD('row');</script>Listener Type</td>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar mcfDisplayName%
                                %value mcfDisplayName%
                            %else%
                                %value connectionFactoryType%
                            %endif%
                        </td>
                    </tr>
    
                    <tr>
                        <script>writeTD('row');</script>Package Name</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
                    </tr>    
                    
                    %ifvar requiresConnection equals('yes')%
                        <tr>
                            <script>writeTD('row');</script>Connection Name</td>
                            <script>writeTD('rowdata-l');swapRows();</script>
                                %ifvar readOnly equals('true')%
                                    %value connDataNodeName%
                                %else%
                                    %invoke wm.art.admin.connection:listResources%
                                        %ifvar connDataNode -notempty%
                                            <select name="connDataNodeName" size=1>
                                                %loop connDataNode%
                                                    <option value="%value connectionAlias%"
                                                            %ifvar ../connDataNodeName vequals(connectionAlias)% selected="true" %endif%
                                                    >
                                                        %value connectionAlias%
                                                    </option>
                                                %endloop%
                                            </select>
                                        %else%
                                            no connections
                                        %endif%
                                    %endinvoke%
                                %endif%
                            </td>
                        </tr>
                    %endif%
                
                    <tr>
                        <script>writeTD('row');</script>Retry Limit</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar readOnly equals('true')%
                                %value retryLimit%
                            %else%
                                 <input size=60 name="retryLimit" value="%value retryLimit%"></input></td>
                            %endif%
                        </td>
                    </tr>    
                    
                    <tr>
                        <script>writeTD('row');</script>Retry Backoff Timeout</TD>
                        <script>writeTD('rowdata-l');swapRows();</script>
                            %ifvar readOnly equals('true')%
                                %value retryBackoffTimeout%
                            %else%
                                 <input size=60 name="retryBackoffTimeout" value="%value retryBackoffTimeout%"></input></td>
                            %endif%
                        </td>
                    </tr>    
                    
                    %include DisplayListenerDetails.dsp%
                
                %onerror%
                    %ifvar localizedMessage%
                        %comment%-- Localized error message supplied --%endcomment%
                        <tr><td class="message">Error encountered <pre>%value localizedMessage%</pre></td></tr>
                    %else%
                        %ifvar error%
                            <tr><td class="message">Error encountered <pre>%value errorMessage% (%value error%)</pre></td></tr>
                        %endif%
                    %endif%
                %endinvoke%
            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('true')%
                        %else%
			    %comment%------ LG TRAX 1-MHXP3 ------%endcomment%
			    %comment%------ Removed onclick="return setPasswordEdit() ------%endcomment%
			    %comment%------ Added onclick="return validate(this.form) ------%endcomment%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100 onclick="return validateForm(this.form)"></input>
                            <input type="hidden" name="adapterTypeName"    value="%value adapterTypeName%">
                            <input type="hidden" name="listenerTemplate"   value="%value listenerTemplate%">       
                            <input type="hidden" name="listenerNodeName"   value="%value listenerNodeName%">
                            <input type="hidden" name="requiresConnection" value="%value requiresConnection%">
                        %endif%        
                    </td>
                </tr>
            </table>
        </form>    
    </body>
</html>
