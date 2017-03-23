<TABLE WIDTH="75%">
	<TR><TH COLSPAN="2" CLASS="title">Entries in category %value CategoryName%</TH></TR>

	%ifvar Action%
		
		%scope rparam(tmp={})%
			%ifvar Action equals('Delete')%
				%rename DeltaEntryName EntryName -copy%
				<TR><TH COLSPAN="2" id="message">
					%invoke wm.ip.dictionary:deleteEntry%
						Entry %value DeltaEntryName% deleted
					%onerror%
						Error Deleting Entry, %value errorMessage%
					%endinvoke%
				</TH></TR>
			%endif%
			%ifvar Action equals('Add')%
				%rename DeltaEntryNameList EntryNameList -copy%
				<TR><TH COLSPAN="2" id="message">
					%invoke wm.ip.dictionary:createAndAddEntry%
						Entry Added
					%onerror%
						Error Adding Entry, %value errorMessage%
					%endinvoke%
				</TH></TR>
			%endif%
		%endscope%
	%endif%


	<TR><TD COLSPAN="2" CLASS="rowlabel">%include dict-navbar.dsp%</TD></TR>
	%invoke wm.ip.dictionary:listEntries%
		%ifvar EntryNames -notempty%
			%loop EntryNames%
				<TR><TD COLSPAN="2" CLASS="rowdata">
					<A href="javascript:goEntry ('%value %', 'View');">%value %</A>,
					<A href="javascript:deleteEntry ('%value %');">delete</A>
				</TD></TR>
			%endloop%
		%else%
			<TR><TD COLSPAN="2" CLASS="rowdata">No Entries</TD></TR>
		%endif%
	%onerror%
		<TR><TD COLSPAN="2" CLASS="rowdata">Error Listing Entries: %value errorMessage%</TD></TR>
	%endinvoke%
	<TR><TH COLSPAN="2" CLASS="heading">Add New Entry</TH></TR>
	<FORM NAME="AddEntryForm" METHOD="POST" ONSUBMIT="return false">
	<TR>	
		<TD WIDTH="20%" CLASS="rowlabel">
			Entry Name(s)
		</TD>
		<TD CLASS="rowdata">
			<TABLE WIDTH="100%">
				<TR>
					<TD WIDTH="20%" CLASS="rowdata" ROWSPAN="2">
						<SELECT MULTIPLE NAME="DeltaEntryName" SIZE="5">
							<OPTION>This is a place holding option
						</SELECT>
					</TD>
					<TD CLASS="rowdata"><INPUT TYPE="TEXT" NAME="NewEntryName"> <a href="javascript:addEntryName(document.AddEntryForm.DeltaEntryName, document.AddEntryForm.NewEntryName);">Add</A> Entry Name</TD>
				</TR>
				<TR>
					<TD CLASS="rowdata"><a href="javascript:removeEntryName (document.AddEntryForm.DeltaEntryName);">Remove</A> selected name</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD CLASS="rowlabel">Entry Type</TD>
		<TD CLASS="rowdata">&nbsp;<SELECT NAME="EntryType">
				<OPTION VALUE="RegularExpression">Regular Expression</OPTION>
				<OPTION VALUE="MultipleChoice">Multiple Choice</OPTION>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD CLASS="rowlabel">Regular Expression</TD>
		<TD CLASS="rowdata">&nbsp;<INPUT TYPE="TEXT" NAME="RegularExpression"></TD>
	</TR>
	<TR>	
		<TD WIDTH="20%" CLASS="rowlabel">
			Entry Choice(s)
		</TD>
		<TD CLASS="rowdata">
			<TABLE WIDTH="100%">
				<TR>
					<TD WIDTH="20%" CLASS="rowdata" ROWSPAN="2">
						<SELECT MULTIPLE NAME="Choice" SIZE="5">
							<OPTION>This is a place holding option
						</SELECT>
					</TD>
					<TD CLASS="rowdata"><INPUT TYPE="TEXT" NAME="NewChoiceName"> <a href="javascript:addEntryName(document.AddEntryForm.Choice, document.AddEntryForm.NewChoiceName);">Add</A> Choice Name</TD>
				</TR>
				<TR>
					<TD CLASS="rowdata"><a href="javascript:removeEntryName (document.AddEntryForm.Choice);">Remove</A> selected name</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
	<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
	<INPUT TYPE="HIDDEN" NAME="CategoryName" VALUE="%value CategoryName%">
	<INPUT TYPE="HIDDEN" NAME="Action" VALUE="Add">
	<TR><TD COLSPAN="2" CLASS="rowdata">
		<CENTER>
		<INPUT TYPE="BUTTON" VALUE="Add Entry" onclick="addEntry (document.AddEntryForm)">
		</CENTER>
	</TD></TR>
	</FORM>
	<TR><TD COLSPAN="2" CLASS="rowlabel">%include dict-navbar.dsp%</TD></TR>
	<SCRIPT>
		document.AddEntryForm.DeltaEntryName.options[0] = null;
		document.AddEntryForm.Choice.options[0] = null;
	</SCRIPT>
</TABLE>
