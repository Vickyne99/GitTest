<HTML>
<HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
</HEAD>


<BODY>
<TABLE width="100%">

<FORM METHOD="POST" id = "bicForm"
	ACTION="/invoke/wm.fin.bic/insertBICListContent">
<TABLE>
  <tr>
    <td class="menusection-adapters" colspan="2">
      SWIFT &gt;
      Import BIC List
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
		<TH CLASS="heading" COLSPAN="2">Import BIC List</TH>
	</TR>
        
        <TR>
	   <td class="evenrowdata-l" colspan="6">
	   	   <ul>
	   		Note:
	   			<li>
	   			Every time a BIC import process is initiated, the previous BIC list is deleted from the database and a new list is inserted.
	   		   </li>
	   		   <li>
	   			The BIC list being imported must be in standard SWIFT format. Please refer to the sample  "Integration Server Home\packages\WmFIN\config\bic\sample\BIC.txt" for reference.
	   		   </li>
	   </ul>
	   </td>
	</TR>		
	
	
	
	<TR id="fileName">
		<TD CLASS="rowlabel">FileName:</TD>
		<TD CLASS="rowdata">
		<INPUT TYPE="FILE" id="fileinput"  NAME="fileName" VALUE="">
		<INPUT TYPE="hidden" NAME="fileContent" VALUE="" >
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
					document.forms[0].action = "/invoke/wm.fin.bic/insertBICList";
				}
				
			</script>
		</TD>
	</TR>

        <TR>
	   <TD class="oddrow">
                  Example Paths
                  </td>
           <TD class="oddrow-l">
                  C:/folder/bic.dat<BR>
                  //server/folder/bic.dat<BR>
          	  folder/bic.dat (relative to install directory)
           </TD>
         </TR>

<TR id="button">
<TD class="action" COLSPAN="2"><INPUT TYPE="button" VALUE="Import BIC List" onclick = "submitMe()"> </TD>
</TR>
</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
</FORM>
</BODY></HTML>
                   
