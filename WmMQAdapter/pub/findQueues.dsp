<HTML>
<HEAD>
    <TITLE>Find Queues</TITLE>
<SCRIPT language="JavaScript">
function buildSelectionString() 
{
  var oneSelected = false;
  var sels = "";
  var queuenames = "";
  var len = availablequeues.length;
  if( typeof len == "undefined" ) 
  {
    // only a single 'selected' checkbox.  length is undefined.
    sels = availablequeues.checked;
    descriptions = availablequeues.value;
    queuenames = availablequeues.value;
    if (availablequeues.checked) 
    {
      oneSelected = true;
    }
  }
  else 
  {
    for(var i=0; i<len; i++) 
    {
      if (availablequeues[i].selected) 
      {
         sels = sels + availablequeues[i].checked + " ";
         queuenames = queuenames + availablequeues[i].value + "\n";
         oneSelected = true;
      }
    }
  }
  alert("forms = " + parent.document.forms[0].name);
  parent.document.forms[0].queueslist=queuenames;
  alert("queueslist=" + parent.document.forms[0].queueslist);
  alert("parents qMgr=" + parent.document.forms[0].queueManagerName);
  //parent.document.forms[0].queueManagerName.value = "poop";

  return oneSelected;
}
</SCRIPT>
</HEAD>
%invoke wm.mqseries.admin:findQueues%
    %onerror%       
  %include errorWnd.dsp%
    %endinvoke%
<BODY>
%comment%--------------------
*************************<br>
%loop -struct%
  %value $key% = %value% <br>
%endloop%
*************************<br>
%loop queues%
  %value queuename% <br>
%endloop%
*************************<br>
-----------------%endcomment%
<select multiple name="availablequeues" size=8>
%loop queues%
         <option value="%value queuename%"> *%value queuename%*</option>
%endloop%
 </select>

<CENTER>
    <FONT size='+1' color='red'>
       
    </FONT>
</CENTER>
<BR>
<FORM>
    <CENTER>
        <INPUT type='button' value='save' onclick='buildSelectionString();parent.close()'>
    </CENTER>
</FORM>
</BODY></HTML>
