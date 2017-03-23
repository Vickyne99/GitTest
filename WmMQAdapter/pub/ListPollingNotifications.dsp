%comment%----- Lists Polling Notifications -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <TITLE>Polling Notifications</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
	<link rel="stylesheet" TYPE="text/css" HREF="/WmART/webMethods.css"></link>
	
    
    <SCRIPT LANGUAGE="JavaScript">
      function doSelect(action,aliasName)
      {
      		var s1 = null;
      		if(action =='enableNotification')
      		{
		         s1 = "OK to enable the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='disableNotification')
      		{
		         s1 = "OK to disable the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='suspendNotification')
      		{
		         s1 = "OK to suspend operations for the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='resumeNotification')
      		{
		         s1 = "OK to resume operations for the `"+aliasName+"' Notification?\n\n";
      		} 
      		else if(action =='forceDisable')
      		{
		         s1 = "OK to force the `"+aliasName+"' Notification to disabled status?\n\n";
      		} 
      		else if(action =='forceSuspend')
      		{
		         s1 = "OK to force the `"+aliasName+"' Notification to suspended status?\n\n";
      		} 
      		if(s1 == null)
      		{
      			alert("Script Error!");
      			return false;
      		}
      		else
      		{
	      		if(confirm (s1))
	      		{
	      			return(action);
	      		}
	      		else
	      		{
	      			return false;
	      		}
      		}
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
<BODY onLoad="setNavigation('ListPollingNotifications.dsp', '%value helpsys%', 'foo');">
<table width="100%">  
    <tr>
       	<td class="menusection-Adapters" colspan=5>Adapters &gt; %value displayName% &gt; Polling Notifications</TD>
    </tr>
        
    %comment%
    -- If we arrive at this page because of an enable/disable request, or an edit save, the
    -- action field will be set, we perform the requested action before refreshing the page.
    %endcomment%
      
    %ifvar action%
        %switch action%
        %case 'enableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'disableNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'edit'%
            %invoke wm.art.admin:setNotificationSchedule%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
            %invoke wm.art.admin:setNotificationClusterSettings%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'forceDisable'%
            %invoke wm.art.admin:forceNotificationDisable%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'forceSuspend'%
            %invoke wm.art.admin:forceNotificationSuspend%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'suspendNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'resumeNotification'%
            %invoke wm.art.admin:setNotificationStatus%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'suspendAllEnabled'%
            %invoke wm.art.admin:suspendAllPollingNotifications%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %case 'enableAllSuspended'%
            %invoke wm.art.admin:resumeAllPollingNotifications%
            %onerror%
                <TR><TD class="message" colspan=5>
                <PRE>
                %ifvar localizedMessage% %value localizedMessage%
                %else% %value errorMessage%
                %endif%
                </PRE>
            %endinvoke%
        %endswitch%
    %endif%

    %comment% When we arrive here, we start generating the tabvular list of notifications %endcomment%  
    <TR>
        <td>
            <ul>
    		    <li>
                    <a href="/WmART/ListPollingNotifications.dsp?&adapterTypeName=%value -urlencode adapterTypeName%&action=suspendAllEnabled">
		    	        Suspend all enabled</a>
		    	</li>
                <li>
                    <a href="/WmART/ListPollingNotifications.dsp?&adapterTypeName=%value -urlencode adapterTypeName%&action=enableAllSuspended">
                        Enable all suspended</a>
                </li>
            </ul>    
	    </td>
    </TR>
    <TR>
    	<td>
	    </td>
    </TR>
    <TR>
        <td class="heading" colspan=5>%value displayName% Polling Notifications</td>
    </tr>
    <tr>
        <td class="oddcol-l">Notification Name</td>
        <td class="oddcol-l">Package Name</td>        
        <td class="oddcol">State</td>
        <td class="oddcol">Edit Schedule</td>
        <td class="oddcol">View Schedule</td>    
    </tr>

    %comment% Get list of notifications that match our type %endcomment%
    %invoke wm.art.admin:retrievePollingNotifications%
    %comment% if we have notifications, loop over response, constructing output table %end%
    %ifvar notificationDataList -notempty%
        %loop notificationDataList%
            <tr>
            <script>writeTD('rowdata-l');</script>
            %value notificationNodeName% </td>
            <script>writeTD('rowdata-l');</script>
            %value packageName% </td>
            <script>writeTD('rowdata-l');</script>
            %switch notificationEnabled%
	            %case 'yes'%
	              <SELECT ONCHANGE="window.location.href='/WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action='+ 
	              		doSelect(this.value,'%value notificationNodeName%');" >
	              	<OPTION SELECTED VALUE=none><img src="/WmRoot/images/green_check.gif" height=13 width=13 border=0>Enabled</OPTION>
	              	<OPTION VALUE=disableNotification>Disabled</OPTION>
	              	<OPTION VALUE=suspendNotification>Suspended</OPTION>
	              </SELECT>
	            %case 'no'%
	              <SELECT ONCHANGE="window.location.href='/WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action='+ 
	              		doSelect(this.value,'%value notificationNodeName%');" >
	              	<OPTION SELECTED VALUE=none>Disabled</OPTION>
	              	<OPTION VALUE=enableNotification>Enabled</OPTION>
	              </SELECT>
	            %case 'unsched'%
	              <SELECT DISABLED>
	              	<option>Disabled</option>
	              </select>
	            %case 'pending'%         
	              <SELECT ONCHANGE="window.location.href='/WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action='+ 
	              		doSelect(this.value,'%value notificationNodeName%');" >
	              	<OPTION SELECTED VALUE=none>Pending Disable</OPTION>
	              	<OPTION VALUE=forceDisable>Disabled</OPTION>
	              </SELECT>
	            %case 'pendingSuspend'%         
	              <SELECT ONCHANGE="window.location.href='/WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action='+ 
	              		doSelect(this.value,'%value notificationNodeName%');" >
	              	<OPTION SELECTED VALUE=none>Pending Suspend</OPTION>
	              	<OPTION VALUE=forceSuspend>Suspend</OPTION>
	              </SELECT>
	            %case 'suspended'%         
	              <SELECT ONCHANGE="window.location.href='/WmART/ListPollingNotifications.dsp?notificationEnabled=no&notificationNodeName=%value -urlencode notificationNodeName%&adapterTypeName=%value -urlencode ../adapterTypeName%&action='+ 
	              		doSelect(this.value,'%value notificationNodeName%');" >
	              	<OPTION SELECTED VALUE=none>Suspended</OPTION>
	              	<OPTION VALUE=resumeNotification>Enabled</OPTION>
	              	<OPTION VALUE=disableNotification>Disabled</OPTION>
	              </SELECT>
            %endswitch%</TD>

            <script>writeTD('rowdata');</script>
            %ifvar notificationEnabled equals('yes')%
                <img src="/WmART/icons/disabled_edit.gif" alt="Edit" border=0>
            %else%
                %ifvar notificationEnabled equals('pending')%
                    <img src="/WmART/icons/disabled_edit.gif" alt="Edit" border=0>
                %else%                             
                    <a href="/WmART/PollingNotificationDetails.dsp?readOnly=false&adapterTypeName=%value -urlencode ../adapterTypeName%&notificationNodeName=%value -urlencode notificationNodeName%&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">
                    <img src="/WmART/icons/config_edit.gif" alt="Edit" border=0>
                %endif%
            %endif%
     
            </a></td>

            <script>writeTD('rowdata');</script>
            %ifvar notificationEnabled equals('unsched')%
                <img src="/WmART/icons/view-disabled.gif" alt="View" border=0>
            %else%
                <a href="/WmART/PollingNotificationDetails.dsp?readOnly=true&adapterTypeName=%value -urlencode ../adapterTypeName%&notificationNodeName=%value -urlencode notificationNodeName%&dspName=.LISTPOLLINGNOTIFICATIONDETAILS">
                <img src="/WmRoot/icons/file.gif" alt="View" border=0>         
            %endif%   
            </a></td>
            </tr>
        %endloop%
    %else%
        <TR><TD class="message" colspan=5>No Polling Notifications found</TD></TR>
    %endif%
    %onerror% 
        <TR><TD class="message" colspan=5>
        <PRE>
        %ifvar localizedMessage%
            %value localizedMessage%
        %else%
            %value errorMessage%
        %endif%
        </PRE>
    %endinvoke%
</table>  
</body>
</HTML>
