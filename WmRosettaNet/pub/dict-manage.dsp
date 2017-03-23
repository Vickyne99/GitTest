<TABLE WIDTH="75%">


	<TR><TH CLASS="title" COLSPAN="2">Manage Dictionaries</TH></TR>
	%switch Action%
		%case 'Delete'%
				%invoke wm.ip.dictionary:deleteDictionary%
					<TR><TH id="message" COLSPAN="2">
						Dictionary '%value oldDictionaryName%' ver '%value oldDictionaryVersion%' deleted
					</TH></TR>
				%onerror%
					<TR><TH id="message" COLSPAN="2">
						Error occured deleting Dictionary 
						'%value errorInputs/oldDictionaryName%' ver '%value errorInputs/oldDictionaryVersion%' <BR>
						%value errorMessage%
					</TH></TR>
				%endinvoke%
		%case 'Add'%
				%scope param(DictionaryTypeID='0')%
				%invoke wm.ip.dictionary:addDictionary%
					<TR><TH id="message" COLSPAN="2">
						Dictionary '%value newDictionaryName%' ver '%value newDictionaryVersion%' created
					</TH></TR>
				%onerror%
					<TR><TH id="message" COLSPAN="2">
						Error occured adding Dictionary 
						'%value errorInputs/newDictionaryName%' ver '%value errorInputs/newDictionaryVersion%' <BR>
						%value errorMessage%
					</TH></TR>
				%endinvoke%
				%endscope%
	%endswitch%

	<TR><TD CLASS="rowlabel" COLSPAN="2">%include dict-navbar.dsp%</TD></TR>
	<TR>
		<TH CLASS="heading" COLSPAN="2">Name</TH>
	</TR>
	%invoke wm.ip.dictionary:listDictionaries%
		%ifvar Dictionaries -notempty%
			%loop Dictionaries%
	 			<TR>
					<TD WIDTH="20%" CLASS="rowdata" COLSPAN="2">
						<a href="javascript:goDictionary ('%value name%', '%value version%', 'View');">%value name% ver %value version%</a>
						, <a href="javascript:deleteDictionary ('%value name%', '%value version%');">delete</a>
					</TD>
				</TR>
			%endloop%
		%else%
			<TR><TD CLASS="rowdata" COLSPAN="2">No dictionaries</TD></TR>
		%endif%
	%onerror%
		<TR><TD id="message" COLSPAN="2">Error listing Dictionaries: '%value errorMessage%'</TD></TR>
	%endinvoke%
	<FORM NAME="AddDictionaryForm" ACTION="dict-index.dsp" METHOD="POST" onsubmit="return false">
		<TR>
			<TH CLASS="heading" COLSPAN="2"> Add Dictionary </TH>
		</TR>
		<TR>
			<TD CLASS="rowlabel">Dictionary Name</TD>
			<TD CLASS="rowdata"><INPUT NAME="newDictionaryName"></TD>
		</TR>
		<TR>
			<TD CLASS="rowlabel">Dictionary Version</TD>
			<TD CLASS="rowdata"><INPUT NAME="newDictionaryVersion"></TD>
		</TR>
		<INPUT TYPE="HIDDEN" NAME="Action" VALUE="Add">
		<TR> <TH CLASS="rowdata" COLSPAN="2">
			<CENTER><INPUT TYPE="BUTTON" VALUE="Add Dictionary" onclick="javascript:addDictionary(document.AddDictionaryForm);"></CENTER>
		</TH></TR>
	</FORM>
	<TR><TD CLASS="rowlabel" COLSPAN="2">%include dict-navbar.dsp%</TD></TR>
</TABLE>
