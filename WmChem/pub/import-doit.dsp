
<TABLE WIDTH="75%">
<TR  CLASS="title">
  <TH COLSPAN="2">Transaction Import</TH>
</TR>
	%invoke wm.estd.chemical.impt:doImport%

	%loop results%
		<TR>
		<TD WIDTH="15%" CLASS="subheading">File Name:</TD>
		<TD CLASS="rowdata">%value fileName%</TD>
		%ifvar success equals('true')%
			<TR>
				<TD CLASS="rowlabel">Result</TD>
				<TD CLASS="rowdata">Successfully Imported</TD>
			</TR>
		%else%
				<TR> <TD CLASS="subheading">Error Message:</TD>
						<TD CLASS="rowdata">%value errorMessage%</TD> 
				</TR>
				%loop entries%
					<TR><TD CLASS="rowlabel" COLSPAN=2>&nbsp;<TD></TR>
					<TR>
						<TD CLASS="rowlabel">Entry Name:</TD>
						<TD CLASS="rowdata">%value Name%</TD>  
					</TR>
					<TR>
						<TD CLASS="rowlabel">Entry Result:</TD>
						<TD CLASS="rowdata">
							%ifvar success equals('true')%
								Successfully imported 
							%else%
								%value errorMessage encode(xml)%
							%endif%
						</TD>
					</TR>
				%endloop%
		%endif%
		</TR>
		%loopsep '<TR><TD COLSPAN=2><hr></TD></TR>'%
	%endloop%
	%onerror%
		%value error% %value errorMessage%
		<TR><TD COLSPAN="2">Error!</TD></TR>
		<TR><TD COLSPAN="2">%value error% %value errorMessage%</TD></TR>
	%endinvoke%
</TABLE>
