%comment%------ Edit connection node ------%endcomment%
%ifvar connectionManagerProperties%
<script>resetRows();</script>

<TR>
   <TD colspan="2" class="heading">Connection Management Properties</TD>
</TR>   
    %ifvar readOnly equals('true')%
        %loop connectionManagerProperties%        
        
			%ifvar parameterType equals('Boolean')%
			%else%
				<tr>
				<script>writeTDspan('row');</script>
				%value displayName%</td>
				<script>writeTDspan('rowdata-l');swapRows();</script>      
				%value value%</td></tr>        
			%endif%
		%endloop%  
    %else%
    %comment%-- edit mode --%endcomment%
      %loop connectionManagerProperties%   
        %ifvar parameterType equals('Boolean')%
          <select id = ".CMGRPROP.%value -urlencode systemName%" name=".CMGRPROP.%value -urlencode systemName%" %ifvar systemName equals('poolable')  %onChange="handlePoolableChange(this.form);"%endif% style="display:none";>
			<option value="true"  %ifvar value equals('true')%selected="true"%endif%>true</option>
			<option value="false" %ifvar value equals('false')%selected="true"%endif%>false</option>
          </select></td></tr>
        %else%
			<tr>
			<script>writeTDspan('row');</script>
			%value displayName%</td>
				<script>writeTDspan('rowdata-l');swapRows();</script>
				<input size=60 id=".CMGRPROP.%value -urlencode systemName%" name=".CMGRPROP.%value -urlencode systemName%" value="%value value%"></input></td></tr>  
        %endif%      
      %endloop%
    %endif%  

%else%
  <TR><TD class="message">Connection Management properties not found.</TD></TR>
%endif%

