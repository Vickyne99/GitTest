<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%

</HEAD>


<BODY>
<TABLE width="100%">

<FORM METHOD="POST" id = "bicForm" enctype="multipart/form-data"
	ACTION="/invoke/wm.fin.bic/insertBDPListContent">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      SWIFT &gt;
      Import BankDirectoryPlus List
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
		<TH CLASS="heading" COLSPAN="2">Import BankDirectoryPlus List</TH>
	</TR>
        
        <TR>
	   <td class="evenrowdata-l" colspan="6">
	   <ul>
	   		Note:
	   			<li>
	   			Each time you import a Bank Directory Plus list, the previous BankDirectoryPlus list is deleted from the database and the imported list is inserted.
	   		   </li>
	   		   <li>
	   			The Bank Directory Plus list being imported must be in standard SWIFT format. Please refer to the sample  "Integration Server Home\packages\WmFIN\config\bic\sample\BANKDIRECTORYPLUS_V3_SAMPLE_TXT.TXT" for reference.
	   		   </li>
	   </ul>
	   </td>
	</TR>		
	
	
	<TR >
		<TD CLASS="rowlabel">File Name</TD>
		<TD CLASS="rowdata">
		<INPUT TYPE="FILE" id="fileinput" NAME="fileName1" VALUE="" id="fileName1">
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
					} else { 
						alert("Failed to load file");
					}
				}
				function readSingleFileIE(evt) {
					document.forms[0].action = "/invoke/wm.fin.bic/insertBDPList";
				}
				
			</script>
		</TD>
	</TR>

        <TR>
	   <TD class="oddrow">
                  Example Paths
                  </td>
           <TD class="oddrow-l">
	                     C:\bic\sample\BANKDIRECTORYPLUS_V3_SAMPLE_TXT.txt (for Windows)<BR>
	                     \bic\sample\BANKDIRECTORYPLUS_V3_SAMPLE_TXT.txt (for UNIX)<BR>
	             	  folder\BANKDIRECTORYPLUS_V3_SAMPLE_TXT.TXT (for Windows relative to install directory)<BR>
	             	  folder\BANKDIRECTORYPLUS_V3_SAMPLE_TXT.TXT (for UNIX relative to install directory)

           </TD>
         </TR>

<TR>
<TD class="action" COLSPAN="2"><INPUT TYPE="button" VALUE="Import" onclick = "submitMe()"></TD>
</TR>
</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>
                   
