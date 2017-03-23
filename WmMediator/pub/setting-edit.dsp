<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

  <TITLE>Mediator Extended Settings - Edit</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
  <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
  <SCRIPT SRC="js/setting.js"></SCRIPT>
  
  <SCRIPT>
  	function validateSettingsInput(){
  	  	var value=document.forms["extendedForm"]["settings"].value;
  		  		 		
  		if(value==null ||  value=='' ){
  			return true;
  		}
  		
  		var valueArr = value.split("\n");
  		var invalidvalues=null;
  		
  		for(var i = 0;i<valueArr.length;i++){
  			valueArr[i]=valueArr[i].replace(/^\s+/,""); // left trim
  			var tmp=valueArr[i];
  			tmp=tmp.replace(/^\s/,""); //to avoid all spaces
  			
  			if(tmp==''){
  				continue;
  			}
  			  			
  			if(valueArr[i].substr(0,3)!='pg.'){
  				
  				var idx=valueArr[i].indexOf("=");
  				var valueStr=valueArr[i];
  				if(idx>0){
  					valueStr=valueStr.substr(0,idx);
  				}
  				if(invalidvalues==null){
  					invalidvalues=valueStr;
  				}else{
  					invalidvalues=invalidvalues+","+valueStr;
  				}
  			}
		}
		
  		if(invalidvalues!=null){
  			var msg = 'Invalid property names : {'+invalidvalues+'}'+'\n'+'The names of extended properties must begin with "pg.".'; 
			document.getElementById("invalid-property-error").innerHTML = "<div class=\"message\"><span>"+msg+"</span></div>";	 		
  			return false;
  		}
  		return true;
  	}
  	
	
  </SCRIPT>
</HEAD>

<BODY>

 <div id="heading" class="breadcrumb" style="height:1em; margin:auto">
        Extended Settings </TD>
 </div>
<div id="invalid-property-error">
</div>

<TABLE WIDTH="100%">
	<TR>	
 	
%ifvar action equals('change')%
  %invoke pg.UIConfig:saveConfigPropsFromUI%  
  %endinvoke%
  <script>
  window.open("setting.dsp","_self")
  </script>  
%endif%

    <TR>
      <TD colspan=2>
        <UL style="width:39%">          
          <LI><A HREF="setting.dsp">Return to Extended Settings</A></LI>          
        </UL>
    </TR>
    <TR>
      <TD>
		<FORM name="extendedForm" action="setting-edit.dsp" method="POST">
		<INPUT type="hidden" name="action" value="change">
		
		
		<TABLE class="tableForm" width="100%" >
		
          <TR>
            <TD class="heading">Extended Settings</TD>
          </TR>
          <TR>
            <TD class="oddcol-l">Key=Value</TD>
          </TR>
          <TR>
            <TD class="evenrow-l">  
<TEXTAREA style="width:100%" wrap="off" rows=30 cols=50 name="settings" wrap="virtual"></TEXTAREA>			
<script> 

var x = hideKey();
%invoke pg.UIConfig:getConfigProps%  
  %loop -struct%  
	
	var a='%value $key%';
	var b='%value%';
	
	var i=0;
	var found = false;	
	while(i < x.length)
	{		
		
		if(a != x[i])
		{
			i++;
		}
		else if(a == x[i])
		{
			found = true;	
			break;
		}
				
	}
	
	if(found == false)
	{			
	 document.forms["extendedForm"]["settings"].value +=a;	
	 document.forms["extendedForm"]["settings"].value +="=";
	 document.forms["extendedForm"]["settings"].value +=b;
	 document.forms["extendedForm"]["settings"].value +="\n";	
	}
		

 %endloop% 
%endinvoke%

var inputvalues=document.forms["extendedForm"]["settings"].value.split("\n");
inputvalues.sort();
document.forms["extendedForm"]["settings"].value ='';
for (i=0;i<inputvalues.length;i++){
document.forms["extendedForm"]["settings"].value+=inputvalues[i]+"\n";
}


 
</script>			
				
			</TD>   
	      </TR>          
		  <TR></TR>
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes" onClick="return validateSettingsInput();">
            </TD>
          </TR>          
          </FORM>
          
		 
        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>

</HTML>