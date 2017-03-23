<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server -- Mobile Server Management</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function confirmDelete (appName, appVersion) {
    var msg = "Delete mobile application '"+appName+"'?";
    if (confirm (msg)) {
        document.deleteform.appName.value = appName;
        document.deleteform.appVersion.value = appVersion;
        document.deleteform.submit();
        return false;
    } else return false;
  }
</SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('mobile-app.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_MobileAppScrn');"> 
  <TABLE width="100%">
   <TR>
      <TD class="menusection-Settings" colspan="2">
          Mobile Support &gt;
          Mobile Applications
      </TD>
    </TR>
    
%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.mobile.datasync.appimpl:addMobileApp%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.mobile.datasync.appimpl:updateMobileApp%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.mobile.datasync.appimpl:removeMobileApp%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%endswitch%
%endif% 

   <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="mobile-app-addedit.dsp?action=add" onclick="setNavigation('mobile-app-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_AddMobileAppScrn')">Add Mobile Application</A></LI>
        </UL>
      </TD>
    </TR>
   </TABLE>
   
   <TABLE width="75%" class="tableView">
       <TR>      
      <TD class="heading" colspan="4">Mobile Applications</TD>
    </TR>
       
    <TR>     
      <TD class="oddcol-l" nowrap width="30%">Application Name</TD>
      <TD class="oddcol" nowrap width="25%">Application Version</TD>
      <TD class="oddcol" nowrap width="25%">Mobile Sync Component Aliases</TD>
      <TD class="oddcol" nowrap width="5%">Delete</TD>
    </TR>

    %invoke wm.mobile.datasync.appimpl:getAllMobileApps%

    %loop mobileAppsList%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar appName%
      <A href="mobile-app-addedit.dsp?action=edit&appName=%value -urlencode appName%&appVersion=%value -urlencode appVersion%" onclick="setNavigation('mobile-app-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_EditMobileAppScrn')">
       %value appName% 
         </A>%else%&nbsp;%endif%
      </TD>
      
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>%value appVersion% 
      </TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
      %loop mscs%
        <A href="mobile-sync-component-addedit.dsp?action=edit&mscAlias=%value -urlencode mscAlias%">%value mscAlias%</A>&nbsp;
      %endloop%
      </TD>

      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
        <A href="" onClick="return confirmDelete('%value appName%', '%value appVersion%');">
          <IMG src="/WmRoot/icons/delete.gif" border="none">
        </A>
      </TD>     
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%

  </TABLE>
  <FORM name="deleteform" action="mobile-app.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="appName">
  <INPUT type="hidden" name="appVersion">
  </FORM>
</BODY>
</HTML>
