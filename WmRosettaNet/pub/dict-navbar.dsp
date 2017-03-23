		<TABLE WIDTH="100%"> <TR><TD CLASS="rowdata">
		%ifvar DictionaryName%
			<a href="dict-index.dsp">Manage Dictionaries</a>
			%ifvar CategoryName%
				: Dictionary '<a href="javascript:document.Dictionary.submit();">%value DictionaryName% v%value DictionaryVersion%</a>'
				%ifvar EntryName%
					: Category '<a href="javascript:document.Category.submit();">%value CategoryName%</a>' : Entry '%value EntryName%'
				%else%
					: Category '%value CategoryName%'
				%endif%
			%else%
				: Dictionary '%value DictionaryName% v%value DictionaryVersion%' 
			%endif%
		%else%
			Manage Dictionaries
		%endif%
		</TD></TR></TABLE>
