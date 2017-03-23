<?xml version='1.0'?>
<html>
  <head>
    <title>WmSAP - Logging</title>
    <meta http-equiv="Pragma" content="no-cache"></meta>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1"></meta>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <body onLoad="setNavigation('/WmSAP/monitoring.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_LG_DETAIL', 'foo');">
    %invoke wm.sap.Monitor:display%
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">Adapters &gt; SAP Adapter &gt;
	  Logging &gt; %ifvar type equals('RFC')%RFC Trace Files%else%Details of IS Log File%endif% &gt; Entry</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a onmouseover="window.status='Back'; return true"
		   onmouseout="window.status='';return true"
		   href="/WmSAP/monitoring.dsp?adapterTypeName=WmSAP">Return to Logging</a></li>
	    </li>
	    <!-- %ifvar type equals('RFC')% -->
	    <li>
	      <a onmouseover="window.status='Back'; return true"
		   onmouseout="window.status='';return true"
		   href="/WmSAP/monitoringRfcTrace.dsp?name=%value name%">Return
		to RFC Trace File "%value name%"</a>
	    </li>
	    <!-- %endif% -->
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView">
	    <tr>
	      <td class="heading">
		%ifvar type equals('RFC')%
		Trace File Entry of
		%else%
		IS Log
		%endif% %value name%:
	      </td>
	    </tr>
	    <!-- %ifvar message equals('Ok')% -->
	    <tr>
	      <td>
		<pre class="fixedwidth">%value traceData%</pre>
	      </td>
	    </tr>
	    <!-- %else% -->
	    <tr>
	      <td class="message">%value message%</td>
	    </tr>
	    <!-- %endif% -->
	  </table>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>