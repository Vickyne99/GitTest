%comment%----- Lists configured connections -----%endcomment%
<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>List Connections</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>

        <SCRIPT LANGUAGE="JavaScript">
            function confirmDisable (aliasName)
            {
                var s1 = "OK to disable the `"+aliasName+"' connection?\n\n";
                var s2 = "Disabling a connection causes all services to be \n";
                var s3 = "unavailable for use.\n";
                return confirm (s1+s2+s3);
            }
            function confirmEnable (aliasName)
            {
                var s1 = "OK to enable the `"+aliasName+"' connection?\n\n";
                return confirm (s1);
            }
            function confirmDelete (aliasName)
            {
                var s1 = "OK to delete the `"+aliasName+"' connection?\n\n";
                return confirm (s1);
            }
        </SCRIPT>

        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    </head>

    %invoke wm.art.admin:getAdapterTypeOnlineHelp%
    %onerror%
    %endinvoke%

    %invoke wm.art.admin:retrieveAdapterTypeData%
    %onerror%
    %endinvoke%

    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
        <table width="100%">
        <tr>
           <td class="menusection-Adapters" colspan=8>HL7 Module &gt; MLLP Connections</td>
        </tr>

        %ifvar action%
            %switch action%

                %case 'saveConnection'%
                    %invoke wm.art.admin.connection:createResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'deleteConnection'%
                    %invoke wm.art.admin.connection:deleteResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'editConnection'% 
                    %invoke wm.art.admin.connection:updateResource%
                    %onerror%
                        %ifvar localizedMessage%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                            %ifvar error%
                                <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                            %endif%
                        %endif%
                    %endinvoke%

                %case 'enableConnection'%
                    %invoke wm.art.admin.connection:setResourceState%
                    %onerror%
                        %ifvar localizedMessage%
                          <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                        %else%
                          %ifvar error%
                            <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                           %endif%
                        %endif%
                    %endinvoke%

            %endswitch%
        %endif%

        <tr>
            <td colspan=2>
                <ul>
                <li><a href="/WmHL7/mllp/ListAdapterConnTypes.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTCONNECTIONTYPES">Configure New MLLP Connection</a>
                </ul>
            </td>
        </tr>

        <tr>
            <td class="heading" colspan=8>Connections</td>
        </tr>

        <tr>
            <td class="oddcol-l">Connection Name</td>
            <td class="oddcol-l">Package Name</td>
            <td class="oddcol-l">Connection Type</td>
            <td class="oddcol">Enabled</td>
            <td class="oddcol">Edit</td>
            <td class="oddcol">View</td>
            <td class="oddcol">Copy</td>	
            <td class="oddcol">Delete</td>
        </tr>

        %invoke wm.art.admin.connection:listResources%
        %ifvar connDataNode -notempty%
            %loop connDataNode%
                <tr>
                    <script>writeTD('rowdata-l');</script>%value connectionAlias%</td>
                    <script>writeTD('rowdata-l');</script>%value packageName%</td>
                    <script>writeTD('rowdata-l');</script>
                        %ifvar mcfDisplayName%%value mcfDisplayName%%else%%value connectionFactoryType%%endif%
                    </td>
    
                    %switch connectionState%
                        %case 'enabled'%
                            <script>writeTD('rowdata');</script>
                                <a href="/WmHL7/mllp/ListResources.dsp?action=enableConnection&connectionAlias=%value -urlencode connectionAlias%&connectionState=disabled&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES&listAllConnection=listAllConnection"
			           ONCLICK="return confirmDisable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Disable" border=0>Yes
                                </a>
                            </td>
    
                        %case 'shuttingdown'%
                            <script>writeTD('rowdata');</script>
                                <a href="/WmHL7/mllp/ListResources.dsp?action=enableConnection&connectionAlias=%value -urlencode connectionAlias%&connectionState=shuttingdown&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES&listAllConnection=listAllConnection"
			           ONCLICK="return confirmEnable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/blank.gif" alt="Enable" border=0>No
                                </a>
                            </td>
    
                        %case 'disabled'%
                            <script>writeTD('rowdata');</script>
	                        <a href="/WmHL7/mllp/ListResources.dsp?action=enableConnection&connectionAlias=%value -urlencode connectionAlias%&connectionState=enabled&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES&listAllConnection=listAllConnection"
			           ONCLICK="return confirmEnable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/blank.gif" border=0 alt="Enable">No
                                </a>
                            </td>
    
						%comment%-- start trax# 1-14BGHB --%endcomment%
		    			%comment% A new connection state called pendingEnabled is introduced which is set just before %endcomment%
		    			%comment% enabling the connection, i.e. this is a transitionary state between the disabled and enabled. %endcomment%
                        %case 'pendingEnabled'%
                            <script>writeTD('rowdata');</script>
                            Pending enabled
                            </td>
						%comment%-- end trax# 1-14BGHB --%endcomment%
    
                    %endswitch%
    
                    %ifvar connectionState equals('disabled')%
                        <script>writeTD('rowdata');</script>
                            <a href="/WmHL7/mllp/ConnNodeDetails.dsp?readOnly=false&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%">
                                <img src="/WmART/icons/config_edit.gif" alt="Edit" border=0>
                            </a>
                        </td>
                    %else%
                        <script>writeTD('rowdata');</script>
                            <img src="/WmART/icons/disabled_edit.gif" alt="Disable Connection to Edit" border=0>
                        </td>
                    %endif%
	    
                    <script>writeTD('rowdata');</script>
                        <a href="/WmHL7/mllp/ConnNodeDetails.dsp?readOnly=true&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%">
                            <img src="/WmRoot/icons/file.gif" alt="View" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');</script>
                        <a href="/WmHL7/mllp/CopyConnection.dsp?readOnly=false&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%">
                            <img src="/WmART/icons/copy.gif" alt="Copy" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');swapRows();</script>
                        %ifvar connectionState equals('disabled')%
                            <a href="/WmHL7/mllp/ListResources.dsp?action=deleteConnection&connectionAlias=%value -urlencode connectionAlias%&adapterTypeName=%value -urlencode ../adapterTypeName%&dspName=.LISTRESOURCES&listAllConnection=listAllConnection"
                               ONCLICK="return confirmDelete('%value connectionAlias%');">
                                <img src="/WmRoot/icons/delete.gif" alt="Delete" border=0>
                            </a>
                        %else%
                            <img src="/WmART/icons/delete_disabled.gif" alt="Disable Connection to Delete" border=0>
                        %endif%
                    </td>
                </tr>
            %endloop%
        %else%
            <tr><td class="message" colspan=8>No connections found</td></tr>
        %endif%

        %onerror%
            %ifvar localizedMessage%
                <tr><td class="message">Error encountered <pre>%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td class="message">Error encountered <pre>%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
        %endinvoke%

        </table>
    </body>
</HTML>
