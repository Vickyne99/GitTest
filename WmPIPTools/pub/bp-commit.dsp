	<TABLE WIDTH="85%">
	%invoke wm.ip.rn.pip:buildPIP%
			<TR>
				<TD CLASS="message">PIP Successfully Commited</TD>
			</TR>
	%onerror%
				<TR><TD class="message" id="message">Error: %value errorMessage%</TD></TR>
	%endinvoke%

			</TABLE>