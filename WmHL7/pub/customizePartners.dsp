<html>
    <head>
		<meta http-equiv='content-type' content='text/html; charset=utf-8'>
		
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        
        <title>HL7</title>
        
        <script src="/WmRoot/webMethods.js.txt"></script>
        <script src="/WmHL7/hl7.js.txt"></script>
        <script language="javascript">
		function confirmRestore(partnerName) {
			var answer = confirm('Are you sure you want to restore the code tables/values for partner ' + partnerName + ' to default? All existing customized data for this partner will be deleted.'); 
			return answer;
		}        
        </script>
    </head>
    
    <body onload="setNavigation('customizePartners.dsp', '%value helpsys%', 'foo');">
		<div class="position">
			<table width="100%">
				<tr>
					<td class="menusection-Solutions" colspan=2>HL7 Module &gt; Customize Code Tables</td>
				</tr>
			</table>
			
			%ifvar action%
				%switch action%
					<!-- Customize/Restore -->
					%case 'customize'%
						%invoke wm.ip.hl7.ui:customizeForPartner%
						%onerror%
							%ifvar localizedMessage%
								<script>printMessage('%value localizedMessage%', 7);</script>
							%else%
								<script>printMessage('%value errorMessage%', 7);</script>
							%endif%
						%endinvoke%

					%case 'restore'%
						%invoke wm.ip.hl7.ui:restoreForPartner%
						%onerror%
							%ifvar localizedMessage%
								<script>printMessage('%value localizedMessage%', 7);</script>
							%else%
								<script>printMessage('%value errorMessage%', 7);</script>
							%endif%
						%endinvoke%
				%endswitch%
			%endif%
			
            %invoke wm.ip.hl7.ui:checkCodeTableConfig%
			%invoke wm.ip.hl7.ui:getAllPartners%
			%ifvar blockCustomization%
			<script>printMessage('Code tables and values are not loaded. Customizing is not possible.');</script>
			%else%
			<table width=70%>
			
					<tr>
						<td class="heading" colspan=5>List of partners from Trading Networks</td>
					</tr>
					
					
					%ifvar partnerCount equals('0')%
						<tr><td>
						<script>printCMessage('No Partners configured in Trading Networks', 3);</script>
						</td></tr>
					%else%					
					
					<tr>
						<td class="oddcol">#</td>
						<td class="oddcol-l">Partner Name</td>
						<td class="oddcol">Customize</td>
						<td class="oddcol">Edit</td>
					</tr>

					
					%loop partners%
					<tr>
						<script>writeTDspan('rowdata');</script>
						%value serialNo%	
						<script>w("</td>");</script>
						<script>writeTDspan('rowdata-l');</script>
						%value partnerName%	
						<script>w("</td>");</script>
						<script>writeTDspan('rowdata');</script>
						%ifvar isCustomized equals(true)%
							<a onclick="return confirmRestore('%value partnerName%')" href='/WmHL7/customizePartners.dsp?action=restore&profileID=%value -urlencode profileID%&partnerName=%value -urlencode partnerName%'>
							<img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Disable" border=0>Yes
							</a>
						%else%
							<a href='/WmHL7/customizePartners.dsp?action=customize&profileID=%value -urlencode profileID%&partnerName=%value -urlencode partnerName%'>
							<img src="/WmRoot/images/blank.gif" border=0 alt="Enable">No
							</a>
						%endif%
						<script>writeTDspan('rowdata');</script>
						%ifvar isCustomized equals(true)%
						<a href='/WmHL7/codetables.dsp?partnerID=%value -urlencode partnerID%'>
							<img src="/WmART/icons/config_edit.gif" alt="Edit" border=0>
						</a>
						%else%
							<img src="/WmART/icons/disabled_edit.gif" alt="Edit" border=0>
						%endif%
						<script>w("</td>");</script>
						<script>w("</td>");swapRows();</script>						
					</tr>
					%endloop%
					%endif%
			</table>
			%endif%
			%onerror%
				<script>printMessage('%value errorMessage%', 7);</script>
			%endinvoke%
			%onerror%
				<script>printMessage('Error while retrieving the partners. Please verify the JDBC pool settings and/or ensure that the tables are created.', 7);</script>
			%endinvoke%				
		</div>
	</body>
</html>