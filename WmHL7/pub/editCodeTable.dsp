<html>
    <head>
		<meta http-equiv='content-type' content='text/html; charset=utf-8'>    
		
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        
        <title>HL7</title>
        
        <script src="/WmRoot/webMethods.js.txt"></script>
        <script src="/WmHL7/hl7.js.txt"></script>
        <script language="javascript">
            function validateForm() {
                if (document.addValue.value.value == "" ) {
                    alert("Please specify a Code Table Value.");
                    document.addValue.value.focus();
                    return false;
                }
                
				if(containsNonLatinCodepoints(document.addValue.value.value)) {
					alert("Only Latin characters are allowed in table value.");
					document.addValue.value.focus();
					return false;
				}
				
				if(containsNonLatinCodepoints(document.addValue.description.value)) {
					alert("Only Latin characters are allowed in table description.");
					document.addValue.description.focus();
					return false;
				}
                
            }
            
        	function confirmDelete(table, value) {
				var answer = confirm('Are you sure you want to delete the value '+ value + ' from table ' + table + '?'); 
				return answer;
        	}            
        </script>
    </head>
    <body onload="setNavigation('editCodeTable.dsp', '%value helpsys%', 'foo');">
        <div class="position">
            <table width="100%">
                <tr>
                    <td class="menusection-Solutions" colspan=2>HL7 Module &gt; Manage Code Tables &gt; %ifvar editable equals('true')%Edit %else%View %end%Table</td>
                </tr>
                
				%ifvar action%
					%switch action%
						<!--Delete value -->
						%case 'delete'%
							%invoke wm.ip.hl7.ui:deleteCodeTableValue%
							%ifvar result%
								%ifvar result equals('SUCCESS')%
									<script>writeMessage('Successfully deleted value(s) from Code Table: %value tableID% (%value tableName%)');</script>
								%else%
									<script>writeMessage('Failed to delete value(s) from Code Table: %value tableID% (%value tableName%)');</script>
								%endif%
							%endif%
							%onerror%
								%ifvar localizedMessage%
									<script>printMessage('%value localizedMessage%', 3);</script>
								%else%
									<script>printMessage('%value errorMessage%', 3);</script>
								%endif%
							%endinvoke%

						<!-- Add value -->
						%case 'add'%
							%invoke wm.ip.hl7.ui:insertCodeTableValue%
							%ifvar result%
								%ifvar result equals('SUCCESS')%
									<script>writeMessage('Successfully added a value to Code Table: %value tableID% (%value tableName%)');</script>
								%else%
									<script>writeMessage('Failed to add a value to Code Table: %value tableID% (%value tableName%)');</script>
								%endif%
							%endif%
							%onerror%
								%ifvar localizedMessage%
									<script>printMessage('%value localizedMessage%', 3);</script>
								%else%
									<script>printMessage('%value errorMessage%', 3);</script>
								%endif%
							%endinvoke%

					%endswitch%
				%endif%
            </table>
            
			<script>
				menuInit();
				menuAdd('Return to Code Tables',	'/WmHL7/codetables.dsp?partnerID=%value -urlencode partnerID%');
				%ifvar editable equals(true)%
				menuAdd('Delete All Values',		'/WmHL7/editCodeTable.dsp?action=delete&tableID=%value -urlencode tableID%&tableName=%value -urlencode tableName%&deleteAllValues=true&partnerID=%value -urlencode partnerID%&editable=%value editable%');
				%endif%
				menuShow();
			</script>
			
			<table width=100%>
				<tr>
					<td>
					</td>
				</tr>

				%ifvar editable equals(true)%
				<table width="100%">
					<form name="addValue" method="POST" action="editCodeTable.dsp">                
						<tr>
							<td class="heading" colspan=2>Add Value %ifvar partnerName -notempty% for partner %value partnerName%%endif%</td>
						</tr>
						<!-- Value -->
						<tr>
							<script>writeTDspan('row');</script>
								Value
							<script>w("</td>");</script>								
							<script>writeTDspan('rowdata-l'); swapRows();</script>
								<input size=20 name="value" value=""></input>
							<script>w("</td>");</script>
						</tr>

						<!-- Description -->
						<tr>
							<script>writeTDspan('row');</script>
								Description
							<script>w("</td>");</script>
							<script>writeTDspan('rowdata-l'); swapRows();</script>
								<input size=70 name="description" value=""></input>
							<script>w("</td>");</script>
						</tr>
						<tr>
							<td class="action" colspan="2" align="right">
								<input type="submit" value="Add Value" width=50 onclick="return validateForm()"></input>
							</td>
						</tr>
						<input type='hidden' name='tableID' value='%value tableID%'/>
						<input type='hidden' name='tableName' value='%value tableName%'/>
						<input type='hidden' name='partnerID' value='%value partnerID%'/>
						<input type='hidden' name='editable' value='%value editable%'/>
						<input type='hidden' name='action' value='add'/>
					</form>
				</table>
				%endif%
				
                <table width="100%">
                    <tr>
                        <td class="heading" colspan=3>Code Table: %value tableID% (%value tableName%) %ifvar partnerName -notempty% for partner %value partnerName%%endif%</td>
                    </tr>
					<input type='hidden' name='tableName' value='%value tableName%'/>
					%scope param(forUI='true')%
					%invoke wm.ip.hl7.managecodetables:getCodeTableValues%
						%ifvar codeTableValues -notempty%
							<tr>
								<td class="oddcol">Table Value</td>
								<td class="oddcol-l">Description</td>
								%ifvar editable equals(true)%
								<td class="oddcol">Delete</td>
								%endif%
							</tr>
							%loop codeTableValues%
								<tr>
									<td class="%value classPart%rowdata" width="30%">
										%value value%
									</td>

									<td class="%value classPart%rowdata-l" width="60%">
										%value description%
									</td>
									
									%ifvar ../editable equals(true)%
									<td class="%value classPart%rowdata" width="10%">
										<a onclick="return confirmDelete('%value -urlencode tableID%', '%value -urlencode value%')" href='/WmHL7/editCodeTable.dsp?action=delete&tableID=%value -urlencode tableID%&tableName=%value -urlencode tableName%&partnerID=%value -urlencode ../partnerID%&deleteAllValues=false&value=%value -urlencode value%&editable=%value ../editable%'>
											<img src="/WmRoot/icons/delete.gif" alt="Delete" border=0>								
										</a>
									</td>
									%endif%
								</tr>
							%endloop%
						%else%
							<script>printCMessage('No Code Table values found', 3);</script>						
						%endif%
					%onerror%
						%ifvar localizedMessage%
							<script>printMessage('%value localizedMessage%', 3);</script>
						%else%
							<script>printMessage('%value errorMessage%', 3);</script>
						%endif%
				    %endinvoke%
				    %end%
                </table>
            </table>
        </div>
    </body>
</html>