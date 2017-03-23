<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="artconnjs.txt"></script>
	</head>
		
	<body onload="handleConnectionTypeChangeOnLoad()">

        <form name="form" action="ListResources.dsp" method="POST" onSubmit="return validateForm(form)">
        <input type="hidden" name="action" value="editConnection">
        <input type="hidden" name="listAllConnection" value="listAllConnection">
        <input type="hidden" name="passwordChange" value="false">
            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%

            <table width=100%>
            <tr>
                %ifvar readOnly equals('true')%
                    <td class="menusection-Adapters" colspan=4>HL7 Module &gt; MLLP Connections &gt; View Connection</td>
                %else%       
                    <td class="menusection-Adapters" colspan=4>HL7 Module &gt; MLLP Connections &gt; Edit Connection</td>
                %endif%    
            </tr>
            <tr>
                <td colspan=2>
                    <ul>
                    <li><A HREF="/WmHL7/mllp/ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTRESOURCES&listAllConnection=listAllConnection">Return to MLLP Connections</A>
                    </ul>
                </td>
            </tr>
           
            %invoke wm.art.admin.connection:getResourceConfiguration%
                <tr>
                    <td class="heading" colspan=2>%value connectionAlias% Details</td>
                </tr>
              
                <tr>
                    <script>writeTD('row');</script>Connection Type</td>
                    <script>writeTD('rowdata-l');swapRows();</script>%ifvar mcfDisplayName%%value mcfDisplayName%%else%%value connectionFactoryType%%endif%</td>
                </tr>

                <tr>
                    <script>writeTD('row');</script>Package Name</TD>
                    <script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
                </tr>    
            
                %include EditConnectionProperties.dsp%
                   
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%    
                %include EditConnectionManagerProperties.dsp%
                %comment%----------------------End ConnectionManagerProperties--------------%endcomment%  
            
            %onerror%
                %ifvar localizedMessage%
                    %comment%-- Localized error message supplied --%endcomment%
                    <tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
                %else%
                    %ifvar error%
                        <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
                    %endif%
                %endif%
            %endinvoke%

            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('false')%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100></input>
                            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
                            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%">       
                            <input type="hidden" name="connectionAlias" value="%value connectionAlias%">
                        %endif%        
                    </td>    
                </tr>
            </table>
        </form>    
    </body>
</html>
