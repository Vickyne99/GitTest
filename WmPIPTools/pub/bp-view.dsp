<FORM NAME="importForm" ACTION="rn-build.dsp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="formAction" VALUE="commit">
<TABLE WIDTH="85%">
  %invoke wm.ip.rn.pip:previewPIP%
			<TR>
			    <TH COLSPAN=2 CLASS="title">PIP Preview</TH>
			</TR>
			%ifvar isError equals('true')%
				<TR> 
					<TH WIDTH="20%" CLASS="rowlabel">Error Importing Archive</TH>
					<TD CLASS="rowdata">%value errorMsg%</TD>
				</TR>
			%else%
				<TR> 
					<TH WIDTH="20%" CLASS="rowlabel">PIP Name&nbsp;&nbsp;&nbsp;</TH>
					<TD CLASS="rowdata">%value description%</TD>
				</TR>
			<TR> 
				<TH WIDTH="20%" CLASS="rowlabel">PIP Number</TH>
				<TD CLASS="rowdata">%value code%</TD>
			</TR>
		<TR> 
			<TH WIDTH="20%" CLASS="rowlabel">PIP Version</TH>
			<TD CLASS="rowdata">%value version%</TD>
		</TR>					
		<TR COLSPAN="2">
			<TABLE width="85%">	 
			<TH COLSPAN="2" CLASS="subheading">PIP Contents</TH>
			%loop process%
				<TR><TD CLASS="rowlabel">
				%ifvar exists equals('true')%
					<FONT COLOR="RED"><B>!</B></FONT>
				%endif%
				</TD>
				<TD class="rowdata">%value type%: %value name%</TD>
				</TR>
			%endloop%
	%endif%
		<TR><TD COLSPAN="2">
		<FONT COLOR="RED"><B>!</B></FONT> indicates an item that already exists on 
			the server and will be overwritten
		</TD></TR>

		<tr><td colspan="2" class="action"><INPUT TYPE="SUBMIT" VALUE="Build PIP">
</td></tr>				
			</TABLE>
		</TR>

	%ifvar hasError equals('true')%
		<TR><TD>&nbsp;</TD></TR>
		<TR>
		<TD COLSPAN="2" CLASS="rowdata">Please go back and correct any errors</TD>
		</TR>
	%else%
		<TR><TD COLSPAN="2">
			<FORM METHOD="POST" ACTION="bp-view.dsp">
			<input type="hidden" name="description" value="%value description%">
			<input type="hidden" name="code" value="%value code%">
			<input type="hidden" name="version" value="%value version%">
			<input type="hidden" name="transaction" value="%value transaction%">
			<input type="hidden" name="action" value="%value action%">
			<input type="hidden" name="requestDTD" value="%value requestDTD%">
			<input type="hidden" name="fromRole" value="%value fromRole%">
			<input type="hidden" name="toRole" value="%value toRole%">
			<input type="hidden" name="timeToPerform" value="%value timeToPerform%">
			<input type="hidden" name="timeToAckReceipt" value="%value timeToAckReceipt%">
			<input type="hidden" name="retries" value="%value retries%">
			<input type="hidden" name="schemaNodeName" value="%value schemaNodeName%">
			<input type="hidden" name="referenceB2BSchema" value="%value referenceB2BSchema%">
			<input type="hidden" name="hasResponse" value="%value hasResponse%">
			<input type="hidden" name="responseAction" value="%value responseAction%">
			<input type="hidden" name="responseDTD" value="%value responseDTD%">
			<input type="hidden" name="timeToAckResponse" value="%value timeToAckResponse%">
		</TD></TR>
	%endif%
	%onerror%
		%value code%
			<TR><TD>Got Error:%value error%<TD>
			<TD>Message= %value errorMessage%</TD></TR>
		<TR><TD>Input= <TD>
			<TD>%value errorInput%</TD></TR>
		<TR><TD>Output= <TD>
			<TD>%value errorOutput%</TD></TR>
	%endinvoke%
</FORM>
</TABLE>
