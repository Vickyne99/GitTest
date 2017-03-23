<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%

</HEAD>


<BODY>
<TABLE width="100%">

<FORM METHOD="POST" id = "bicForm"
	ACTION="/invoke/wm.fin.bic/insertSRListContent">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      SWIFT &gt;
      Import SEPAPlus List
    </td>
  </tr>
  <TR></TR>
  <TR></TR>
    <TR></TR>
<TR>
<TD WIDTH="30">&nbsp;</TD>
<TD> 
<HR>
<TABLE>
	<TR>
		<TH CLASS="heading" COLSPAN="2">Import SEPAPlus List</TH>
	</TR>
        
    <TR>
	   <td class="evenrowdata-l" colspan="6">
	   <ul>
		Note:
			<li>
			Each time you import an SEPAPlus list, the previous SEPAPlus list is deleted from the database and the imported list is inserted.
		   </li>
		   <li>
			The SEPAPlus list being imported must be in standard SWIFT format. Please refer to the sample "Integration Server Home"\packages\WmFIN\config\bic\sample\SEPAROUTING_V3_SAMPLE_TXT.txt for reference.
		   </li>
	   </ul>
	   </td>
	</TR>		
		
	
	<TR id="fileName">
		<TD CLASS="rowlabel">File Name</TD>
		<TD CLASS="rowdata">
			<INPUT TYPE="FILE" id="fileinput" NAME="fileName1" VALUE="">
			<INPUT TYPE="hidden" NAME="fileContent" VALUE="" >
			<INPUT TYPE="hidden" NAME="fileName" VALUE="" >
			<script type="text/javascript">
				var contents;
				
				var element = document.getElementById('fileinput');
				if (document.addEventListener){
					element.addEventListener('change', readSingleFile, false); 
				} else {
					element.attachEvent('onchange', readSingleFileIE);
				}
				function submitMe(){
					document.getElementById("bicForm").fileContent.value = contents;
					document.getElementById("bicForm").fileName.value = document.getElementById("bicForm").fileName1.value;
					document.getElementById("bicForm").submit();
				}
				function readSingleFile(evt) {
					//Retrieve the first (and only!) File from the FileList object
					var f = evt.target.files[0]; 
					if (f) {
						var r = new FileReader();
						r.onload = function(e) { 
						  contents = e.target.result;
						}
						r.readAsText(f);
					} else { 
						alert("Failed to load file");
					}
					
				}
				function readSingleFileIE(evt) {
					document.forms[0].action = "/invoke/wm.fin.bic/insertSRList";
				}
				
			</script>
		</TD>
	</TR>

    <TR>
	   <TD class="oddrow">
                  Example Paths
       </td>
       <TD class="oddrow-l">
           			
                  C:\bic\sample\SEPAROUTING_V3_SAMPLE_TXT.txt (for Windows)<BR>
                  \bic\sample\SEPAROUTING_V3_SAMPLE_TXT.txt (for UNIX)<BR>
          	  folder\SEPAROUTING_V3_SAMPLE_TXT.txt (for Windows relative to install directory)<BR>
          	  folder\SEPAROUTING_V3_SAMPLE_TXT.txt (for UNIX relative to install directory)
       </TD>
    </TR>

<TR id="button">
<TD class="action" COLSPAN="2"><INPUT TYPE="button" VALUE="Import" onclick = "submitMe()"></TD>
</TR>
</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>
                   
