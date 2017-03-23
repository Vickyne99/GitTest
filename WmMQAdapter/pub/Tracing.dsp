%comment%----- WebSphere MQ-level tracing -----%endcomment%
<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>WebSphere MQ-level tracing</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
    </head>

    %invoke wm.art.admin:getAdapterTypeOnlineHelp%
    %onerror%
    %endinvoke%

    %invoke wm.art.admin:retrieveAdapterTypeData%
    %onerror%
    %endinvoke%

%comment%--------------------
%loop -struct%
  %value $key% = %value% <br>
%endloop%
-----------------%endment%

%ifvar mode%
%switch mode%

%case 'getoutput'%
  %ifvar tracestate equals('enabled')%
    %invoke wm.mqseries.admin:getTraceOutput%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
    %onerror%
    %include errorWnd.dsp%
    <BODY onLoad="javascript:errorWindow();history.back()">
    %endinvoke%
  %else%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
  %endif%

%case 'setlevel'%
  %invoke wm.mqseries.admin:setTraceLevel%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
  %onerror%
  %include errorWnd.dsp%
  <BODY onLoad="javascript:errorWindow();history.back()">
  %endinvoke%

%case 'enabled'%
%invoke wm.mqseries.admin:enableMQTrace%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
  %onerror%
  %include errorWnd.dsp%
  <BODY onLoad="javascript:errorWindow();history.back()">
  %endinvoke%

%case 'disabled'%
%invoke wm.mqseries.admin:disableMQTrace%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
  %onerror%
  %include errorWnd.dsp%
  <BODY onLoad="javascript:errorWindow();history.back()">
  %endinvoke%

<!-- service to clear the Trace file -->
%case 'clearfile'%
%invoke wm.mqseries.admin:clearTraceFile%
    <BODY onLoad="setNavigation('ListResources.dsp','%value helpsys%', 'foo');">
  %onerror%
  %include errorWnd.dsp%
  <BODY onLoad="javascript:errorWindow();history.back()">
  %endinvoke%

<!-- service to clear the Trace file -->
%case 'archivefile'%
%invoke wm.mqseries.admin:archiveTraceFile%
    <BODY onLoad="setNavigation('ListResources.dsp','/WmMQAdapter/doc/OnlineHelp/wwhelp.htm?context=Help&topic=MQ_TraceConsole', 'foo');">
  %onerror%
  %include errorWnd.dsp%
  <BODY onLoad="javascript:errorWindow();history.back()">
  %endinvoke%

%endswitch%
%else%
  %ifvar tracestate equals('enabled')%
    %invoke wm.mqseries.admin:getTraceOutput%
    <BODY onLoad="setNavigation('ListResources.dsp','/WmMQAdapter/doc/OnlineHelp/wwhelp.htm?context=Help&topic=MQ_TraceConsole', 'foo');">
    %onerror%
    %include errorWnd.dsp%
    <BODY onLoad="javascript:errorWindow();history.back()">
    %endinvoke%
  %else%
    <BODY onLoad="setNavigation('ListResources.dsp','/WmMQAdapter/doc/OnlineHelp/wwhelp.htm?context=Help&topic=MQ_TraceConsole', 'foo');">
  %endif%
%endif%

%invoke wm.mqseries.admin:getTraceSettings%
%endinvoke%

<!-- ****************************************** -->
<!--                Java Scripts                -->
<!-- ****************************************** -->
<SCRIPT language="JavaScript">


function enableTrace(frm)
{
 if (confirm(" Are you sure you want to enable WebSphere MQ-Level tracing with level=" + frm.tracelevel.value))
 {
  frm.mode.value="enabled";
  frm.submit();
 }
 else
  return;
}

function disableTrace(frm)
{
 if (confirm(" Are you sure you want to disable WebSphere MQ-Level tracing"))
 {
  frm.mode.value="disabled";
  frm.submit();
 }
 else
  return;
}

function clearTraceFile(frm)
{
 if (confirm(" Are you sure you want to clear your trace file? "))
 {
  frm.mode.value="clearfile";
  frm.submit();
 }
 else
  return;
}


function archiveTraceFile(frm)
{
 if (frm.archiveFileName.value == null || frm.archiveFileName.value == "")
 {
  alert("Please enter a name for the Archive file.");
  frm.archiveFileName.focus();
  return false;
 }
 else if (confirm("Archive trace file?"))
 {
  frm.mode.value="archivefile";
   frm.submit();
 }
 else
  return;
}


function setTraceLevel(frm)
{
 if (frm.tracestate.value == 'enabled')
 {
  frm.mode.value="setlevel";
  frm.submit();
 }
 else
  return;
}

</SCRIPT>

<table class="tableView" width="100%">
    <tr>
       <td class="breadcrumb" colspan=8>Adapters &gt; %value displayName% &gt; WebSphere MQ-level Tracing</td>
    </tr>
	</table>
	<br/>
	<table class="tableView" width="100%">
   %ifvar message -notempty%
	<TR>
	
    <tr id="message" colspan="100%">%value message%</tr>
    </TR>
    %endif%
%comment%----------------------------------------------
</table>

<table width=100% border=0 cellspacing=1 cellpadding=3>
-------------------------------------------%endcomment%
	<!-- *********************************************************************** -->
	<!--                       Form to set mode and tracing level                -->
	<!-- *********************************************************************** -->
	<FORM method="GET" name="trace" action="Tracing.dsp?adapterTypeName=wmMQAdapter&dspName=.TRACING&mode=%value mode%">
    <INPUT type = "hidden"   name = "activeIM"    value = "%value activeIM%">
    <INPUT TYPE = "hidden"   name = "mode"        value ="getoutput">
    <INPUT TYPE = "hidden"   name = "tracestate"  value ="%value tracestate%">

    <script>resetRows();</script>
    <tr>
            <td class="heading" colspan=8>Configure WebSphere MQ-level Tracing &gt; webMethods WebSphere MQ Adapter</td>
    </tr>   
%comment%----------------------------------------------
</table>

<table width="100%">
-------------------------------------------%endcomment%
    <tr>
   		<td colspan=4 padding-right=5px padding-left=0px BGCOLOR=#F0F0E0 align="right">WebSphere MQ Trace Status</td>
   		<td colspan=4 padding-right=0px padding-left=5px BGCOLOR=#F0F0E0 align="left">
%ifvar tracestate%
	            <INPUT TYPE="radio" NAME="action" VALUE="enabled" onclick="enableTrace(this.form)" %ifvar tracestate equals('enabled')%CHECKED%endif%> enabled<BR>
	            <INPUT TYPE="radio" NAME="action" VALUE="disabled" onclick="disableTrace(this.form)" %ifvar tracestate equals('disabled')%CHECKED%endif%> disabled
		</td>
		%else%
	            <INPUT TYPE="radio" NAME="action" VALUE="enabled" onclick="enableTrace(this.form)"> enabled <BR>
	            <INPUT TYPE="radio" NAME="action" VALUE="disabled" onclick="disableTrace(this.form)" CHECKED> disabled
		</td>
		%endif%
    </tr>
    <tr>
   		<td colspan=4 padding-right=5px padding-left=0px BGCOLOR=#E0E0C0 align="right">WebSphere MQ Trace Level</td>
   		<td colspan=4 padding-right=0px padding-left=5px BGCOLOR=#E0E0C0 align="left">
		 <SELECT NAME="tracelevel" onChange="setTraceLevel(this.form)">
	            <OPTION VALUE="00" %ifvar tracelevel equals('00')%SELECTED%endif%>  0 </OPTION>
        	    <OPTION VALUE="01" %ifvar tracelevel equals('01')%SELECTED%endif%>  1 </OPTION>
	            <OPTION VALUE="02" %ifvar tracelevel equals('02')%SELECTED%endif%>  2 </OPTION>
        	    <OPTION VALUE="03" %ifvar tracelevel equals('03')%SELECTED%endif%>  3 </OPTION>
	            <OPTION VALUE="04" %ifvar tracelevel equals('04')%SELECTED%endif%>  4 </OPTION>
        	    <OPTION VALUE="05" %ifvar tracelevel equals('05')%SELECTED%endif%>  5 </OPTION>
		 </SELECT>
		</td>
   		
    </tr>


    <tr>
   		<td colspan=2 padding-right=5px padding-left=0px BGCOLOR=#F0F0E0 align="right">Trace File Name</td>
   		<td colspan=4 padding-right=5px padding-left=5px BGCOLOR=#F0F0E0 align="center">
         <INPUT name="archiveFileName" value="" size=35></INPUT>
         </td>
   		<td colspan=2 padding-right=0px padding-left=5px BGCOLOR=#F0F0E0 align="center">
         <INPUT type="button" onclick="archiveTraceFile(this.form)" value="Archive Trace File"><BR>
		 <BR>
         <INPUT type="button" onclick="clearTraceFile(this.form)"   value=" Clear Trace File  ">
        </td>
    </tr>
</table>

<br>

  <table width=100% border=0 cellspacing=0 cellpadding=0>
    <tr class="heading">
	  <td class="breadcrumb" colspan="100%" align="left"><code>Contents of Trace file</code></Td>
	</tr>

    <tr>
     <td class="coltext" colspan="100%">
        <PRE>%value traceoutput%</PRE>
     </td>
    </tr>

  <table width=100% border=0 cellspacing=1 cellpadding=3>
    <tr>
        <td class="action" width="100%" align="center">
          <INPUT type="submit" value="Refresh">
        </td>
    </tr>
  </table>

    </FORM>

</table>

<!-- *********************** PIPELINE DEBUGGING INFORMATION  *****************************

<P><h2>Pipeline contents</h2>
<P>
<table border=1>
%loop -struct%

    <tr>
       <td><b>%value $key%</b></td>
       <td>%value%</td>
    </tr>

%endloop%
</table>
-->

</body>
</html>

