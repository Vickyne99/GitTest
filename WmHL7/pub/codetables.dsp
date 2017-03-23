<html>
    <head>
    	<meta http-equiv='content-type' content='text/html; charset=utf-8'>
        <title>HL7</title>
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        <script src="/WmRoot/webMethods.js.txt"></script>
        <script src="/WmHL7/hl7.js.txt"></script>
        <script>
        	function confirmDelete(tableID) {
        		var msg = "Are you sure you want to delete the code table " + tableID + "?";
				var answer = confirm(msg); 
				return answer;
        	}
        	
        	function confirmRestore(tableID) {
        		var msg = "Are you sure you want to restore the values for the code table " + tableID + " to default? All the customized values for this table will be deleted."
				var answer = confirm(msg); 
				return answer;
        	}
        </script>
    </head>
    <body onload="setNavigation('codetables.dsp', '%value helpsys%', 'foo');">

        <div class="position">
            <table width="100%">
                <tr>
                    <td class="menusection-Solutions" colspan=7>HL7 Module &gt; Manage Code Tables</td>
                </tr>
                
                %invoke wm.ip.hl7.ui:checkCodeTableConfig%
				<script>
					menuInit();
					menuAdd('Add Code Table', '/WmHL7/addCodeTable.dsp');
					menuAdd('Upload Code Table Values',	'/WmHL7/loadCodeTableValues.dsp');
					menuShow();
				</script>
				%onerror%
					<script>printMessage('Error while retrieving the code tables. Please verify the JDBC pool settings and/or ensure that the tables are created.', 7);</script>
				%endinvoke%

                
                %invoke wm.ip.hl7.ui:getCustomizedPartners%
                
                %ifvar customized equals(true) %
                <table width=100%>
                <tr>
                	<td class="heading">Select Partner: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<select id="partnerSelectBox" style="width:200px" onchange="changePartner(this);">
						%loop partners%
						<option value="%value partnerID%" %ifvar partnerID vequals(../partnerID)%selected%endif%>%value partnerName%</option>
						%endloop%
					</select>
					</td>
				</tr>
				</table>
			
				%endif%
				%endinvoke%
				
				%ifvar action%
					<table width="100%"><tr><td>
					%switch action%
						<!-- EnableAll/ DisableAll -->
						%case 'statusUpdate'%
							%invoke wm.ip.hl7.managecodetables:enableCodeTables%
							%onerror%
								%ifvar localizedMessage%
									<script>printMessage('%value localizedMessage%', 7);</script>
								%else%
									<script>printMessage('%value errorMessage%', 7);</script>
								%endif%
							%endinvoke%

						<!-- Delete code table -->
						%case 'delete'%
							%invoke wm.ip.hl7.managecodetables:deleteCodeTables%
							%ifvar results[0]%
								%ifvar results[0] equals('SUCCESS')%
									<script>writeMessage('Code Table: %value tableIDs% (%value tableName%) deleted successfully');</script>
								%else%
									<script>writeMessage('Failed to delete Code Table: %value tableIDs% (%value tableName%)');</script>
								%endif%
							%endif%
							%onerror%
								%ifvar localizedMessage%
									<script>printMessage('%value localizedMessage%', 7);</script>
								%else%
									<script>printMessage('%value errorMessage%', 7);</script>
								%endif%
							%endinvoke%
							
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
					</td></tr></table>
				%endif%
			</table>
			
			%scope param(forUI='true') param(isEnabled=null)%
			%invoke wm.ip.hl7.managecodetables:getCodeTables%
			
			<script>
				menuInit();
				menuAdd('Enable All Tables for Partner %value partnerName%',	'/WmHL7/codetables.dsp?action=statusUpdate&status=true&partnerID=%value partnerID%');
				menuAdd('Disable All Tables for Partner %value partnerName%',	'/WmHL7/codetables.dsp?action=statusUpdate&status=false&partnerID=%value partnerID%');
				menuShow();
			</script>
			
			<table width=100%>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td class="heading" colspan=7>Code Tables for Partner %value partnerName%
					</td>
				</tr>
				
				%ifvar codeTables -notempty%
					<tr>
						<td class="oddcol">Table ID</td>
						<td class="oddcol-l">Table Name</td>
						<td class="oddcol">Enable</td>
						%ifvar displayingDefault equals('false')%
							<td class="oddcol">Customize</td>
						%endif%
						<td class="oddcol">View</td>
						<td class="oddcol">Edit</td>						
						<td class="oddcol">Delete</td>
					</tr>

					%loop codeTables%
					<tr>
						<!-- Table ID -->
						<td class="%value classPart%rowdata">
							%value tableID%
						</td>

						<!-- Table Name -->
						<td class="%value classPart%rowdata-l">
							%value tableName%
						</td>

						<!-- Enable/Disable -->
						<td class="%value classPart%rowdata">
							%ifvar isEnabled equals(true)%
								<a href='/WmHL7/codetables.dsp?action=statusUpdate&status=false&tableIDs=%value -urlencode tableID%&partnerID=%value ../partnerID%'>
									<img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Disable" border=0>Yes
								</a>
							%else%
								<a href='/WmHL7/codetables.dsp?action=statusUpdate&status=true&tableIDs=%value -urlencode tableID%&partnerID=%value ../partnerID%'>
									<img src="/WmRoot/images/blank.gif" border=0 alt="Enable">No
								</a>
							%endif%
						</td>

						<!-- Customize/Restore -->
						%ifvar ../displayingDefault equals('false')%
							<td class="%value classPart%rowdata">
								%ifvar isInherited equals(false)%
									<a onclick="return confirmRestore('%value tableID%')" href='/WmHL7/codetables.dsp?action=restore&partnerID=%value ../partnerID%&tableID=%value -urlencode tableID%'>
										<img src="/WmRoot/images/green_check.gif" height=13 width=13 alt="Restore" border=0>Yes
									</a>
								%else%
									<a href='/WmHL7/codetables.dsp?action=customize&partnerID=%value ../partnerID%&tableID=%value -urlencode tableID%'>
										<img src="/WmRoot/images/blank.gif" border=0 alt="Customize">No
									</a>
								%endif%
							</td>
						%endif%

						<!-- View -->                       
						<td class="%value classPart%rowdata">
							<a href='/WmHL7/editCodeTable.dsp?tableID=%value -urlencode tableID%&editable=false&partnerID=%value -urlencode ../partnerID%&partnerName=%value -urlencode ../partnerName%&tableName=%value -urlencode tableName%'>
								<img src="/WmRoot/icons/file.gif" alt="View" border=0>
							</a>
						</td>	


						<!-- Edit -->                       
						<td class="%value classPart%rowdata">
							%ifvar isInherited equals(false)%
							<a href='/WmHL7/editCodeTable.dsp?tableID=%value -urlencode tableID%&editable=true&partnerID=%value -urlencode ../partnerID%&partnerName=%value -urlencode ../partnerName%&tableName=%value -urlencode tableName%'>
								<img src="/WmART/icons/config_edit.gif" alt="Edit" border=0>
							</a>
							%else%
								<img src="/WmART/icons/disabled_edit.gif" alt="Edit" border=0>
							%endif%
						</td>	

						<!-- Delete -->
						<td class="%value classPart%rowdata">
							<a onclick="return confirmDelete('%value tableID%')" href='/WmHL7/codetables.dsp?action=delete&partnerID=%value ../partnerID%&tableIDs=%value -urlencode tableID%&tableName=%value -urlencode tableName%'>
								<img src="/WmRoot/icons/delete.gif" alt="Delete" border=0>								
							</a>
						</td>
					</tr>
					%endloop%
				%else%
					<script>printCMessage('No Code Tables found', 7);</script>					
				%endif%
	        </table>
			%endinvoke%
			%end%
            <form id="changeForm">
            <input type="hidden" id="partnerID" name="partnerID" value="%value partnerID%">
            </form>
        </div>
    </body>
</html>