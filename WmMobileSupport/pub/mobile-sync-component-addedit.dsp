<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <SCRIPT SRC="webMethods.js.txt">
    </SCRIPT>
  </HEAD>

  <BODY>
    <TABLE width="100%">
      <TR>
        <TD class="menusection-Settings" colspan="2">
            Mobile Support &gt;
            Mobile Sync Components &gt;
            %ifvar action equals('edit')% Edit %else% Add %endif% Mobile Sync Component
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="mobile-sync-component.dsp">Return to Mobile Sync Components</A></LI>
          </UL>
        </TD>
      </TR>

      <TR>
        <TD></TD>
          <TD>
            <TABLE class="tableForm">
              <TR>
                <TD colspan="2" class="heading">Mobile Sync Component</TD>
              </TR>
                %ifvar action equals('edit')%
                  %invoke wm.mobile.datasync.msc:getMobileSyncComponent%
                %endif%

                %endif%
                  <FORM NAME="addform" ACTION="mobile-sync-component.dsp" METHOD="POST">
                    <SCRIPT LANGUAGE="JavaScript">

                    //JS .trim() is not supported in IE 6-8, so here is the hack for this.
                    if (typeof String.prototype.trim !== 'function') {
                      String.prototype.trim = function() {
                        return this.replace(/^\s+|\s+$/g, '');
                      }
                    }

                    function confirmAdd() {
                      var theForm = document.addform;
                      if(validateAllInputs(theForm))
                        theForm.submit();
                      else
                        return false;
                    }

                    function checkLegalName(field) {
                      var name = field.value.trim();
                      var illegalChars = "- #&@^!%*$/\\`;~+=)(|}{][><\"?";

                      for (var i=0; i<illegalChars.length; i++)
                      {
                        if (name.indexOf(illegalChars.charAt(i)) >= 0)
                        {
                          return illegalChars.charAt(i);
                        }
                      }
                      return "";
                    }

                    function validateAllInputs(theForm) {
                        var mscAlias = document.getElementById('mscAlias');
                        if(mscAlias.value.trim() == "") {
                            alert("Mobile sync component alias cannot be blank");
                            mscAlias.focus();
                            return false;
                        } else if(!isNaN(parseInt(mscAlias.value))) {
                            alert('Mobile sync component alias, the provided value should not start with a numeric character.');
                            mscAlias.focus();
                            return false;
                        } else if((c = checkLegalName(mscAlias)) != "") {
                            alert("Mobile sync component alias contains illegal character: '" + c + "'");
                            mscAlias.focus();
                            return false;
                        }

                        var downloadService = document.getElementById('downloadService');
                        if(downloadService.value.trim() == "") {
                            alert("Download Service cannot be blank");
                            downloadService.focus();
                            return false;
                        } else if(!isNaN(parseInt(downloadService.value))) {
                            alert('Download Service, the provided value should not start with a numeric character.');
                            downloadService.focus();
                            return false;
                        } else if((c = checkLegalName(downloadService)) != "") {
                            alert("Download Service contains illegal character: '" + c + "'");
                            downloadService.focus();
                            return false;
                        }

                        var uploadService = document.getElementById('uploadService');
                        if(uploadService.value.trim() == "") {
                            alert("Upload Service cannot be blank");
                            uploadService.focus();
                            return false;
                        } else if(!isNaN(parseInt(uploadService.value))) {
                            alert('Upload Service, the provided value should not start with a numeric character.');
                            uploadService.focus();
                            return false;
                        } else if((c = checkLegalName(uploadService)) != "") {
                            alert("Upload Service contains illegal character: '" + c + "'");
                            uploadService.focus();
                            return false;
                        }

                        var docType = document.getElementById('docType');
                        if(docType.value.trim() == "") {
                            alert("Business Doc Type cannot be blank");
                            docType.focus();
                            return false;
                        } else if(!isNaN(parseInt(docType.value))) {
                            alert('Business Doc Type, the provided value should not start with a numeric character.');
                            docType.focus();
                            return false;
                        } else if((c = checkLegalName(docType)) != "") {
                            alert("Business Doc Type contains illegal character: '" + c + "'");
                            docType.focus();
                            return false;
                        }

                        var rowIdentifiers = document.getElementById('rowIdentifiers');
                        if(rowIdentifiers.value.trim() == "") {
                            alert("Row Identifiers cannot be blank");
                            rowIdentifiers.focus();
                            return false;
                        }

                        var conflictRule = theForm.conflictRule;
                        if(conflictRule.selectedIndex == 0){
                            alert("Select a conflict resolution rule.");
                            conflictRule.focus();
                            return false;
                        }
                        return true;
                    }

                    function confirmEdit() {
                        var theForm = document.addform;
                        if(validateAllInputs(theForm))
                            theForm.submit();
                        else
                            return false;
                    }

                    </SCRIPT>

                    <TR>
                      <TD class="oddrow">Alias</TD>
                      <TD class="oddrow-l">
                        <INPUT NAME="mscAlias" id="mscAlias" maxLength="60" size="40" VALUE="%value mscAlias%" %ifvar action equals('edit')% DISABLED %endif%> </TD>
                    </TR>
                    <TR>
                      <TD class="evenrow">Download Service</TD>
                      <TD class="evenrow-l">
                        <INPUT NAME="downloadService" id="downloadService" size="40" VALUE="%value downloadService%"> </TD>
                    </TR>
                    <TR>
                      <TD class="oddrow">Upload Service</TD>
                      <TD class="oddrow-l">
                        <INPUT NAME="uploadService" id="uploadService" size="40" VALUE="%value uploadService%"> </TD>
                      </TR>
                    <TR>
                      <TD class="evenrow">Business Doc Type</TD>
                      <TD class="evenrow-l">
                        <INPUT NAME="docType" id="docType" size="40" VALUE="%value docType%"> </TD>
                    </TR>
                    <TR>
                      <TD class="oddrow">Row Identifiers</TD>
                      <TD class="oddrow-l">
                        <INPUT NAME="rowIdentifiers" id="rowIdentifiers" size="40" VALUE="%value rowIdentifiers%"> &nbsp;(Multiple row identifiers must be separated by commas) </TD>
                    </TR>
                    <TR>
                      <TD class="evenrow">Filter</TD>
                      <TD class="evenrow-l">
                        <INPUT NAME="filter" id="filter" size="40" VALUE="%value filter%"> &nbsp;(Multiple filter keys must be separated by commas) </TD>
                    </TR>
                    <TR>
                      <TD class="oddrow">Conflict Resolution Rule</TD>
                      <TD class="oddrow-l">
                        <SELECT NAME="conflictRule" id="conflictRule" VALUE="%value conflictRule%">
                        <OPTION VALUE=""></OPTION>
                        %invoke wm.mobile.datasync.msc:getConflictResolutionTypes%
                            %loop ConflictResolutionTypes%
                                <OPTION VALUE="%value crRule[0]%" %ifvar crRule[0] vequals(../conflictRule)% SELECTED %endif%>%value crRule[1]%</OPTION>
                            %endloop%
                        </SELECT>
                      </TD>
                    </TR>
                    <TR>
                      <TD class="evenrow">Store Business Data</TD>
                      <TD class="evenrow-l"><input type="checkbox" name="storeBusinessData" id="storeBusinessData" %ifvar storeBusinessData equals('true')% CHECKED %endif% /></TD>
                    </TR>

                    <TR>
                      <TD colspan=2 class="action">
                        %ifvar action equals('edit')%
                          <INPUT TYPE="hidden" NAME="mscState" VALUE="%value mscState%">
                          <INPUT TYPE="hidden" NAME="action" VALUE="edit">
                          <INPUT TYPE="hidden" NAME="mscAlias" VALUE="%value mscAlias%">
                          %ifvar mscState equals('disabled')%
                            <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
                          %endif%
                        %else%
                          <INPUT TYPE="hidden" NAME="mscState" VALUE="disabled">
                          <INPUT TYPE="hidden" NAME="action" VALUE="add">
                          <INPUT type="button" value="Save Changes" onclick="return confirmAdd();">
                        %endif%
                      </TD>
                    </TR>
                  </FORM>
                </TABLE>
            </TD>
         </TR>
    </TABLE>

    <script>
     %ifvar action equals('edit')%
         var inputs = document.getElementsByTagName('input');
         %switch mscState%
         %case 'enabled'%
            for(var i in inputs) inputs[i].disabled = 'disabled';
               document.getElementById('conflictRule').disabled = 'disabled';
                %case 'suspended'%
                    for(var i in inputs) inputs[i].disabled = 'disabled';
                    document.getElementById('conflictRule').disabled = 'disabled';
            %end%
      %endif%
    </script>
  </BODY>
</HTML>
