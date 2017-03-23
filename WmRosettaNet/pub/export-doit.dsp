		<TABLE WIDTH="75%">
			<TR><TH CLASS="title">Export Results</TH></TR>
			%invoke wm.estd.rosettaNet.expt:doExport%
				%ifvar Errors -notempty%
					<TR><TD CLASS="rowdata">Export file not created due to the following errors:</TD></TR>
					%loop Errors%
						<TR><TD CLASS="rowdata">%value% </TD></TR>
					%loopsep '<BR>'%
					%endloop%
				%else%
					<TR><TD CLASS="rowdata">Export Successful</TD></TR>
				%endif%
			%onerror%
				<TR><TD id="message"> %value errorMessage%</td></TR>
			%endinvoke%
		</TABLE>

