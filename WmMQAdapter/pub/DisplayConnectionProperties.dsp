%comment%----- Displays connection type parameters -----%endcomment%

<SCRIPT language="JavaScript" src="mqconnjs.txt"></SCRIPT>
<SCRIPT language="JavaScript">
function appendSecurityTokenIfCSRFEnabled(){

	if( typeof(is_csrf_guard_enabled) == "undefined" )
	{
		return "";
	}
	if(is_csrf_guard_enabled && needToInsertToken) {
		return('&'+_csrfTokenNm_ + '=' + _csrfTokenVal_);
	} else {
		return "";
	}
}

function findQueues(frm) 
{
	if ((frm.resourceName.value  == "") ||
	  (frm.resourceFolderName.value  == "") )
	{
	  alert("Please specify a Folder & Connection Name before attempting to find the queues");
	  return false; 
	}      
	if ((frm.elements[".CPROP.queueManagerName"].value == "") && 
	 (frm.elements[".CPROP.hostName"].value.length > 0) )
	{
	  alert("Please supply the Queue Manager name before attempting to find the queues");
	  return false; 
	}      
	var sslOptionradio = document.getElementById("sslKeyStore");

	if(sslOptionradio!=null){
		alert("Update the SSl Options and related fields again after selecting the queue.");
	}

	var winl = (screen.width) / 4;
	var wint = (screen.height) / 4;

	winprops = 'height=1,width=1,top=1,left=1,scrollbars=false,resizable,toolbar=0,menubar=0'

	winname = "&connectionAlias=" + frm.resourceFolderName.value;
	winname = winname + ":" + frm.resourceName.value;

	%loop parameters%
	winname = winname + "&%value systemName%=" + frm.elements[".CPROP.%value systemName%"].value;
	%comment%-------------------------------
	%ifvar systemName equals(sslCipherSpec)%
		%ifvar resourceDomain -notEmpty%
			winname = winname + "&Specs=";
			%loop resourceDomain%
				winname = winname + "%value resourceDomain%" + "";
				
			%endloop%
		%endif%
	%endif%
	----------------------------%endcomment%

	%endloop%
	winname = winname + appendSecurityTokenIfCSRFEnabled();
	
	var http = new XMLHttpRequest();

  
	//alert(winname);
    http.open("POST", "cacheConnectionFactoryProperties.dsp?", true);
	http.send(winname);
	
	http.onreadystatechange = function(){
		if(http.readyState == 4 && http.status == 200){
					//alert( document.getElementById("myDiv"));
                    document.getElementById("myDiv").innerHTML = http.responseText;
		};  
     };
	nextwindow = location.href + "&resourceName=" + frm.resourceName.value;
	nextwindow = nextwindow + "&resourceFolderName=" + frm.resourceFolderName.value;

	var pkgname = "";  
	var len = frm.packageName.length;
	  if( typeof len == "undefined" ) 
	  {
		// only a single 'packageName' option.  length is undefined.
		pkgname = frm.packageName.value;
	  }
	  else 
	  {
		for(var i=0; i<len; i++) 
		{
		  if (frm.packageName[i].selected) 
		  {
			 pkgname = frm.packageName[i].value;
		  }
		}
	  }
	
}

function selectQueues(frm) 
{
  //alert("selectQueues entered " + frm);
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
function newQueues(frm) 
{
  //alert("newQueues entered " + frm);
  frm.elements[".CPROP.queueName"].value = frm.elements[".CPROP.queueName"].value ;
  //alert("queueName=" + document.forms[0].elements[".CPROP.queueName"].value);
  return true;
}
</SCRIPT>

%ifvar parameters%
    <script>setNavigation('ListAdapterConnTypes.dsp', '%value TemplateURL%', 'foo');</script>
<script>resetRows();</script>
<tr>
%include GetISPackages.dsp%
<script>swapRows();writeTD('row');</script>
Folder Name</td>
<script>writeTD('rowdata-l');</script>
<input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>          
</tr>
<tr>
<script>swapRows();writeTD('row');</script>
Connection Name</td>
<script>writeTD('rowdata-l');</script>
<input size=30 name="resourceName" value="%value -urlencode resourceName%"></input></td>
</tr>       
%comment%-------------------- 
*************************<br>
%loop -struct%
  %value $key% = %value% <br>
%endloop%
*************************<br>
-----------------%endcomment% 
<tr class="subheading3"><td  colspan=2>Connection Properties</td></tr>

%invoke wm.mqseries.admin:cacheConnectionFactoryProperties%
%onerror%       
  <FONT color="red"><B>
  Unable to cache the ConnectionFactory properties:<BR>
  %ifvar localizedMessage%%value localizedMessage%%endif% - 
  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT>
%endinvoke%

%invoke wm.mqseries.admin:reloadConnectionFactoryProperties%
%onerror%       
  <FONT color="red"><B>
  Unable to reload ConnectionFactory properties:<BR>
  %ifvar localizedMessage%%value localizedMessage%%endif% - 
  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT>
%endinvoke%

%loop parameters%
  %ifvar systemName equals(connectionAlias)%
 	<input type="hidden" name="connectionAlias" value="%value value%"></input>
  %else%
%comment%---------------------------------------------------------------------------------------------------------------- 

SSL Support 

If the watt.WmMQAdapter.SSL.Support property is set to 'true', these 3 properties will be displayed. 

Since this DSP cannot evaluate the watt.WmMQAdapter.SSL.Support property, it must use some other indicator. If the property 
is set to 'true', the wmMQConnection class will create a group named 'sslSettings' for these properties. This DSP checks 
the groupName property of each parameter. If it is 'sslSettings', then the property is displayed.
--------------------------------------------------------------------------------------------------------------%endcomment%
	%ifvar systemName equals(secureCSRFToken)%	
	%else%
  	%ifvar systemName equals(sslOptions)%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar groupName equals(sslSettings)% 
			<script> sslOption = "keystore alias";</script>
			<tr> <script>writeTD('row');</script> SSL Option </td><script>writeTD('rowdata-l');swapRows();</script>
			<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore file" onclick="showKeystoreFileParams();">keystore file</input>
			<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore alias" checked onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
			 %else% 
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%endif%
	%else%
	%ifvar systemName equals(sslKeyStore)%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			%ifvar groupName equals(sslSettings)%
				<tr> <script>writeTD('row');</script>
				%value displayName%</td>    
				<script>writeTD('rowdata-l');swapRows();</script>
				<input id="sslKeyStore" size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td></tr>
					
			%else%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%else%
			%ifvar groupName equals(sslSettings)%
					<tr> <script>writeTD('row');</script>
				%value displayName%</td>    
					<script>writeTD('rowdata-l');swapRows();</script>
					<input id="sslKeyStore" size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td></tr>
					<script type="text/javascript">
					useSSlFilepath('sslKeyStore');</script>	
			  %else%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%endif%
      %else%
  	  %ifvar systemName equals(sslKeyStorePassword)%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			%ifvar groupName equals(sslSettings)%
    	        <script>writeTD('row');</script>
				%value displayName%</td>                     
				<script>writeTD('rowdata-l');swapRows();</script>
				<input id="sslKeyStorePassword"  size=60 type="password" name=".CPROP.%value -urlencode systemName%" value="" onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input></td></tr>	    
				<tr><script>writeTD('row');</script>Retype %value displayName%</td>
				<script>writeTD('rowdata-l'); swapRows();</script>
				<input id="retypeSslKeyStorePassword" size=60 type="password" name="PWD.CPROP.%value -urlencode systemName%" value=""></input></td></tr>
			%else%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%else%
			%ifvar groupName equals(sslSettings)%
    	        <script>writeTD('row');</script>
				%value displayName%</td>                     
				<script>writeTD('rowdata-l');swapRows();</script>
				<input id="sslKeyStorePassword"  size=60 type="password" name=".CPROP.%value -urlencode systemName%" value="" onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input></td></tr>
				<script type="text/javascript">
						useSSlFilepath('sslKeyStorePassword','pass');</script>	
				<tr><script>writeTD('row');</script>Retype %value displayName%</td>
				<script>writeTD('rowdata-l'); swapRows();</script>
				<input id="retypeSslKeyStorePassword"  size=60 type="password" name="PWD.CPROP.%value -urlencode systemName%" value=""></input></td></tr>
				<script type="text/javascript">
					useSSlFilepath('retypeSslKeyStorePassword','pass');</script>
				</td></tr>
			%else%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%endif%
		%else%
		%ifvar systemName equals(sslKeyStoreAlias)%
			%invoke wm.mqseries.admin:sslAliasSupported% 
			%endinvoke%
			%ifvar sslAliasSupported equals(false)%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%else%
				%ifvar groupName equals(sslSettings)%
					<tr > <script>writeTD('row');</script>
					%value displayName%</td>                     
					<script>writeTD('rowdata-l');swapRows();</script>
						<input id ="sslKeyStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td></tr>
						<script type="text/javascript">
						useSSlalias('sslKeyStoreAlias');</script>	
				%else%
					<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
				%endif%
			%endif%
	%else%
		%ifvar systemName equals(sslTrustStoreAlias)%
			%invoke wm.mqseries.admin:sslAliasSupported% 
			%endinvoke%
			%ifvar sslAliasSupported equals(false)%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%else%
				%ifvar groupName equals(sslSettings)%
					<tr  > <script>writeTD('row');</script>
					%value displayName%</td>                     
					<script>writeTD('rowdata-l');swapRows();</script>
					<input id="sslTrustStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td></tr>
					<script type="text/javascript">
						useSSlalias('sslTrustStoreAlias');</script>	
				%else%
					<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
				%endif%
	  	  %endif%
      %else%
  	    %ifvar systemName equals(sslCipherSpec)%
		%ifvar groupName equals(sslSettings)%
	    <script>writeTD('row');</script>
	    %value displayName%</td>                     
            <script>writeTD('rowdata-l');swapRows();</script>
            <select name=".CPROP.%value systemName%">
				<option width=300 value=""></option>
            %loop resourceDomain%
	    		%comment%-- start trax# 1-15I4ET --%endcomment%
	            <option width=300 value="%value resourceDomain%" %ifvar resourceDomain vequals(defaultValue)%selected="true"%endif%>
	            	%value resourceDomain%
	            </option>
    			%comment%-- end trax# 1-15I4ET --%endcomment%
            %endloop%
            </select> 
			<a onclick="alert('Set the system property com.ibm.mq.cfg.useIBMCipherMappings to true for SSL Cipher Spec or false for TLS Cipher Spec. The default value is true')">Help</a>
			</td></tr>
	      %else%
			<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	  	    %endif%
%comment%------- End of SSL Support --------------------------------------------------------------------------%endcomment%
  %else%
    %comment%-- start trax# 1-122V6J --%endcomment%
    %ifvar isHidden%
	%comment%-- set a hidden value --%endcomment%
	<input type=hidden name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"> </input>
    %else%
    %comment%-- end trax# 1-122V6J --%endcomment%
    
    <tr>
    %ifvar isPassword%
        <script>writeTD('row');</script>%value displayName%
					<script>writeTD('rowdata-l');swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change password field from "******" to "" -----%endcomment%
			%comment%----- LG TRAX 1-I49V9 -----%endcomment%
			%comment%----- Added second argument to passwordChange() function -----%endcomment%
			%comment%----- to support artconnjs.txt for multiple password fields -----%endcomment%
					<input size=60 
						   type=password
						   onChange="return passwordChanged(this.form, '%value -urlencode systemName%')"
						   name=".CPROP.%value -urlencode systemName%"
						   value=""></input></td></tr>

					<script>writeTD('row');</script>Retype %value displayName%</td>
					<script>writeTD('rowdata-l'); swapRows();</script>
			%comment%----- LG TRAX 1-BKBFM -----%endcomment%
			%comment%----- Change Retype field from "******" to "" -----%endcomment%
					<input size=60
						   type=password
						   name="PWD.CPROP.%value -urlencode systemName%"
						   value=""></input></td></tr>
    %else%
        %ifvar resourceDomain -notEmpty%
	    <script>writeTD('row');</script>
	    %value displayName%</td>                     
            <script>writeTD('rowdata-l');swapRows();</script>
            <select name=".CPROP.%value systemName%">
            %loop resourceDomain%
	    		%comment%-- start trax# 1-15I4ET --%endcomment%
	            <option width=300 value="%value resourceDomain%" %ifvar resourceDomain vequals(defaultValue)%selected="true"%endif%>
	            	%value resourceDomain%
	            </option>
    			%comment%-- end trax# 1-15I4ET --%endcomment%
            %endloop%
            </select></td></tr>
        %else%
            %ifvar systemName equals(queueName)%
	        <script>writeTD('row');</script>
		
       
		<input class="action1"  type="button" value=" Find Queues " onclick="findQueues(document.forms[0]);"/>
					   &nbsp;&nbsp;&nbsp;%value displayName%</td>   
	        <script>writeTD('rowdata-l');swapRows();</script>
        	<input type="hidden" name="connectionAlias" value="%value ../connectionAlias%"></input>
		%invoke wm.mqseries.admin:findQueues%
		%onerror%       
		  <FONT color="red"><B>
		  Unable to obtain Queue Names:<BR>
		  %ifvar localizedMessage%%value localizedMessage%%endif% - 
		  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT>
		%endinvoke%
		%ifvar queues%
	 	<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
 		    <select multiple name="availableQueues" onChange="selectQueues(document.forms[0]);return false">
		        %loop queues%
			    <option value="%value queuename%" %ifvar selected equals(yes)%selected%endif%>
				           %value queuename%
			    </option>
		        %endloop%
		    </select>
		    </td></tr>
		%else%
			<input type="hidden" name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
			<div id="myDiv">
	            <input size=60 name=".CPROP.%value -urlencode systemName%" 
				   value="%value defaultValue%" onChange="newQueues(document.forms[0]);return false"></input>
				   </div></td></tr>
		%endif%
    	    %else%
    	        <script>writeTD('row');</script>
	        %value displayName%</td>                     
                <script>writeTD('rowdata-l');swapRows();</script>
                <input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td></tr>	    
	    %endif%
        %endif%        
    %endif%        
    %endif%        
  %endif%
  %endif%
   %endif%
    %endif%
	 %endif%
	  %endif%
%endloop%
%endif%
</body>