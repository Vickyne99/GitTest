<table width="100%">  
	<tr>
	   <td class="menusection-Adapters" colspan=7>HL7 Module &gt; MLLP Connections &gt; Configure Connection Type</td>
	</tr>
  
	<tr>
		<td colspan=2>
			<ul>
	%comment%----- LG TRAX 1-KX9WM Added dspName=.LISTCONNECTIONTYPES -----%endcomment%
				<li><a href="/WmHL7/mllp/ListAdapterConnTypes.dsp?adapterTypeName=%value -urlencode adapterTypeName%&dspName=.LISTCONNECTIONTYPES">Return to MLLP Connections</a>
			</ul>
		</td>
	</tr>
   
	%comment%----------------------ConnectionProperties--------------%endcomment%     
	%invoke wm.art.admin.connection:getConnectionProperties%
		<tr>
			<td class="heading" colspan=2>Configure Connection Type &gt; MLLP Connections</td>
		</tr>
		
		%comment%----- Displays connection type parameters -----%endcomment%
		%comment%----- LG TRAX 1-MHXZY -----%endcomment%
		%comment%----- Move occurrances of swaprows() to make alternate -----%endcomment%
		%comment%----- display lines in form have alternating colors -----%endcomment%
	%ifvar parameters%
		<script>resetRows();</script>
		<script>setNavigation('ListAdapterConnTypes.dsp', '%value TemplateURL%', 'foo');</script>

		<tr>
		%include GetISPackages.dsp%
			<script>swapRows();writeTD('row');</script>Folder Name</td>
			<script>writeTD('rowdata-l');</script>
			<input size=30 name="resourceFolderName" value="%value -urlencode resourceFolderName%"></input></td>
		</tr>

		<tr>
			<script>swapRows();writeTD('row');</script>Connection Name</td>
			<script>writeTD('rowdata-l');</script>
			<input size=30 name="resourceName" value="%value -urlencode resourceName%"></input></td>
		</tr>

		<tr><td class="heading" colspan=2>Connection Properties</td></tr>
		
		<tr>
			<script>writeTD('row');</script>Connection Type</td>
			<script>writeTD('rowdata-l');swapRows();</script>
				<select name=".CPROP.connectionType" id=".CPROP.connectionType" onChange="handleConnectionTypeChange(this.form)">
				  <option width=300 value="Transient">Transient</option>
				  <option width=300 value="Permanent">Permanent</option>
				</select>
				</input></td>
		</tr>
			%loop parameters%
				%comment%-- start trax# 1-122V6J --%endcomment%
				%ifvar isHidden%
				%comment%-- set a hidden value --%endcomment%
				<input type=hidden name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"> </input>
				%else%
				%comment%-- end trax# 1-122V6J --%endcomment%
				
					<tr>
						<script>writeTD('row');</script>%value displayName%</td>
			 
						%ifvar isPassword%
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
								   value="">
							</input></td></tr>
			
							<script>writeTD('row');</script>Retype %value displayName%</td>
							<script>writeTD('rowdata-l'); swapRows();</script>
					%comment%----- LG TRAX 1-BKBFM -----%endcomment%
					%comment%----- Change Retype field from "******" to "" -----%endcomment%
							<input size=60
								   type=password
								   name="PWD.CPROP.%value -urlencode systemName%"
								   value=""></input></td></tr>
						%else%
							<script>writeTD('rowdata-l'); swapRows();</script>
								%ifvar resourceDomain -notEmpty%
									<select name=".CPROP.%value systemName%">
										%loop resourceDomain%
											<option width=300 value="%value resourceDomain%">%value resourceDomain%</option>
										%endloop%
									</select>
								%else%
									<input size=60 name=".CPROP.%value -urlencode systemName%" value="%value defaultValue%"></input>
								%endif%
							</td>
						%endif%
					</tr>
				%endif%
			%endloop%
		%endif%

		%onerror%
			<tr>
				<td class="heading" colspan=2>Configure Connection Type</td>
			</tr>
			  %ifvar localizedMessage%
				%comment%-- Localized error message supplied --%endcomment%
				<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
			  %else%
				%ifvar error%
				  <tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
				%endif%
			  %endif%
		%endinvoke%

		<tr>
			%comment%----------------------ConnectionManagerProperties--------------%endcomment%  
			%invoke wm.art.admin.connection:getConnectionManagerProperties% 
				
				%comment%------ Display connection parameters ------%endcomment%

			%ifvar connectionManagerProperties%
				<script>resetRows();</script>
				<tr><td class="heading" colspan=2>Connection Management Properties</td></tr>
				%loop connectionManagerProperties%
					
						%ifvar parameterType equals('Boolean')%
							<select name=".CMGRPROP.%value -urlencode systemName%" id=".CMGRPROP.%value -urlencode systemName%" %ifvar systemName equals('poolable')% style="display:none;" onChange="handlePoolableChange(this.form);"%endif%>
							<option value="true"  %ifvar value equals('true')%selected="true"%endif%>true</item>
							<option value="false" %ifvar value equals('false')%selected="true"%endif%>false</item>
							</select>
						%else%
							<tr>
							<script>writeTD('row');</script>
							%value displayName%</td>
							<script>writeTD('rowdata-l');swapRows();</script>
							<input size=60 name=".CMGRPROP.%value -urlencode systemName%" id=".CMGRPROP.%value -urlencode systemName%" value="%value defaultValue%"></input></td>  
						%endif%
					</tr>
				%endloop%
			%else%
				<tr><td class="message">Connection Management properties not found.</td></tr>
			%endif%
				
			%onerror%
				%ifvar localizedMessage%
					%comment%-- Localized error message supplied --%endcomment%
					<tr><td class="message">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
				%else%
					%ifvar error%
						<tr><td class="message">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
					%endif%
				%endif%
			%endinvoke%  
</table>
    