%comment%----- Displays adapter type deployment data -----%endcomment%

<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <title>About</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
	<Link REL="stylesheet" TYPE="text/css" HREF="/WmART/webMethods.css"></LINK>
    <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
</head>


%invoke wm.art.admin:getAdapterTypeOnlineHelp%
%onerror%
%endinvoke%
<BODY onLoad="setNavigation('About.dsp', '%value encode(javascript) helpsys%', 'foo');">
    %invoke wm.art.admin:retrieveAdapterTypeData%
    <table width="100%">
    <tr>
       <td class="breadcrumb" colspan=5>Adapters &gt; %value displayName% &gt; About</td>
    </tr>
    <tr>
    <td colspan=2>
        <ul>
        <li><a href="ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTRESOURCES">Return to %value displayName% Connections
        </a></ul>
    </td>
    </tr>
        <tr>
            <td>
<table class="tableView">
    <tr>
        <td class="heading" colspan=5>About %value displayName%</td>
    </tr>        
    
    <tr class="subheading3">
        <td colspan=5>Copyright</td>
    </tr>
            <tr>
    <script>writeTD('row');</script>
    Copyright
    <script>writeTD('rowdata-l');swapRows();</script>
   <p>
Copyright &copy; 2001 - 2012 Software AG, Darmstadt, Germany and/or Software AG USA, Inc., Reston, VA, United States of America, and/or their licensors. All rights reserved.
</p>
<p>
The name Software AG, webMethods and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA, Inc. Other company and product names mentioned herein may be trademarks of their respective owners.
</p>
<p>
This software may include portions of third-party products. For third-party copyright notices and license terms, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products". This document is part of the product documentation, located at <a target="_blank" href="http://documentation.softwareag.com/legal">http://documentation.softwareag.com/legal</a> and/or in the root installation directory of the licensed product(s).
</p>
  
    </td>
	</tr>
    <tr>
    <script>writeTDnowrap('row');</script>
    Description</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value description%</td>
    </tr>
    <tr>
    <script>writeTDnowrap('row');</script>
    Adapter Version</td>
    <script>writeTD('rowdata-l');swapRows();</script>          
    %value adapterVersion%
    </td>
    </tr>
    <tr>
    <script>writeTDnowrap('row');</script>Updates</td>
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
    %endinvoke%
   </table>
   </table>
</body>
</HTML>
