
<FORM ACTION="rn-export.dsp" METHOD="POST">
	%ifvar nsNameList -notempty%
		<TABLE WIDTH="75%">
			%invoke wm.estd.rosettaNet.expt:getPipRecords%
				%rename PIPInfo Items%
				%rename nsNameList toExtract -copy%
				%invoke wm.estd.rosettaNet.expt:extractFromArray%
					%loop NewList%
						<TR>
							<TD COLSPAN="6" CLASS="heading"><b>%value interfaceName%</b></TD>
						</TR>
						%loop contents%
							<TR> 
								<TD COLSPAN="2" CLASS="subheading"><b>%value%</b></TD></TR>

							<TR> 
								<TD CLASS="subheading" WIDTH="15%">Is&nbsp;Action</TD>
								<TD CLASS="rowdata">
									<INPUT TYPE = "CHECKBOX" name = "used" value="%value%">
								</TD>
							</tr>
							<TR>
								<TD CLASS="subheading" WIDTH="15%">Action</TD>
								<TD CLASS="rowdata"><INPUT TYPE="TEXT" NAME="%value%_action"></TD>
							</TR>
								<TD CLASS="subheading" WIDTH="15%">DTD</TD>
								<TD CLASS="rowdata"><INPUT TYPE="TEXT" NAME="%value%_dtd"></TD>
							</TR>
							%loopsep '<TR><TD CLASS="rowdata" COLSPAN="2"></TD></TH>'%
						%endloop% 
						%loopsep '<TR><TD COLSPAN="2"><HR></TD></TH>'%
					%endloop%
				%endinvoke%

			%endinvoke%
		</TABLE>
	%else%
	%endif%

	<INPUT TYPE="HIDDEN" NAME="action" VALUE="export">
	<INPUT TYPE="HIDDEN" NAME="FileName" VALUE="%value FileName%">
	<INPUT TYPE="HIDDEN" NAME="PIPName" VALUE="%value PIPName%">
	<INPUT TYPE="HIDDEN" NAME="PIPNumber" VALUE="%value PIPNumber%">
	<INPUT TYPE="HIDDEN" NAME="PIPVersion" VALUE="%value PIPVersion%">
	%ifvar nsNameList%
		%loop nsNameList%
			<INPUT TYPE="HIDDEN" NAME="nsName" VALUE="%value%">
		%endloop%
	%endif%
	%ifvar docTypeNameList%
		%loop docTypeNameList%
			<INPUT TYPE="HIDDEN" NAME="docTypeName" VALUE="%value%">
		%endloop%
	%endif%
	%ifvar scriptNameList%
		%loop scriptNameList%
			<INPUT TYPE="HIDDEN" NAME="scriptName" VALUE="%value%">
		%endloop%
	%endif%
	<INPUT TYPE="submit">
</FORM>
