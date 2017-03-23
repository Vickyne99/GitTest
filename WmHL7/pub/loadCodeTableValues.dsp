<html>
    <head>
		<meta http-equiv='content-type' content='text/html; charset=utf-8'>

        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">

        <title>HL7</title>

        <script src="/WmRoot/webMethods.js.txt"></script>
        <script src="/WmHL7/hl7.js.txt"></script>
        <script language="javascript">
            function validateForm() {
                if (document.loadCodeTableValues.inputFile.value == "---" ) {
                    alert("Please select the input file from the list. If no files are listed, copy the input file to the packages\\WmHL7\\data\\codetables\\upload directory.");
                    document.loadCodeTableValues.inputFile.focus();
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

    <body onload="setNavigation('loadCodeTableValues.dsp', '%value helpsys%', 'foo');">
		<div class="position">

			<table width="100%">
				<tr>
					<td class="menusection-Solutions" colspan=2>HL7 Module &gt; Manage Code Tables &gt; Upload Code Table Values</td>
				</tr>
			</table>
			
			<table width=70%>
				<form name="loadCodeTableValues" action="loadCodeTableValues.dsp" method="POST" enctype="application/x-www-form-urlencoded">
					<tr>
						<td class="heading" colspan=2>Upload Values for Selected Partners</td>
					</tr>

					<!-- Table ID -->
					<tr>
						<script>writeTDWidth('row', '50%');</script>
							Input file name
						<script>w("</td>");</script>
						<script>writeTDWidth('rowdata-l', '50%'); swapRows();</script>
							<select style="width:100px" name="inputFile">
							<option value="---">---</option>
						%invoke wm.ip.hl7.ui:getUploadFileList%
						%loop fileNames%
						<option value="%value%">%value%</option>
						%endloop%
						%endinvoke%
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
							<input type="submit" value="Load" width=50 onclick="return validateForm()"></input>
							<input type="hidden" name="action" value="load"></input>
							<input type="hidden" name="partnerNames" id="partnerNames" value=""></input>
						</td>
					</tr>
				</form>
			</table>
			<table width="100%">
				%ifvar action%
					%switch action%
						<!-- Load Code Table Values -->
						%case 'load'%
							%invoke wm.ip.hl7.managecodetables:loadCodeTableValues%
								<tr>
									<td class="heading" colspan="2">Results</td>
								</tr>

								<tr>
									<td class="oddcol-l" width="20%">Number of code table values</td>
									<td class="oddcol-l" width="80%">%value numValues%</td>
								</tr>

								<tr>
									<td class="evencol-l" width="20%">Status of the operation</td>
									<td class="evencol-l" width="80%">
										%ifvar warningsFound equals(true)%
										Loaded successfully with warnings. Check the integration server logs.
										%else%
										Loaded successfully.
										%endif%
									</td>
								</tr>

								<!-- Exception -->
								%onerror%
									%ifvar localizedMessage%
										<script>printMessage('%value localizedMessage%', 7);</script>
									%else%
										<script>printMessage('%value errorMessage%', 7);</script>
									%endif%

							%endinvoke%
					%endswitch%
				%endif%
			</table>

		</div>
	</body>
</html>