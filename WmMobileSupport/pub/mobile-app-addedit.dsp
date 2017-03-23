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
      Mobile Applications &gt;
      %ifvar action equals('edit')% Edit %else% Add %endif% Mobile Application
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="mobile-app.dsp">Return to Mobile Applications</A></LI>
          </UL>
        </TD>
      </TR>
      %ifvar action equals('edit')%
        %invoke wm.mobile.datasync.appimpl:getMobileApp%
      %endif% %endif%

      %ifvar message%
        <tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan="2">%value message%</TD></TR>
      %endif%

      <TR>
        <TD></TD>
        <TD>
          <TABLE class="tableForm">
            <TR>
              <TD colspan="2" class="heading">Mobile Application Details</TD>
            </TR>
            <FORM NAME="addform" ACTION="mobile-app.dsp" METHOD="POST">
              <SCRIPT LANGUAGE="JavaScript">          
                //JS .trim() is not supported in IE 6-8, so here is the hack for this.
                if(typeof String.prototype.trim !== 'function') {
                  String.prototype.trim = function() {
                  return this.replace(/^\s+|\s+$/g, '');
                  }
                }          
                function saveChanges() {
                if(document.getElementById('appName').value.trim() == "") {
                  alert("Application name cannot be blank.");
                  document.getElementById('appName').focus();
                  return false;
                }
    
                %ifvar action equals('add')%if(!checkLegalName(document.getElementById('appName'), "appName")) return false;%endif%
                
                if(document.getElementById('appVersion').value.trim() == "") {
                  alert("Application version cannot be blank.");
                  document.getElementById('appVersion').focus();
                  return false;
                }            
                %ifvar action equals('add')%if(!checkLegalName(document.getElementById('appVersion'), "appVersion")) return false;%endif%
                
                var selectedMSCs = document.getElementById('mscs');
                var mscs = document.getElementById('availMscs');
                selectedMSCs.value = "";
                  for(var i = 0; i < mscs.options.length; i++)
                  {
                    if(mscs.options[i].selected) {
                      selectedMSCs.value = selectedMSCs.value + mscs.options[i].text + ";";
                    }
                  }
                  document.addform.submit();
                  return true;
                }
                
                function checkLegalName(field, fieldName)
                {
                  var name = field.value.trim();
                  var illegalChars = "- #&@^!%*:$/\\`;,~+=)(|}{][><\"?";
    
                  for (var i=0; i<illegalChars.length; i++)
                  {
                    if (name.indexOf(illegalChars.charAt(i)) >= 0)
                    {
                      alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                      field.focus();
                      return false;
                    }
                  }
                  return true;
                }
                
              </SCRIPT>
                                   
              <TR>
                <TD class="evenrow">Application Name</TD>
                <TD class="evenrow-l">
                  <INPUT NAME="appName" id="appName" size="40" maxLength="60" VALUE="%value appName%" %ifvar action equals('edit')% DISABLED %endif%> </TD>
                </TR>              
                 
                <TR>
                  <TD class="oddrow">Application Version</TD>
                  <TD class="oddrow-l">
                    <INPUT NAME="appVersion" id="appVersion" size="40" maxLength="60" VALUE="%value appVersion%" %ifvar action equals('edit')% DISABLED %endif%> </TD>
                </TR>      
                <TR>
                  <TD class="evenrow" valign="top">Mobile Sync Component Alias</TD>
                  <TD class="evenrow-l">
                    %invoke wm.mobile.datasync.msc:getAllMobileSyncComponents%
                      <SELECT MULTIPLE id="availMscs" NAME="availMscs" style="width:250">
                        <OPTION value="">&nbsp;</OPTION>
                        %loop mobileSyncComponents%
                          <OPTION VALUE="%value mscAlias%" title="Alias: %value mscAlias% Download Service: %value downloadService% Upload Service: %value uploadService% Conflict Rule: %value conflictRule%">%value mscAlias%</OPTION>
                        %endloop%
                      </SELECT>
                    </TD>
                </TR>

                <TR>
                  <TD colspan=2 class="action">
                    %ifvar action equals('edit')%
                      <INPUT TYPE="hidden" NAME="action" VALUE="edit">
                      <INPUT TYPE="hidden" NAME="appName" VALUE="%value appName%">
                      <INPUT TYPE="hidden" NAME="appVersion" VALUE="%value appVersion%">
                      <INPUT type="button" value="Save Changes" onclick="return saveChanges();">
                      <input type="hidden" name="mscs" id="mscs" value="">
                    %else%
                      <INPUT TYPE="hidden" NAME="action" VALUE="add">
                      <INPUT type="button" value="Save Changes" onclick="return saveChanges();">
                      <input type="hidden" name="mscs" id="mscs" value="">
                    %endif%
                  </TD>
                </TR>
              </FORM>
            </TABLE>
          </TD>
        </TR>
      </TABLE>
      <script>
        for (var i = 0; i < document.addform.availMscs.options.length; i++)
        {
          %loop mscs%
            if(document.addform.availMscs.options[i].text == '%value mscAlias%') document.addform.availMscs.options[i].selected = "selected";
          %endloop%
        }
      </script>
  </BODY>
</HTML>
