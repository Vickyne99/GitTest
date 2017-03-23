<?xml version='1.0'?>
<html>
  <head>
    <title>WmSAP - Statistics</title>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <meta http-equiv="Pragma" content="no-cache"></meta>
    <meta http-equiv="Expires" content="-1"></meta>
  </head>
  <body onLoad="setNavigation('/WmSAP/statistics.dsp?adapterTypeName=WmSAP', '/WmSAP/doc/OnlineHelp/wwhelp/wwhimpl/js/html/wwhelp.htm?context=Help&topic=IS_MG_LCS', 'foo');">
    %invoke wm.sap.Statistics:getLockedConnInfos%
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">Adapters &gt; SAP Adapter &gt; Monitoring &gt; Locked Connections</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="/WmSAP/statistics.dsp?adapterTypeName=WmSAP">Return to Monitoring</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <table class="tableView" width="95%">
	    <thead>
	      <tr>
		<td class="heading" colspan="7">Locked Connections</td>
	      </tr>
	      <tr>
		<td class="oddcol">SAP User</td>
		<td class="oddcol">Client</td>
		<td class="oddcol">Language</td>
		<td class="oddcol">Host</td>
		<td class="oddcol">Conversation ID</td>
		<td class="oddcol">Session ID</td>
		<td class="oddcol">IS User</td>
	      </tr>
	    </thead>
	    <tbody id="tbodyNode">
	      <!-- %loop infos% -->
	      <tr>
		<td class="evenrowdata-l">%value user encode(html)%</td>
		<td class="evenrowdata">%value client encode(html)%</td>
		<td class="evenrowdata">%value language encode(html)%</td>
		<td class="evenrowdata">%value host encode(html)%</td>
		<td class="evenrowdata">%value convID encode(html)%</td>
		<td class="evenrowdata">%value sessionID encode(html)%</td>
		<td class="evenrowdata">%value lockedBy encode(html)%</td>
	      </tr>
	      <!-- %endloop% -->
	    </tbody>
  	  </table>
	  <script type="text/javascript">swapColor('tbodyNode', false);</script>
	</td>
      </tr>
    </table>
    %onerror% %include error.html%
    %endinvoke%
  </body>
</html>