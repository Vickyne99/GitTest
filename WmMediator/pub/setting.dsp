<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

  <TITLE>Mediator Extended Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
  <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
  <SCRIPT SRC="js/setting.js"></SCRIPT>
  <SCRIPT SRC="js/help.js"></SCRIPT>
  <SCRIPT>
  function fun1(x){
  var help_text=help_fun(x.id);
	if(help_text !=" ")
	{
		
		document.getElementById(x.id).setAttribute("title",help_text);
	}
	else
	{
		help_text="No Description is available";
		document.getElementById(x.id).setAttribute("title",help_text);
	}

  }
</SCRIPT>
</HEAD>
<BODY>
  <TABLE WIDTH="100%">
    <TR>
      <TD class="breadcrumb" colspan="4">
        Extended Settings </TD>
    </TR>
    <TR/>
    <TR>
      <TD colspan=2>
        <UL>          
          <LI><A HREF="setting-edit.dsp">Edit Extended Settings</A></LI>       
        </UL>
    </TR>
	
    <TR>
      <TD>				
		<TABLE class="tableView" width="60%">
		
          <TR>
            <TD class="heading" colspan=2>Extended Settings</TD>
          </TR>
          
          
		<script>
		var z=0;
		var temp =[];
		var arr=[];       
		var odd="#E0E0C0";
		var even="#F0F0E0";
		var color="";		
		document.write("<tr class=\"subheading2\" bgcolor=");
		document.write(odd);
		document.write("><td>Key</td>");			
		document.write("<td>Value</td></tr>");	
		var hiddenkey = hideKey();
%invoke pg.UIConfig:getConfigProps%  
  %loop -struct%  
	
	var key='%value $key%';
	var value='%value%';
	var i=0;
	var found = false;	
	
	while(i < hiddenkey.length)
	{
		
		
		if(key != hiddenkey[i])
		{
			i++;
		}
		else if(key == hiddenkey[i])
		{
			found = true;	
			break;
		}
				
	}
	
	if(found == false)
	{
	temp[z]=key;	
	z++;
	temp[z]=value;		
	z++;
	}		

 %endloop%
 
		//assign value
		var index=0;
		for(var x1 = 0; x1 < temp.length/2; x1++){
			arr[x1] = [];    			
			for(var y1 = 0; y1 < 2; y1++){ 			
				arr[x1][y1] = temp[index];   
				index++;					
			}
		}
			
			
        // sort an array
        arr.sort(function (a, b) { 
            return (a[0] == b[0]) ? 0 : ((a[0] > b[0]) ? 1 : -1 );
        });	
				
		//Display sorted array
		for(var i1=0;i1<arr.length;i1++){
		if ( i1 % 2 == 0 )
			color=even;
		else
			color=odd;
			for(var j1=0;j1<2;j1++){
				if(j1 == 0){
					document.write("<tr bgcolor=");
					document.write(color);
					document.write(">");
					document.write("<td title id=");
					document.write(arr[i1][j1]);
					document.write(" onmouseover=fun1(this)>");
					document.write(arr[i1][j1]);
					document.write("</td>");					
					}
					else if(j1 ==1){
					document.write("<td>");	
					document.write(arr[i1][j1]);					
					document.write("</td></tr>");					
					}
			}
		} 
  
%endinvoke%
 </script>            
                            
            </TD>
          </TR>     
          	 
        </TABLE>
      </TD>
    </TR>
  </TABLE>
 </BODY>
</HTML>