%comment%----- LG TRAX 1-MHXP3 -----%endcomment%
%comment%----- New DSP for Connection COPY ONLY -----%endcomment%
%comment%----- New for Elbe Release -----%endcomment%
%ifvar parameters%
    <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>
	<SCRIPT language="JavaScript" src="mqconnjs.txt"></SCRIPT>
    <tr class="subheading3">
	<td colspan=2> Connection Copy Properties </td>
	</tr>
    
    %comment%-- Copy Edit mode --%endcomment%
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
					<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore file"  onclick="showKeystoreFileParams();">keystore file</input>
					<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore alias" checked onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
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
					<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore file" checked onclick="showKeystoreFileParams();">keystore file</input>
					<input type="radio" name=".CPROP.%value -urlencode systemName%" value="keystore alias"  onclick="showKeystoreAliasParams();">keystore alias</input></td></tr>
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
				<a onclick="alert('Set the system property com.ibm.mq.cfg.useIBMCipherMappings to true for SSL Cipher Spec or false for TLS Cipher Spec. The default value is true')">Help</a>
				</td></tr>
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
				<input id ="sslKeyStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
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
				<input id="sslTrustStoreAlias" size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
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
		    <script>writeTDspan('row');</script>%value displayName%</td>
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
			<script>writeTDspan('rowdata-l'); swapRows();</script>
			    %ifvar resourceDomain -notEmpty%
				<select name=".CPROP.%value systemName%">
				    %loop resourceDomain%
					<option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
				    %endloop%
				</select>
			    %else%
				<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
			    %endif%
			</td></tr>
		    %endif%
		    %endif%
		    %endif%
		    %endif%
		</tr>
        %endif%
	%endif%
	%endif%
	%endif%	
    %endloop%
%else%
    <tr><td class="message" colspan=4>Connection Copy Properties Not Found</td></tr>
%endif%
