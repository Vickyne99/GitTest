<html>
    <head>
		<meta http-equiv='content-type' content='text/html; charset=utf-8'>
		
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        
        <title>HL7</title>
        
        <script src="/WmRoot/webMethods.js.txt"></script>
        <script src="/WmHL7/hl7.js.txt"></script>
        <script language="javascript">
            function validateForm() {
                if (document.addTable.tableID.value == "" ) {
                    alert("Please specify a Code Table ID.");
                    document.addTable.tableID.focus();
                    return false;
                }
                
                if (document.addTable.tableName.value == "" ) {
                    alert("Please specify a Code Table Name.");
                    document.addTable.tableName.focus();
                    return false;
                }
                
                if(containsNonLatinCodepoints(document.addTable.tableName.value)) {
                	alert("Only Latin characters are allowed in table name.");
                	document.addTable.tableName.focus();
                	return false;
                }
                
				var selectBox = document.getElementById('selPartners');
				var selectBoxLength = selectBox.length;
				if(selectBoxLength == 0) {
					alert("Select at least one partner.");
					return false;
				}

				var partnerNames = "";
				for(var i = 0; i < selectBoxLength; i++) {
					selectBox[i].selected = true;
					partnerNames += selectBox[i].text;
					if(i < selectBoxLength - 1) partnerNames += "##"
				}
				document.getElementById('partnerNames').value = partnerNames;
				                
                return true;
            }
        </script>
    </head>
    
    <body onload="setNavigation('addCodeTable.dsp', '%value helpsys%', 'foo');">
		<div class="position">
			<table width="100%">
				<tr>
					<td class="menusection-Solutions" colspan=2>HL7 Module &gt; Manage Code Tables &gt; Add Table</td>
				</tr>
			</table>
			
			
			%ifvar action equals('addTable')%
				<table width="100%">
				%invoke wm.ip.hl7.ui:insertCodeTable%
				%ifvar result%
					%ifvar result equals('SUCCESS')%
						<script>writeMessage('Code Table: %value tableID% (%value tableName%) added for %value successCount% out of %value totalCount% partners');</script>
					%endif%
				%endif%
				%onerror%
					%ifvar localizedMessage%
						<script>printMessage('%value localizedMessage%', 7);</script>
					%else%
						<script>printMessage('%value errorMessage%', 7);</script>
					%endif%
				%endinvoke%
				</table>
			%endif%
			

			<table width=70%>                
				<form name="addTable" method="POST">
					<tr>
						<td class="heading" colspan=2>Add Table %ifvar partnerName -notempty% for partner %value partnerName%%endif%</td>
					</tr>

					<!-- Table ID -->
					<tr>
						<script>writeTDWidth('row', '50%');</script>
							Table ID
						<script>w("</td>");</script>								
						<script>writeTDspan('rowdata-l'); swapRows();</script>
							<input size=20 name="tableID" value="%value value%"></input>
						<script>w("</td>");</script>
					</tr>

					<!-- Table Name -->
					<tr>
						<script>writeTDWidth('row', '50%');</script>
							Table Name
						<script>w("</td>");</script>
						<script>writeTDspan('rowdata-l'); swapRows();</script>
							<input size=70 name="tableName" value="%value value%"></input>
						<script>w("</td>");</script>
					</tr>

					<!-- Status -->
					<tr>
						<script>writeTDspan('row');</script>
							Enable
						<script>w("</td>");</script>
						<script>writeTDspan('rowdata-l'); swapRows();</script>
							<select name="isEnabled">
								<option value="false">false</option>
								<option value="true">true</option>
							</select>
						<script>w("</td>");</script>
					</tr>
					
					<tr>
					  <script>writeTDspan('rowdata-r');</script>
					    <b>Available partners</b><br>
					    <select id="availPartners" class="listbox" style="width:200px" multiple size="10">
				              %invoke wm.ip.hl7.ui:getCustomizedPartners%
				              %ifvar partners -notempty%
						      %loop partners%
						      <option value="%value partnerID%">%value partnerName%</option>
						      %endloop%
				              %endif%
				              <!-- We are ignoring the service error here -->
        				      %endinvoke%
        				    </select><br>
        				    <input type="button" style="width:200px" value="->" onclick="move('availPartners', 'selPartners')">
        				  <script>w("</td>");</script>
						  <script>writeTDspan('rowdata-l');</script>
						  Selected partners<br>
						    <select id="selPartners" name="selPartners" class="listbox" style="width:200px" multiple size="10">
        				    </select><br>
        				    <input type="button" style="width:200px" value="<-" onclick="move('selPartners', 'availPartners')">
        				  <script>w("</td>");swapRows();</script>
       				</tr>
					
					
					<tr>
						<td class="action" colspan="2" align="right">
							<input type="submit" value="Add Table" width=50 onclick="return validateForm()"></input>						
							<input type="hidden" name="action" value="addTable"></input>
							<input type="hidden" name="partnerNames" id="partnerNames" value=""></input>
						</td>
					</tr>
				</form>
			</table>
		</div>
	</body>
</html>