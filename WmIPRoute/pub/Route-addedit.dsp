
<HTML>
  <HEAD>
%include ../../WmRoot/pub/b2bStyle.css%
<!--    <SCRIPT SRC="webMethods.js.txt">-->
          <SCRIPT LANGUAGE="JavaScript">
          function confirmEdit ()
          {
            if (document.addform.isService.value == "")
            {
              alert ("You must specify the fully qualified name of an Integration Server Service.");
            }
            else
            {
              document.addform.submit();
              return true;
            }
            return false;
          }
          function confirmAdd ()
          {
            if ((document.addform.msgType.value == "")  ||
                (document.addform.version.value == "")  ||
                (document.addform.senderId.value == "")  ||
                (document.addform.receiverId.value == "")  ||
                (document.addform.isService.value == "")    )
            {
              alert ("You must specify all the parameters for the rule.");
              return false;
            }
            else
            {
              var keyArray;
              if (! document.addform.keys)
              {
                keyArray = new Array(0);
              }
              else if (! document.addform.keys.length)
              {
                keyArray = new Array(1);
                keyArray[0] = document.addform.key.value;
              }
              else
              {
                var keysLen = document.addform.keys.length;
                keyArray = new Array(keysLen);
                for (i = 0; i < keysLen; i++)
                {
                  keyArray[i] = document.addform.keyList[i].value;
                }
              }

              for (ind = 0; ind < keyArray.length; ind++)
              {
                if (keyArray[ind] == document.addform.key.value)
                {
                  alert("Rule already exists!");
                  return false;
  		        }
	      	   }

              document.addform.submit();
              return true;
            }
            return true;
          }
    </SCRIPT>
  </HEAD>
    <TABLE width="100%">
      <TR>
        <TD class="menusection-adapters" colspan="2">
     	%ifvar productKey%
      		%value productKey% &gt;
      	%else%
      		IP Finance &gt;
	  	%endif%
            Routing &gt;
            %ifvar action equals('edit')%
                %value alias% &gt; Edit
            %else%
                Create Routing Rule
            %endif%
        </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <LI><A HREF="Route.dsp?productKey=%value productKey%">Return to Routing Configuration</A></LI>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>&nbsp;</TD>
        <TD>
      <TABLE class="tableForm">
        <TR>
            <TD colspan="2" class="heading">Routing Rule Properties</TD>
        </TR>
          <FORM NAME="addform" ACTION="Route.dsp" METHOD="POST">

          <TR>
  <INPUT type="hidden" name="productKey" value="%value productKey%">

            <TD class="oddrow">Message Type</TD>
            <TD class="oddrow-l">
              %ifvar action -equals('edit')%
 				<INPUT TYPE="hidden" NAME="msgType" VALUE="%value MessageType%">%value MessageType%
 			  %else%
              	<INPUT NAME="msgType" VALUE="%value MessageType%">
              %endif%
             </TD>
          </TR>
          <TR>
            <TD class="evenrow">Version</TD>
            <TD class="evenrow-l">
              %ifvar action -equals('edit')%
 				<INPUT TYPE="hidden" NAME="version" VALUE="%value MessageVersion%">%value MessageVersion%
 			  %else%
              	<INPUT NAME="version" VALUE="%value MessageVersion%">
              %endif%
             </TD>
          </TR>
          <TR>
            <TD class="oddrow">Sender ID</TD>
            <TD class="oddrow-l">
              %ifvar action -equals('edit')%
 				<INPUT TYPE="hidden" NAME="senderId" VALUE="%value SenderID%">%value SenderID%
 			  %else%
              	<INPUT NAME="senderId" VALUE="%value SenderID%">
              %endif%
             </TD>
          </TR>
          <TR>
            <TD class="evenrow">Receiver ID</TD>
            <TD class="evenrow-l">
              %ifvar action -equals('edit')%
 				<INPUT TYPE="hidden" NAME="receiverId" VALUE="%value ReceiverID%">%value ReceiverID%
 			  %else%
              	<INPUT NAME="receiverId" VALUE="%value ReceiverID%">
              %endif%
             </TD>
          </TR>
          <TR>
            <TD class="oddrow">IS Service</TD>
            <TD class="oddrow-l">
              <INPUT NAME="isService" VALUE="%value ISService%"> </TD>
          </TR>
          <TR>
            <TD colspan=2 class="action">
              <INPUT TYPE="hidden" NAME="args" VALUE="xxx">
            %ifvar action equals('edi	t')%
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="key" VALUE="%value key%">
              <INPUT type="button" value="Save Changes" onclick="return confirmEdit();">
            %else%
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

    </BODY>
  </HTML>
