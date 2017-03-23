<html>
<head><!-- recentProcessActivity.dsp -->
<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script language=javascript>

var rowCount=0;	var oddRow=false;	
function writeTdClassTag(){				

  if (oddRow){			     
     document.write ('<td class=oddrow-l>');
  }
  else {			    
     document.write('<td class=evenrow-l>')
 }		
}	

function    newRow(){		rowCount++;
 	if ((rowCount % 2) >0) {
  	   oddRow=true;		        }		
        else{	
           oddRow=false;
	}	
}	

function resetRowCount() {
	rowCount=0;	
}

function callProcessModelDetail(processName, processKey) {

		document.location.href = "processModelDetail.dsp?srcPage=Process Models&processName="+processName+"&processKey="+processKey;	
}	

function callQueryProcessStatus(srcPage, processID) {
   document.alerts.srcPage.value = srcPage;		
   document.alerts.processID.value = processID;						        
   document.alerts.submit();	
}

</script>

%include ../../WmRoot/pub/b2bStyle.css%
<SCRIPT SRC="scripts/webMethods.js"></SCRIPT><title>Monitor</title></head>

<body><form name="alerts" action="fin-queryProcessStatus.dsp" method="POST">
<table width="100%">	
<td class="menusection-Adapters">SWIFT &gt; 
                                 Repair Messages
</td> 
</table>

%ifvar resubmit equals('true') %	
%invoke wm.fin.resubmit:getStepPipeline%
%endinvoke wm.fin.resubmit:getStepPipeline%
	
%invoke pub.monitor.process.instanceControl:resubmitInstanceStep%
%endinvoke pub.monitor.process.instanceControl:resubmitInstanceStep%
%endif%

%invoke wm.fin.resubmit:getFailedMessages%	
<table width="100%">	
%ifvar message%		
<tr><td class="message">%value message%</td>		
</tr>	
%endif%	
<br>	  
<td class=heading colspan=3>Recently Failed Processes</td>	
<tr>	
<td valign=top>	
</table>	
%ifvar recentlyFailed%		
<table width="100%">		
		<td class=subheading width="25%">Name</td>
		<td class=subheading>ID</td>
		<td class=subheading width="30%">Time Failed</td>			
<tr>
	<script>resetRowCount();</script>		
	%loop recentlyFailed%
	<script>newRow();writeTdClassTag();</script>
        
        %ifvar PROCESSKEYDECODE%		
           %value PROCESSKEYDECODE%
	    %else%
		   <CENTER>-</CENTER>				
	    %endif%			
        <script>writeTdClassTag();</script>	
			
        %ifvar INSTANCEID%					
           <a href="javascript:callQueryProcessStatus('Recent Activity', '%value INSTANCEID%')">%value INSTANCEID%</a>				
        %else%					
           <center>-</center>				
        %endif%			
        <script>writeTdClassTag();</script>				
			
        %ifvar AUDITTIMESTRING%					
           %value AUDITTIMESTRING%				
        %else%				
           <center>-</center>				
        %endif%	
		
        %loopsep 
<tr>%		
%endloop%	
</table>
%else%			
</table>
<table width="100%">	
<td class=subheading>There are no recently failed processes.</td>	
</table>	
%endif%		

<p>		
<table width="100%">
 <tr>
	<td class=heading colspan=5>
			Resubmit Processes
	</td>
 </tr>		
%ifvar resubmitRecs%
		<td class=subheading width="25%">Name</td>
		<td class=subheading>ID</td>
		<td class=subheading width="30%">Time Failed</td>		
%loop resubmitRecs%			
<tr>
	<script>resetRowCount();</script>
	<script>newRow();writeTdClassTag();</script>
        
        %ifvar processName%		
           %value processName%
	    %else%
		   <CENTER>-</CENTER>				
	    %endif%			
        <script>writeTdClassTag();</script>	
			
        %ifvar instanceId%					
           <a href="javascript:callQueryProcessStatus('Recent Activity', '%value instanceId%')">%value instanceId%</a>				
        %else%					
           <center>-</center>				
        %endif%			
        <script>writeTdClassTag();</script>				
			
	    %loop stepControl%
           %ifvar AUDITTIMESTRING%					
              %value AUDITTIMESTRING%				
           %else%				
              <center>-</center>				
           %endif%	
        %endloop%
		
</tr>	
%endloop%
</table>
%else%			
</table>
<table width="100%">	
<td class=subheading>There are no recently resubmitted processes.</td>	
</table>	
%endif%
%endinvoke%

<input type=hidden name=srcPage></input><input type=hidden name=processID></input></form></body></html>