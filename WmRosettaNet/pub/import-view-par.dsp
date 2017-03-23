<FORM NAME="importForm" ACTION="rn-import-par.dsp" METHOD="POST">
<INPUT TYPE="HIDDEN" NAME="action" VALUE="import">
<TABLE WIDTH="75%">
  %invoke wm.estd.rosettaNet.impt:readManifests%
		%ifvar ArchiveInfo%
			<TR>
			    <TH COLSPAN=2 CLASS="title">PIP Import File Details</TH>
			</TR>
			%loop ArchiveInfo%
				<TR> 
					<TH COLSPAN=2 CLASS="heading">Archive&nbsp;File&nbsp;Name&nbsp;%value FileName%</TH>
				</TR>
				%ifvar isError equals('true')%
					<TR> 
						<TH WIDTH="20%" CLASS="rowlabel">Error Importing Archive</TH>
						<TD CLASS="rowdata">%value errorMsg%</TD>
					</TR>
				%else%
					<TR> 
						<TH WIDTH="20%" CLASS="rowlabel">PIP Name</TH>
						<TD CLASS="rowdata">%value ProcessName%</TD>
					</TR>
					<TR> 
						<TH WIDTH="20%" CLASS="rowlabel">PIP Number</TH>
						<TD CLASS="rowdata">%value ProcessNumber%</TD>
					</TR>
					<TR> 
						<TH WIDTH="20%" CLASS="rowlabel">PIP Version</TH>
						<TD CLASS="rowdata">%value ProcessVersion%</TD>
					</TR>
					<TR> 
						<TH WIDTH="20%" CLASS="rowlabel">Archive Revision</TH>
						<TD CLASS="rowdata">%value ArchiveDetails/ArchiveRevision%</TD>
					</TR>
					
					<TR> 
						<TH COLSPAN="2" CLASS="subheading">Archive Contents</TH>
					</TR>
					%ifvar manifest%
						%loop manifest%
							<TR><TD COLSPAN="2" CLASS="rowdata">
								%ifvar exists equals('true')% <FONT COLOR="RED"><B>!</B></FONT> %endif%
								%value Manifest_Message%
								</TD>
							</TR>
						%endloop%
					%else%
						<TD COLSPAN="2" CLASS="rowdata">This archive contains no items to 
import</TD>
					%endif%
					<INPUT TYPE="hidden" NAME="file" VALUE="%value FileName%">
				%endif%
				%loopsep '<TR><TD COLSPAN=2><hr></TD></TR>'%
			%endloop%
			<TR><TD COLSPAN="2">
				<FONT COLOR="RED"><B>!</B></FONT> indicates an item that already exists on 
				the server and will be overwritten
			</TD></TR>
				
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
			<TH COLSPAN=2 CLASS="heading">PIP Import File Details</TH>
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
