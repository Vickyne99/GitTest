<TABLE WIDTH="75%">
	<TR><TH COLSPAN="2" CLASS="title">View Entry</TH></TR>
	%invoke wm.ip.dictionary:getEntry%
		<TR>
			<TD WIDTH="20%" CLASS="rowlabel"><B>Entry Name(s):</B></TD>
			<TD CLASS="rowdata">%loop Entry/ref%%value %%loopsep '<BR>'%%endloop%</TD>
		</TR>
		%ifvar Entry/RegExKey%
			<TR>
				<TD WIDTH="20%" CLASS="rowlabel"><B>Regular Expression:</B></TD>
				<TD CLASS="rowdata">%value Entry/RegExKey%</TD>
			</TR>
		%endif%
		%ifvar Entry/EntriesKey%
			<TR>
				<TD WIDTH="20%" CLASS="rowlabel"><B>Choice(s):</B></TD>
				<TD CLASS="rowdata">%loop Entry/EntriesKey%%value %%loopsep '<BR>'%%endloop%</TD>
			</TR>
		%endif%
	<TR><TD COLSPAN="2" CLASS="rowlabel">%include dict-navbar.dsp%</TD></TR>
			
	%endinvoke%

</TABLE>
