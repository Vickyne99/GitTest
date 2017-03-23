
<TABLE WIDTH="75%">
<TR  CLASS="title"> <TH>Modular PIP Import</TH> </TR>
  %invoke wm.ip.rn.nextgen:buildPIP%

	%loop results%
		<TR>
		<TH CLASS="heading">%value fileName%</TH>
		%ifvar success equals('true')%
			<TR>
				<TD CLASS="rowdata">Successfully Imported</TD>
			</TR>
		%else%
				<TR> 
					<TH CLASS="rowdata">Error importing: %value errorMessage%</TH> 
				</TR>
					<TR><TD><TABLE width="100%">
					<TR>
						<TH CLASS="subheading">Entry Name</TH>
						<TH CLASS="subheading">Entry Result</TH>
					</TR>
				%loop entries%
					<TR>
						<TD CLASS="rowdata">%value Name%</TD>  
						<TD CLASS="rowdata">
							%ifvar success equals('true')%
								Successfully imported 
							%else%
								%value errorMessage%
							%endif%
						</TD>
					</TR>
				%endloop%
					</TABLE></TD></TR>
		%endif%
		</TR>
		%loopsep '<TR><TD><hr></TD></TR>'%
	%endloop%
	%onerror%
		%value error% %value errorMessage%
		<TR><TD id="message">Error: %value errorMessage%</TD></TR>
	%endinvoke%
</TABLE>
