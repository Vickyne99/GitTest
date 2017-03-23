%comment%----- Displays adapter type deployment data -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <title>About</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
</head>


%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%
<BODY onLoad="setNavigation('About.dsp', '%value encode(javascript) helpsys%', 'foo');">
    %invoke wm.art.admin:retrieveAdapterTypeData%
    %invoke wm.sap.Admin:about%
    <table width="100%">  
    <tr>
       <td class="menusection-Adapters" colspan=5>Adapters &gt; %value displayName% &gt; About</td>
    </tr>
    <tr>
        <td class="heading" colspan=5>About %value displayName%</td>
    </tr>        
    
    <tr>
        <td class="heading" colspan=5>Copyright</td>
    </tr>
    %ifvar THIRDPARTYCOPYRIGHTURL -isnull%
      %ifvar vendorName equals('Software AG')%
      <tr>
      <script>writeTD('row');</script>
      <img src="/WmRoot/images/wmlogo.gif" border=0></td>
      <script>writeTD('rowdata-l');swapRows();</script>
      <p>
      Copyright &copy; 1996-2009 Software AG, Darmstadt, Germany and/or Software AG USA, Inc., Reston, VA, United States of America, and/or their suppliers.
      <br>
      All rights reserved. 
      <br><br>
      The name Software AG, webMethods and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA, Inc. 
      <br>
      Other company and product names mentioned herein may be trademarks of their respective owners.
      </td>
      %else%
      <script>writeTD('row');</script>
      Copyright
      <script>writeTD('rowdata-l');swapRows();</script>
       %comment% 
        The adapter is not a webMethods adapter and 
        they didn't provide any copyright information.
       %end%
      </td>
      %endif%
    %else%
    <script>writeTD('row');</script>
    Copyright
    <script>writeTD('rowdata-l');swapRows();</script>
    %value THIRDPARTYCOPYRIGHTURL%
    %endif% 
    </td>
    <tr>
    <script>writeTD('row');</script>
    Description</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value description%</td>
    </tr>
    <tr>
    <script>writeTD('row');</script>
    Adapter Version</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value adapterVersion%
    &nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    <tr>
    <script>writeTD('row');</script>Updates</td>
    <script>writeTD('rowdata-l');swapRows();</script>
    %ifvar installedUpdates%
       %loop installedUpdates%
          %value%<br>
       %endloop%
    %else%
       None
    %endif%
    </td>
    </tr>
    <tr>
    <script>writeTD('row');</script>
    JCA Spec Version</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value jcaSpecVersion%</td>
    </tr>
    <tr>
    <script>writeTD('row');</script>
    Vendor Name</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value vendorName%</td>
    </tr>
	    <!-- %scope systemAttributes% -->
	    <tr><td colspan="2" class="evenrow">&nbsp;</td></tr>
	    <tr>
	      <td class="oddrow">OS Version</td>
	      <td class="oddrowdata-l">%value osVersion%</td>
	    </tr>
	    <tr>
	      <td class="evenrow">Current User</td>
	      <td class="evenrowdata-l">%value currentUser%</td>
	    </tr>
	    <tr>
	      <td class="oddrow">Working Directory</td>
	      <td class="oddrowdata-l">%value workingDirectory%</td>
	    </tr>
	    <tr><td colspan="2" class="evenrow">&nbsp;</td></tr>
	    <tr>
	      <td class="oddrow">JCo Version</td>
	      <td class="oddrowdata-l">%value jcoVersion%</td>
	    </tr>
	    <tr>
	      <td class="evenrow">JCo Middleware</td>
	      <td class="evenrowdata-l">%value jcoMiddleware%</td>
	    </tr>
	    <tr>
	      <td class="oddrow">JCo Middleware Version</td>
	      <td class="oddrowdata-l">%value jcoMiddlewareVersion%</td>
	    </tr>
	    <tr>
	      <td class="evenrow">JCo Native Library Version</td>
	      <td class="evenrowdata-l">%value jcoNativeLayerVersion%</td>
	    </tr>
	    <tr>
	      <td class="oddrow">JCo Native Library Location</td>
	      <td class="oddrowdata-l">%value jcoNativeLayerPath%</td>
	    </tr>
	    <tr>
	      <td class="evenrow">IDoc Library Version</td>
	      <td class="evenrowdata-l">%value idocVersion%</td>
	    </tr>
	    <!-- %endscope% -->
    %endinvoke%
   </table>    
</body>
</HTML>
