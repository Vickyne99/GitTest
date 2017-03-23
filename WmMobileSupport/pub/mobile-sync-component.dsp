<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Integration Server -- Mobile Support</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function confirmDelete (mscAlias) {
    var msg = "Delete mobile sync component '"+mscAlias+"'?";
    if (confirm (msg)) {
        document.deleteform.mscAlias.value = mscAlias;
            document.deleteform.submit();
          return false;
    } else return false;
  }
</SCRIPT>
</HEAD>
 
<BODY onLoad="setNavigation('mobile-sync-component.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_MSCScrn');"> 
  <TABLE width="100%">
   <TR>
      <TD class="menusection-Settings" colspan="2">
          Mobile Support &gt;
          Mobile Sync Components 
      </TD>
    </TR>
    
%ifvar action%
%switch action%
%case 'add'%
  %invoke wm.mobile.datasync.msc:addMobileSyncComponent%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'edit'%
  %invoke wm.mobile.datasync.msc:updateMobileSyncComponent%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'delete'%
  %invoke wm.mobile.datasync.msc:removeMobileSyncComponent%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'clearStore'%
  %invoke wm.mobile.datasync.msc:disableMobileSyncComponent%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%  
%case 'suspendMsc'%
  %invoke wm.mobile.datasync.msc:suspendMobileSyncComponent%
        %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value message%</TD></TR>
        %endif%
  %endif%
%case 'enable'%  
  %ifvar mscState equals('enabled')%
        %invoke wm.mobile.datasync.msc:enableMobileSyncComponent%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan="2">%value message%</TD>
        </TR>
        %endinvoke%
      %else%
        %invoke wm.mobile.datasync.msc:disableMobileSyncComponent%
        <TR>
          <TD colspan="2">&nbsp;</td>
          </TR>
        <TR>
          <TD class="message" colspan="2">%value message%</TD>
        </TR>
        %endinvoke%
      %endif%
%endswitch%
%endif% 
 	
   <TR>
      <TD colspan="2">
        <UL>
          <LI><A HREF="mobile-sync-component-addedit.dsp?action=add" onClick="setNavigation('mobile-sync-component-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_AddMSCScrn');">Add Mobile Sync Component</A></LI>
        </UL>
      </TD>
    </TR>

 </TABLE>

 <TABLE width="75%" class="tableView">
       <TR>      
      <TD class="heading" colspan="7">Mobile Sync Components</TD>
    </TR>
    
	%invoke wm.mobile.datasync.msc:getAllMobileSyncComponents%		
   
    <TR>     
      <TD class="oddcol-l" nowrap width="30%">Alias</TD>
      <TD class="oddcol" nowrap width="15%">Conflict Resolution Rule</TD>
	  <TD class="oddcol" nowrap width="15%">Store Business Data</TD>
      <TD class="oddcol" nowrap width="15%">Enabled</TD>
	  <TD class="oddcol" nowrap width="15%">Action</TD>
      <TD class="oddcol" nowrap width="5%">Delete</TD>
    </TR>

    %loop mobileSyncComponents%
    <TR>
     
      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>%ifvar mscAlias%
      <A href="mobile-sync-component-addedit.dsp?action=edit&mscAlias=%value -urlencode mscAlias%" onClick="setNavigation('mobile-sync-component-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Solutions_MobileSupport_EditMSCScrn');">
       %value mscAlias% 
         </A>%else%&nbsp;%endif%
      </TD>
      
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>%value conflictRule% 
      </TD>
	  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>%ifvar storeBusinessData equals('true')%Yes%else%No%endif% 
      </TD>
      <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
	  <!-- Enable -->
	  %switch mscState%
		%case 'suspended'%
		<a href="mobile-sync-component.dsp?action=enable&mscAlias=%value mscAlias encode(url)%&mscState=enabled">No</a> (Suspended)
		%case 'enabled'%
		<a href="mobile-sync-component.dsp?action=enable&mscAlias=%value mscAlias encode(url)%"><img style="width: 13px; height: 13px;" alt="enabled" border="0" src="/WmRoot/images/green_check.gif">Yes</a>
		%case 'disabled'%
		<a href="mobile-sync-component.dsp?action=enable&mscAlias=%value mscAlias encode(url)%&mscState=enabled">No</a>
	  %endswitch%	  
      </TD>
	  <!-- Action -->
	  <SCRIPT>writeTDnowrap("rowdata");</SCRIPT>
	  %switch mscState%
		%case 'suspended'%
		<a href="mobile-sync-component.dsp?action=clearStore&mscAlias=%value mscAlias encode(url)%">Clear Store</a>
		%case 'enabled'%
		%ifvar storeBusinessData equals('true')%<a href="mobile-sync-component.dsp?action=suspendMsc&mscAlias=%value mscAlias encode(url)%">Suspend</a>%endif%
		%case%
		&nbsp;
	  %endswitch%			
      </TD>
	  
      <SCRIPT>writeTDspan("rowdata","1");</SCRIPT>
	  %switch mscState%
		%case 'suspended'%
		<A href="" onClick="return confirmDelete('%value mscAlias%');">
          <IMG src="/WmRoot/icons/delete.gif" border="none">
        </A>
		%case 'enabled'%
		<IMG src="/WmRoot/icons/delete_disabled.gif" border="none">
		%case 'disabled'%
		<A href="" onClick="return confirmDelete('%value mscAlias%');">
          <IMG src="/WmRoot/icons/delete.gif" border="none">
        </A>
	  %endswitch%
      </TD>     
      <SCRIPT>swapRows();</SCRIPT>
    </TR>
    %endloop%
	
  </TABLE>
  <form name="mobileSyncComponent" action="mobile-sync-component.dsp" method="POST">
  	<input type="hidden" name="app_id">
  	
  </form>  
  <FORM name="deleteform" action="mobile-sync-component.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="mscAlias">
  </FORM>
</BODY>
</HTML>
