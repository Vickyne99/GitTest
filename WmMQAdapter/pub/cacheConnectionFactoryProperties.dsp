<SCRIPT language="JavaScript">
function selectQueues(frm) 
{
  
  var oneSelected = false;
  var queuenames = "";
  var len = frm.availableQueues.length;
  if( typeof len == "undefined" ) 
  {
    // only a single 'availableQueues' option.  length is undefined.
    queuenames = frm.availableQueues.value;
    if (frm.selected.checked) 
    {
      oneSelected = true;
    }
  }
  else 
  {
    for(var i=0; i<len; i++) 
    {
      if (frm.availableQueues[i].selected) 
      {
         onequeue = frm.availableQueues[i].value;
         qindx = onequeue.indexOf(" ");
	 if (qindx > -1)
	 {
		onequeue = onequeue.substring(0, qindx);
	 }
	 queuenames = queuenames + onequeue + " ";
         oneSelected = true;
      }
    }
  }
  //frm.CPROP.queueName.value = queuenames;
  frm.elements[".CPROP.queueName"].value = queuenames;
  return oneSelected;
}
</SCRIPT>
		%invoke wm.mqseries.admin:findQueues%	
		
        %onerror%       
	<FONT color="red"><B>
	%ifvar localizedMessage%%value localizedMessage%%endif% - 
	%ifvar errorMessage%%value errorMessage%%endif%</B></FONT>
        %endinvoke%
		
       %ifvar queues%
 		    <select multiple name="availableQueues" onChange="selectQueues(document.forms[0]);return false">
		        %loop queues%
			    <option value="%value queuename%" %ifvar selected equals(yes)%selected%endif%>
				           %value queuename%
			    </option>
		        %endloop%
		    </select>
		