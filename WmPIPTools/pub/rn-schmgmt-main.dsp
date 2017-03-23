<FORM METHOD="POST" ACTION="rn-schmgmt.dsp" name="import">
<table border="0" width="90%">
    <tr>
    <TH class="heading" colspan="2">Import IS Schema</TH>
    </tr>
    <tr>
    <td class="rowlabel" width="25%">Dictionary XML File</td>
    <td class="rowdata" width="75%"><select size="1" name="fileName">
       %invoke wm.ip.file:listXMLFiles%
    	%loop files%
       	<option>%value files%</option>
       %end files%         
		%end invoke%
    </select></td>
    </tr>
    <tr>
    <td class="rowlabel" width="25%"></td>
    <td CLASS="rowdata" width="75%">
<input type="radio" value="true" name="overwriteSchema" id="overwriteSchema"  checked>Overwrite
<input type="radio" value="false" name="overwriteSchema">Merge

</td>
    </tr>
    <tr>
      <td colspan=2 class="action">    <INPUT TYPE="HIDDEN" NAME="formAction" VALUE="import">
	<INPUT TYPE="SUBMIT" value="Import Schema">
</td>
      </tr>
    <tr><td>&nbsp;</td></tr>
      <tr>
</table>
</FORM>


<FORM METHOD="POST" ACTION="rn-schmgmt.dsp" name="export">
<table border="0" width="90%">
    <TH class="heading" colspan="2">Export IS Schema</TH>
      </tr>
      <tr>
    <td class="rowlabel" width="25%">IS Schema</td>
    <td class="rowdata" width="75%"><select size="1" name="schemaNodeName">
       %invoke wm.ip.rn.ns:listB2BSchemas%
    	%loop b2bSchemaNames%
       	<option>%value b2bSchemaNames%</option>
       %end loop%
      	%end invoke%         
    </select></td>
      </tr>
      <tr>
      <td colspan=2 class="action">
    <INPUT TYPE="HIDDEN" NAME="formAction" VALUE="export">
   	<INPUT TYPE="SUBMIT" value="Export Schema"></td>
        </tr>
</table>
</FORM>


<FORM METHOD="POST" ACTION="rn-schmgmt.dsp" name="migrate">
<table border="0" width="90%">
    <tr><td>&nbsp;</td></tr>
    <TH class="heading" colspan="2">Migrate IS Schema</TH>
        <tr>
    <td class="rowlabel" width="25%">IS Folder</td>
    <td class="rowdata" width="75%"><select size="1" name="folderNodeName">
        %invoke wm.ip.rn.ns:listPIPFolders%
    	%loop nsFolderNames%
       	<option>%value nsFolderNames%</option>
       %end loop%
       %end invoke%      
    </select></td>
        </tr>
        <tr>
    <td class="rowlabel" width="25%">from IS Schema</td>
    <td class="rowdata" width="75%"><select size="1" name="fromSchemaNodeName">
        %invoke wm.ip.rn.ns:listB2BSchemas%
		<option></option>
    	%loop b2bSchemaNames%
       	<option>%value b2bSchemaNames%</option>
       %end b2bSchemaNames%  
       %end invoke%         
    </select></td>
        </tr>
  <tr>
    <td class="rowlabel" width="25%">to IS Schema</td>
    <td class="rowdata" width="75%"><select size="1" name="toSchemaNodeName">
       %invoke wm.ip.rn.ns:listB2BSchemas%
    	%loop b2bSchemaNames%
       	<option>%value b2bSchemaNames%</option>
       %end b2bSchemaNames%
       %end invoke%    
		<option>&lt;Static&gt;</option>     
    </select></td>
  </tr>
  <tr>
          <td colspan=2 class="action">

    <INPUT TYPE="HIDDEN" NAME="formAction" VALUE="migrate">
  <INPUT TYPE="SUBMIT" value="Migrate Schema"></td>
  </tr>
</table>
</FORM>