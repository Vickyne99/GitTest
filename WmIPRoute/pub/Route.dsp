<HTML>
<HEAD>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

%include ../../WmRoot/pub/b2bStyle.css%

<SCRIPT LANGUAGE="JavaScript">
var row = "even";
var other = "odd";
var swap = "";


function moveUp (e)
{
	var tmp = e.target ? e.target : e.srcElement;

	var tr = getParent(tmp, "TR");
	var order = parseInt(tr.id);
 	if(order == 0){
 		return true;
 	}

	var tbody = getParent(tr, "TBODY");
	var trs = tbody.rows;
	var trl= trs.length;
	var a = new Array();
	for (var i = 0; i < trl; i++) {
		a[i] = trs[i];
	}

	//swap with ordered one
	var tmprow = a[order-1];
	a[order-1] = a[order];
	a[order-1].id = order-1;
	a[order] = tmprow;
	a[order].id = order;

	for (var i = 0; i < trl; i++) {
		tbody.appendChild(a[i]);
	}

	return true;
}

function moveDown (e)
{
	var tmp = e.target ? e.target : e.srcElement;

	var tr = getParent(tmp, "TR");
	var order = parseInt(tr.id);


	var tbody = getParent(tr, "TBODY");
	var trs = tbody.rows;


	var trl= trs.length;
 	if(trl-1 == order){
 		return true;
 	}

	var a = new Array();
	for (var i = 0; i < trl; i++) {
		a[i] = trs[i];
	}

	//swap with ordered one
	var tmprow = a[order+1];

	a[order+1] = a[order];
	a[order+1].id = order+1;
	a[order] = tmprow;
	a[order].id = order;



	for (var i = 0; i < trl; i++) {
		tbody.appendChild(a[i]);
	}

	return true;
}

function getParent(el, pTagName) {

	if (el == null) return null;
	else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase())	// Gecko bug, supposed to be uppercase
		return el;
	else
		return getParent(el.parentNode, pTagName);
}

function writeTD (c)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\">");
	return true;
}
function w(text)
{
	document.write(text);
}
function writeTDspan(c,span)
{
	w("<TD CLASS=\"");
	w(row);
	w(c);
	w("\" COLSPAN=");
	w(span);
	w(">");
}
function swapRows()
{
	swap = row;
	row = other;
	other = swap;
}


  function confirmDelete (key) {
    if (key.substr(0,1)=="*") {
		alert("Default Rule can not be deleted");
		return false;
    }
    var msg = "OK to delete routing rule?";
    if (confirm (msg)) {
        document.deleteform.key.value = key;
            document.deleteform.submit();
          return false;
    } else return false;
  }

  function edit (key, msgType, version, senderId, receiverId, isService) {
     	document.editform.key.value = key;
        document.editform.MessageType.value = msgType;
        document.editform.MessageVersion.value = version;
        document.editform.SenderID.value = senderId;
        document.editform.ReceiverID.value = receiverId;
        document.editform.ISService.value = isService;
        document.editform.submit();
        return false;
  }

  function save (e) {


	var tmp = e.target ? e.target : e.srcElement;

	var table = getParent(tmp, "TABLE");
	var tbody = table.tBodies[0];
	var trs = tbody.rows;
	var trl= trs.length;

	var str ="";
	for (var i = 0; i < trl; i++) {
        str = str + trs[i].name;
        if(i+1<trl){
        	str = str + ',';
        }
	}
    document.priorityform.keyList.value = str;
    document.priorityform.submit();

        return true;
  }




</SCRIPT>
</HEAD>
<BODY>
<TABLE width="100%">

<TABLE width="75%">
  <tr>
    <td class="menusection-adapters" colspan="2">
      %ifvar productKey%
      	%value productKey% &gt;
      %else%
      	IP Finance &gt;
	  %endif%
      Routing
    </td>
  </tr>
<TR>
	%ifvar action equals('add')%
	  %invoke wm.ip.route:addRule%
        %ifvar results%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value results%</TD></TR>
        %endif%
      %endinvoke%
	%endif%
	%ifvar action equals('edit')%
	  %invoke wm.ip.route:deleteRule%
      %endinvoke%
	  %invoke wm.ip.route:addRule%
        %ifvar results%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value results%</TD></TR>
        %endif%
      %endinvoke%
	%endif%
	%ifvar action equals('delete')%
	  %invoke wm.ip.route:deleteRule%
        %ifvar results%
      <tr><td colspan="2">&nbsp;</td></tr>
          <TR><TD class="message" colspan="2">%value results%</TD></TR>
        %endif%
      %endinvoke%
	%endif%

    <TD colspan="2">
        <UL>
            <LI><A HREF="Route-addedit.dsp?productKey=%value productKey%">Create Routing Rule</A></LI>
        </UL>
    </TD>
</TR>
<TR>
    <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
    <TD>
<TABLE class="tableView" width="100%">
<thead>
    <TR>
        <TD class="heading" colspan=9>Routing Configuration</TD>
    </TR>

	<TR>
	   <TD class="oddcol">Priority</TD>
	   <TD class="oddcol">Message Type</TD>
	   <TD class="oddcol">Message Version</TD>
	   <TD class="oddcol">Sender ID</TD>
	   <TD class="oddcol">Receiver ID</TD>
	   <TD class="oddcol">IS Service</TD>
	   <TD class="oddcol">Edit</TD>
	   <TD class="oddcol">Delete</TD>
	</TR>
</thead>
	%invoke wm.ip.route:getRules%
<tbody>
	%loop routingRules%
<TR id=%value Order% name=%value Order%>
    <script>writeTD("rowdata");</script>
	  <p onClick="return moveUp(event);">
      <font face="webdings">5</font></p>
	  <p onClick="return moveDown(event);">
      <font face="webdings">6</font></p>
</TD>
    <script>writeTD("rowdata");</script>
        %value MessageType%
    </TD>
    <script>writeTD("rowdata");</script>
        %value Version%
    </TD>
	<script>writeTD("rowdata");</script>
	%value SenderID%
	</TD>
	<script>writeTD("rowdata");</script>
		%value ReceiverID%
	</TD>
	<script>writeTD("rowdata");</script>
	%value ISService%
	</TD>
    <script>writeTD("rowdata");</script>
	  <p class="imagelink" href="" onClick="return edit('%value Order%','%value MessageType%','%value Version%','%value SenderID%','%value ReceiverID%','%value ISService%');">
      <img src="images/edit.gif" border="none"></p>
</TD>
    <script>writeTD("rowdata");</script>
	  <a class="imagelink" href="" onClick="return confirmDelete('%value Order%');">
      <img src="images/delete.gif" border="none"></a>
</TD>
    <script>swapRows();</script>
	%endloop%
</tbody>
	%endinvoke%
<tfooter>
<tr>
	<TD colspan=9 class="action">
		<INPUT TYPE="SUBMIT" VALUE="Save" onClick="return save(event);" >
	</TD>
</TR>
</tfooter>

</TABLE>
</TD>
<TD WIDTH="30">&nbsp;</TD>
</TR>
</TABLE>
<FORM name="deleteform" action="Route.dsp" method="POST">
  <INPUT type="hidden" name="action" value="delete">
  <INPUT type="hidden" name="productKey" value="%value productKey%">
  <INPUT type="hidden" name="key">
</FORM>
<FORM name="editform" action="Route-addedit.dsp" method="POST">
  <INPUT type="hidden" name="action" value="edit">
  <INPUT type="hidden" name="productKey" value="%value productKey%">
  <INPUT type="hidden" name="key">
  <INPUT type="hidden" name="MessageType">
  <INPUT type="hidden" name="MessageVersion">
  <INPUT type="hidden" name="SenderID">
  <INPUT type="hidden" name="ReceiverID">
  <INPUT type="hidden" name="ISService">
</FORM>
<FORM name="priorityform" action="/invoke/wm.ip.route/setRulePriority" method="POST">
  <INPUT type="hidden" name="productKey" value="%value productKey%">
<INPUT type="hidden" name="keyList">
</FORM>
</BODY></HTML>

