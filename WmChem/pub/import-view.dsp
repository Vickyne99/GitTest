<FORM NAME="importForm" ACTION="chem-import.dsp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="action" VALUE="import">
<TABLE WIDTH="75%">
  %invoke wm.estd.chemical.impt:readManifests%
  		%comment%
		<TR> 
			<TH CLASS="rowlabel">Debug Info</TH>
			<TD CLASS="rowdata"> %loop -struct% Key='%value $key%' Value='%value%'<br>
%endloop%</TD>
		</TR>
		%endcomment%
		%ifvar ArchiveInfo%
			%loop ArchiveInfo%
				<TR>
				    <TH COLSPAN=2 CLASS="heading">Transaction Import File Details</TH>
				</TR>
				<TR> 
					<TH WIDTH="25%" CLASS="subheading">Archive&nbsp;File&nbsp;Name</TH> 
					<TD CLASS="rowdata">%value FileName%</TD>
				</TR>
				%comment%
				<TR> 
					<TH CLASS="rowlabel">Debug Info</TH>
					<TD CLASS="rowdata"> %loop -struct% Key='%value $key%' Value='%value%'<br>
%endloop%</TD>
				</TR>
				%endcomment%
				%ifvar isError equals('true')%
					<TR> 
						<TH CLASS="rowlabel">Error Importing Archive</TH>
						<TD CLASS="rowdata">%value errorMsg%</TD>
					</TR>
				%else%
					<TR> 
						<TH CLASS="rowlabel">Transaction Name</TH>
						<TD CLASS="rowdata">%value ProcessName%</TD>
					</TR>
					<TR> 
						<TH CLASS="rowlabel">Transaction Number</TH>
						<TD CLASS="rowdata">%value ProcessNumber%</TD>
					</TR>
					<TR> 
						<TH CLASS="rowlabel">Transaction Version</TH>
						<TD CLASS="rowdata">%value ProcessVersion%</TD>
					</TR>
					<TR> 
						<TH COLSPAN="2" CLASS="subheading">Archive Contents</TH>
					</TR>
					%ifvar manifest%
						%loop manifest%
							<TR><TD COLSPAN="2" CLASS="rowdata">
								%ifvar exists equals('true')% <FONT COLOR="RED"><B>!</B></FONT> %endif%
							%comment%
								<INPUT TYPE="CHECKBOX" NAME="%value FileName%" VALUE="%value 
entryName%">
							%endcomment%
								%value Manifest_Message%
								</TD>
							</TR>
						%endloop%
						<TR><TD COLSPAN="2"><FONT COLOR="RED"><B>!</B></FONT> indicates an item 
that already exists on the server and will be overwritten</TD></TR>
					%else%
						<TD COLSPAN="2" CLASS="rowdata">This archive contains no items to 
import</TD>
					%endif%
					<INPUT TYPE="hidden" NAME="file" VALUE="%value FileName%">
				%endif%
				%loopsep '<TR><TD COLSPAN=2><hr></TD></TR>'%
			%endloop%
				
			%ifvar hasError equals('true')%
				<TR><TD>&nbsp;</TD></TR>
				<TR>
					<TD COLSPAN="2" CLASS="rowdata">Please go back and unselect the archives 
that contain errors to continue</TD>
				</TR>
			%else%
				<TR><TD COLSPAN="2">
					<INPUT TYPE="SUBMIT" VALUE="Import Archives">
				</TD></TR>
			%endif%
		%else%
			<TR>
			<TH COLSPAN=2 CLASS="heading">Transaction Import File Details</TH>
			</TR>
			<TR>
			<TD COLSPAN=2 CLASS="rowdata">No files were selected</TD>
			</TR>
		%endif%
	%onerror%
		<TR><TD>Got Error:%value error%<TD>
			<TD>Message= %value errorMessage%</TD></TR>
		<TR><TD>Input= <TD>
			<TD>%value errorInput%</TD></TR>
		<TR><TD>Output= <TD>
			<TD>%value errorOutput%</TD></TR>
	%endinvoke%
</FORM>
</TABLE>
