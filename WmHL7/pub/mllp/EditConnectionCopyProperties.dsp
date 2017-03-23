%comment%----- LG TRAX 1-MHXP3 -----%endcomment%
%comment%----- New DSP for Connection COPY ONLY -----%endcomment%
%comment%----- New for Elbe Release -----%endcomment%
%ifvar parameters%
    <script>setNavigation('ListResources.dsp', '%value TemplateURL%', 'foo');</script>
    
    <tr><td colspan=2 class="heading">Connection Copy Properties</td></tr>
    
    %comment%-- Copy Edit mode --%endcomment%
	
	%loop connectionManagerProperties%        
				%ifvar parameterType equals('Boolean')%
					%ifvar value equals('true')%
						<tr>
						<script>writeTDspan('row');</script>Connection Type</td>
						<script>writeTDspan('rowdata-l');swapRows();</script>     
						<select name=".CPROP.connectionType" id=".CPROP.connectionType" onChange="handleConnectionTypeChange(this.form)">
							  <option width=300 value="Permanent">Permanent</option>
							  <option width=300 value="Transient">Transient</option>
						</select></td>
						</tr>
					%else%
						<tr>
						<script>writeTDspan('row');</script>Connection Type</td>
						<script>writeTDspan('rowdata-l');swapRows();</script>     
						<select name=".CPROP.connectionType" id=".CPROP.connectionType" onChange="handleConnectionTypeChange(this.form)">
							  <option width=300 value="Transient">Transient</option>
							  <option width=300 value="Permanent">Permanent</option>
						</select></td>
						</tr>
					%endif%
				%endif%				
	%endloop%
	
    %loop parameters%          
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
	                        <select id=".CPROP.%value systemName%" name=".CPROP.%value systemName%" onChange="handleConnectionTypeChange(this.form)">
	                            %loop resourceDomain%
	                                <option value="%value resourceDomain%" %ifvar resourceDomain vequals(value)%selected="true"%endif%>%value resourceDomain%</option>
	                            %endloop%
	                        </select>
	                    %else%
	                        <input size=60 id=".CPROP.%value -urlencode systemName%"  name=".CPROP.%value -urlencode systemName%" value="%value value%"></input>
	                    %endif%
	                </td></tr>
	            %endif%
	        </tr>
		%endif%
    %endloop%
%else%
    <tr><td class="message" colspan=4>Connection Copy Properties Not Found</td></tr>
%endif%
