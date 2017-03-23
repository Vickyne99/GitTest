<TABLE WIDTH="75%">
	<TR><TH COLSPAN="2" CLASS="title">Categories for Dictionary: %value DictionaryName% ver %value DictionaryVersion%</TH></TR>
	%ifvar Action%
		%scope rparam(tmp={})%
			%rename DeltaCategoryName CategoryName -copy%
				%ifvar Action equals('Delete')%
					%invoke wm.ip.dictionary:deleteCategory%
						<TR><TH COLSPAN="2" id="message">Category '%value CategoryName%' deleted</TH></TR>
					%onerror%
						<TR><TH COLSPAN="2" id="message">
							An error occured deleting category: %value errorInputs/CategoryName%<BR>
							%value error%, %value errorMessage%
						</TH></TR>
					%endinvoke%
				%endif%
				%ifvar Action equals('Add')%
					%invoke wm.ip.dictionary:addCategory%
						<TR><TH COLSPAN="2" id="message">Category '%value CategoryName%' added</TH></TR>
					%onerror%
						<TR><TH COLSPAN="2" id="message">
							An error occured adding category: %value errorInputs/CategoryName%<BR>
							%value error%, %value errorMessage%
						</TH></TR>
					%endinvoke%
				%endif%
		%endscope%
	%endif%

	<TR><TD COLSPAN="2" CLASS="rowlabel">%include dict-navbar.dsp%</TR></TD>
	<TR><TH COLSPAN="2" CLASS="heading">Category Name</TD></TR>

	%invoke wm.ip.dictionary:listCategories%
		%ifvar CategoryNames -notempty%
			%loop CategoryNames%
				<TR>
					<TD COLSPAN="2" CLASS="rowdata">
						<A href="javascript:goCategory('%value %', 'View');">%value %</A>,
						<A href="javascript:deleteCategory('%value %');">delete</A>
					</TD>
				</TR>
			%endloop%
		%else%
			<TR><TD COLSPAN="2" CLASS="rowdata">No Categories</A></TD></TR>
		%endif%
	%onerror%
		<TR><TD COLSPAN="2" id="message">Error listing categories: %value error%, %value errorMessage%</TD></TR>
	%endinvoke%
	<TR><TH COLSPAN="2" CLASS="heading">Add New Category</TH></TR>
	<FORM name="AddCategoryForm" ACTION="dict-index.dsp" METHOD="POST" onsubmit="return false">
	<TR>
		<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
		<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
		<INPUT TYPE="HIDDEN" NAME="Action" VALUE="Add">
		<TD CLASS="rowlabel">Category Name</TD>
		<TD CLASS="rowdata"><INPUT TYPE="TEXT" NAME="DeltaCategoryName"></TD>
	</TR>
	<TR>
		<TH CLASS="rowdata" COLSPAN="2">
			<CENTER>
				<INPUT 	TYPE="BUTTON" 
							onClick="javascript:addCategory(document.AddCategoryForm);" 
							VALUE="Add Category">
			</CENTER>
		</TH>
	</TR>
	<TR><TD COLSPAN="2" CLASS="rowlabel">%include dict-navbar.dsp%</TR></TD> </FORM>
</TABLE>
