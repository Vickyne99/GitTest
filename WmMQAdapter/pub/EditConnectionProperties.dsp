%comment%----- Edit connection node -----%endcomment%

%ifvar parameters%
<script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>

<SCRIPT language="JavaScript" src="mqconnjs.txt"></SCRIPT>

<TR class="subheading3">
    <TD colspan=2  >Connection Properties</TD>
</TR>     

%ifvar readOnly equals('true')%

%invoke wm.mqseries.admin:cacheConnectionFactoryProperties%
%onerror%       
  <tr class="message"><FONT color="red"><B>
  Unable to cache the ConnectionFactory properties:<BR>
  %ifvar localizedMessage%%value localizedMessage%%endif% - 
  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT></tr>
%endinvoke%

%invoke wm.mqseries.admin:reloadConnectionFactoryProperties%
%onerror%       
  <tr class="message"><FONT color="red"><B>
  Unable to reload ConnectionFactory properties:<BR>
  %ifvar localizedMessage%%value localizedMessage%%endif% - 
  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT></tr>
%endinvoke%

%invoke wm.art.admin:htmlEncodeConnProps%
%loop parameters%          
%comment%---------------------------------------------------------------------------------------------------------------- 

SSL Support 

If the watt.WmMQAdapter.SSL.Support property is set to 'true', these 3 properties will be displayed. 

Since this DSP cannot evaluate the watt.WmMQAdapter.SSL.Support property, it must use some other indicator. Unfortunately,
the groupName property, set by the wmMQConnection class, is also not available. So, assuming that these properties are 
required when creating the connection object, these properties will be displayed only if they are not null. 
--------------------------------------------------------------------------------------------------------------%endcomment%
%ifvar systemName equals(sslOptions)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%else%
				%ifvar sslEnabled equals(false)%
					<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
				  %else%
					<script>writeTDspan('row');</script>
					%value displayName%</td>              
						<script>writeTDspan('rowdata-l');swapRows();</script>
						%ifvar value equals('keystore alias')%
						  %value value%
						%else%  
						  %ifvar value equals('new')%
						    keystore alias
						  %else%
						    keystore file
						  %endif%
						%endif%  
						 </td></tr>
				%endif%
				  %else%
					<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
				%endif%
		%endif%
      %else%
	  %ifvar systemName equals(sslKeyStoreAlias)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar sslEnabled equals(false)%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			  %else%
				<script>writeTDspan('row');</script>
				%value displayName%</td>              
					<script>writeTDspan('rowdata-l');swapRows();</script>
					%value value%</td></tr>
			%endif%
			  %else%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%endif%
      %else%
	  %ifvar systemName equals(sslTrustStoreAlias)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar sslEnabled equals(false)%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			  %else%
				<script>writeTDspan('row');</script>
				%value displayName%</td>              
					<script>writeTDspan('rowdata-l');swapRows();</script>
					%value value%</td></tr>
			%endif%
			  %else%
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			%endif%
		%endif%
      %else%
  	%ifvar systemName equals(sslKeyStore)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%ifvar sslEnabled equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %else%
		    <script>writeTDspan('row');</script>
		    %value displayName%</td>              
         	    <script>writeTDspan('rowdata-l');swapRows();</script>
         	    %value value%</td></tr>
	  	%endif%
	      %else%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	  	%endif%
      %else%
  	  %ifvar systemName equals(sslKeyStorePassword)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%ifvar sslEnabled equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %else%
    	          		<script>writeTD('row');</script>
	          		%value displayName%</td>                     
                  	<script>writeTD('rowdata-l');swapRows();</script></td></tr>
	  	  %endif%
	      %else%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	  	  %endif%
      %else%
  	    %ifvar systemName equals(sslCipherSpec)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%ifvar sslEnabled equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %else%
		%ifvar value -notNull)%
		    <script>writeTDspan('row');</script>
		    %value displayName%</td>              
         	    <script>writeTDspan('rowdata-l');swapRows();</script>
         	    %value value%</td></tr>
	  	  %endif%
	      %else%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
   	      %endif%
	%else%
%comment%------- End of SSL Support --------------------------------------------------------------------------%endcomment%
			
%comment%-- start trax# 1-122V6J --%endcomment%
%ifvar isHidden%
	%comment%-- set a hidden value --%endcomment%
	<input type=hidden name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
%else%
%comment%-- end trax# 1-122V6J --%endcomment%

	<tr>
		<script>writeTDspan('row');</script>%value displayName%</td>              
		<script>writeTDspan('rowdata-l');</script>
			%ifvar isPassword%
			%else%
				%comment%----- TRAX 1-KPWS1 -----%endcomment%
				%value value%
			%endif%
		</td>
		<script>swapRows();</script>
	</tr>
    %endif%
    %endif%
    %endif%
    %endif%
	 %endif%
	  %endif%
	   %endif%
%endloop%
%onerror%
	<script> alert("Error invoking htmlEncode");</script>
%endinvoke%
%else%
%comment%-- edit mode --%endcomment%
%comment%--------------------
*************************<br>
%loop -struct%
  %value $key% = %value% <br>
%endloop%
*************************<br>
-----------------%endcomment%

%invoke wm.mqseries.admin:cacheConnectionFactoryProperties%
%onerror%       
 <tr class="message"> <FONT color="red"><B>
  Unable to cache the ConnectionFactory properties:<BR>
  %ifvar localizedMessage%%value localizedMessage%%endif% - 
  %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT></tr>
%endinvoke%

%loop parameters% 
%comment%---------------------------------------------------------------------------------------------------------------- 

SSL Support 

If the watt.WmMQAdapter.SSL.Support property is set to 'true', these 3 properties will be displayed. 

Since this DSP cannot evaluate the watt.WmMQAdapter.SSL.Support property, it must use some other indicator. Unfortunately,
the groupName property, set by the wmMQConnection class, is also not available. So, assuming that these properties are 
required when creating the connection object, these properties will be displayed only if they are not null. 
--------------------------------------------------------------------------------------------------------------%endcomment%
	%ifvar systemName equals(sslOptions)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar sslEnabled equals(false)% 
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
			 %else% 
				<tr> <script>writeTD('row');</script> SSL Option </td><script>writeTD('rowdata-l');swapRows();</script>
				%ifvar value equals('keystore alias')%
					<script> sslOption = "keystore alias";</script>
					<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore file"  onclick="showKeystoreFileParams();">keystore file</input>
					<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore alias" checked onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
				%else%
				  %comment% ----------------------------------
				  Added to handle Fix 22 effects, can be removed after fix 24
				  %endcomment%
					%ifvar value equals('new')%
						<script> sslOption = "keystore alias";</script>
						<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore file"  onclick="showKeystoreFileParams();">keystore file</input>
						<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore alias" checked onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
					%else%
					<script> sslOption = "keystore file";</script>
					<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore file" checked onclick="showKeystoreFileParams();">keystore file</input>
					<input type="radio"  name=".CPROP.%value -urlencode systemName%" value="keystore alias"  onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
					%endif%
				%endif%
			%endif%
		%endif%
	%else%
  	%ifvar systemName equals(sslKeyStore)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<script type="text/javascript">sslOption ="keystore file";</script>
		%endif%
		%ifvar sslEnabled equals(false)% 
				<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		      %else%
    	      	    <tr> <script>writeTD('row');</script>
		            %value displayName%</td>                     
      	            <script>writeTD('rowdata-l');swapRows();</script>
				  <input id="sslKeyStore"  size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
				  <script type="text/javascript">
					useSSlFilepath('sslKeyStore');</script>
				  </td></tr>	    
	  	%endif%
      %else%
  	  %ifvar systemName equals(sslKeyStorePassword)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<script type="text/javascript">sslOption ="keystore file";</script>
		%endif%
		%ifvar sslEnabled equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %else%
    	          		<script>writeTD('row');</script>
	          		%value displayName%</td>                     
                  	<script>writeTD('rowdata-l');swapRows();</script>
				<input type="password" id="sslKeyStorePassword" size=60 name=".CPROP.%value -urlencode systemName%" value="" 
				onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input>
				<script type="text/javascript">
						useSSlFilepath('sslKeyStorePassword','pass');</script>
				</td></tr>	    
	                <tr><script>writeTD('row');</script>Retype %value displayName%</td>
	                <script>writeTD('rowdata-l'); swapRows();</script>
				<input type="password" id="retypeSslKeyStorePassword" size=60 name="PWD.CPROP.%value -urlencode systemName%" value=""></input>
				<script type="text/javascript">
					useSSlFilepath('retypeSslKeyStorePassword','pass');</script>
				</td></tr>
	  	%endif%
      %else%
  	    %ifvar systemName equals(sslCipherSpec)%
		%ifvar value -notNull)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%ifvar sslEnabled equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %else%
	    		<script>writeTD('row');</script>
		      %value displayName%</td>                     
	            <script>writeTD('rowdata-l');swapRows();</script>
      	      <select name=".CPROP.%value systemName%" width="300">
					<option value=""></option>%value resourceDomain%
            	%loop resourceDomain%
		            <option width=300 value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
            	%endloop%
	            </select> 
				&nbsp;<a onclick="alert('Set the system property com.ibm.mq.cfg.useIBMCipherMappings to true for SSL Cipher Spec or false for TLS Cipher Spec. The default value is true')">Help</a></td></tr>
	  	%endif%
	      %else%
			<INPUT type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
	      %endif%
	%else%
	%ifvar systemName equals(sslKeyStoreAlias)% 	
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar sslEnabled equals(false)%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">	
			%else%
				<tr > <script>writeTD('row');</script>
				%value displayName%</td>                     
				<script>writeTD('rowdata-l');swapRows();</script>
				<input  id ="sslKeyStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
				<script type="text/javascript">
						useSSlalias('sslKeyStoreAlias');</script>
				</td></tr>
			%endif%
		%endif%
	      %else%
		%ifvar systemName equals(sslTrustStoreAlias)%
		%invoke wm.mqseries.admin:getSSLProperty% 
		%endinvoke%
		%invoke wm.mqseries.admin:sslAliasSupported% 
		%endinvoke%
		%ifvar sslAliasSupported equals(false)%
			<input type = "hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">
		%else%
			%ifvar sslEnabled equals(false)%
				<input type="hidden"   name=".CPROP.%value -urlencode systemName%"    value = " ">	    
			%else%
				<tr  > <script>writeTD('row');</script>
				%value displayName%</td>                     
				<script>writeTD('rowdata-l');swapRows();</script>
				<input  id="sslTrustStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
				<script type="text/javascript">
						useSSlalias('sslTrustStoreAlias');</script>
				</td></tr>	
				
			%endif%
	      %endif%
	%else%
%comment%------- End of SSL Support --------------------------------------------------------------------------%endcomment%

%comment%-- start trax# 1-122V6J --%endcomment%
%ifvar isHidden%
	%comment%-- set a hidden value --%endcomment%
	<input type=hidden name=".CPROP.%value -urlencode systemName%" value="%value value%"> </input>
%else%
%comment%-- end trax# 1-122V6J --%endcomment%

    <tr>
       <script>writeTDspan('row');</script>
       %value displayName%</td>               
       %ifvar isPassword%
               <script>writeTDspan('rowdata-l'); swapRows();</script>
		    %comment%----- LG TRAX 1-I49V9 -----%endcomment%
		    %comment%----- Added second argument to passwordChange() function -----%endcomment%
		    %comment%----- to support artconnjs.txt for multiple password fields -----%endcomment%
                    <input size=60
                               type=password
                               name=".CPROP.%value -urlencode systemName%"
                               value=""
                               onchange= "return passwordChanged(this.form, '%value -urlencode systemName%')"></input></td></tr>
                <script>writeTD('row');</script>Retype %value displayName%</td>
                <script>writeTD('rowdata-l'); swapRows();</script>
                <input size=60 type=password name="PWD.CPROP.%value -urlencode systemName%" value=""></input></td>
       %else%
           <script>writeTDspan('rowdata-l');swapRows();</script>       
      	   %ifvar resourceDomain -notEmpty%
               	<select name=".CPROP.%value systemName%">
	       	%loop resourceDomain%
                    <option value="%value resourceDomain%" 
		   	%ifvar resourceDomain vequals(value)%selected="true"%endif%>
		     	%value resourceDomain%
		    </option>
	       	%endloop%
		</select></td>
	   %else%
		<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%" 		onChange="qMgrChanges(this)"></input></td></tr>
       	       %ifvar systemName equals(queueName)%
		    %invoke wm.mqseries.admin:findQueues%
	      	    %onerror%       
		      <tr class="message"><FONT color="red"><B>
		      Unable to obtain Queue Names:<BR>
		      %ifvar localizedMessage%%value localizedMessage%%endif% - 
		      %ifvar errorMessage%%value errorMessage%%endif%<BR></B></FONT></tr>
		    %endinvoke%
		    <script>writeTDspan('row');</script>
       		    Available Queues</td>               
	            <script>writeTDspan('rowdata-l');swapRows();</script>       
  		    %ifvar queues%
		        <select multiple name="availableQueues" onChange="selectQueues(document.forms[0]);return false">
		      	    %loop queues%
			          <option value="%value queuename%" %ifvar selected equals(yes)%selected%endif%>
					%value queuename%
			          </option>
	      		    %endloop%
	      	        </select>
		    %else%
			<FONT color="red">
			      <B>The list of Available queues could not be retrieved from the Queue Manager</B>
			</FONT>
		    %endif%
		    </td>
       		%endif%
		</tr>
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

%else%
    <TR><TD class="message" colspan=4>Connection properties not found</TD></TR>
%endif%
 
