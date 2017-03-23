<HTML>
	<HEAD>
		%include ../../WmRoot/pub/b2bStyle.css%
		<TITLE>Dictionary Management</TITLE> 
		<SCRIPT>
			function goDictionary (name, version, action) {
				document.Dictionary.DictionaryName.value = name;
				document.Dictionary.DictionaryVersion.value = version;
				document.Dictionary.Action.value = action;
				document.Dictionary.submit();
			}
			function goCategory (category, action) {
				document.Category.CategoryName.value = category;
				document.Category.Action.value = action;
				document.Category.submit();
			}
			function goEntry (entry, action) {
				document.Entry.EntryName.value = entry;
				document.Entry.Action.value = action;
				document.Entry.submit();
			}
			function addDictionary (fname) {
				if (fname.newDictionaryVersion.value.length  != 0 && fname.newDictionaryName.value.length != 0) {
					fname.submit();
				} else {
					alert ("Dictionary Name and Version cannot be empty");
				}
			}
			function addCategory (catForm) {
				if (catForm.DeltaCategoryName.value.length == 0) {
					alert ("Category name cannot be empty");
				} else {
					catForm.submit();
				}
			}
			function addEntryName (addTo, name) {
				if (name.value.length == 0) {
					alert ("Please enter a value ");
				} else {
					if (addTo.options.length != 0) {
						for (i = 0; i < addTo.options.length; i ++) {
							if (addTo.options[i].text == name.value) {
								alert("Cannot have duplicates");
								name.value = "";
								return
							}
						}
					}
					opt = new Option (name.value, name.value, false, false);
					addTo.options[addTo.length] = opt;
					name.value = "";
					addTo.selectedIndex = -1;
					name.focus();
				}
			}
			function removeEntryName (name) {
				if (name.selectedIndex != -1) {
					
					for (i = name.options.length - 1; i >= 0 ; i --) {
						if (name.options[i].selected) {
							name.options[i] = null;
						}
					}
				} else {
					alert ("Select an option to remove");
				}
			}
			function addEntry (theForm) {
				if (theForm.DeltaEntryName.options.length == 0) {
					alert ("Please provide at least one entry name");
					return;
				}
				var entryType = theForm.EntryType.options[theForm.EntryType.selectedIndex].value;
				var msg = "Do you wish to create an entry with the following characteristics?\n";
				var ray = theForm.DeltaEntryName.options;
				msg = msg + "Entry Name(s):\n";
				for (i = 0; i < ray.length; i++) {
					msg = msg + "\t" + ray[i].value + "\n";
				}
				if (entryType == "RegularExpression") {
					if (theForm.RegularExpression.value.length == 0) {
						alert ("Entries of type Regular Expression, must specify a Regular Expression");
						theForm.RegularExpression.focus();
						return;
					}
					msg = msg + "Regular Expression : '" + theForm.RegularExpression.value + "'\n";
				} else if (entryType == "MultipleChoice") {
					msg = msg + "Choices :\n";
					ray = theForm.Choice.options;
					for (i = 0; i < ray.length; i++) {
						msg = msg + "\t" + ray[i].value + "\n";
					}
				}
				if (confirm (msg)) {
					ray = theForm.DeltaEntryName.options;
					for (i = 0; i < ray.length; i++) {
						ray[i].selected = true;		
					}
					ray = theForm.Choice.options;
					for (i = 0; i < ray.length; i++) {
						ray[i].selected = true;		
					}
					theForm.submit();
				}
					
			}
			function deleteDictionary (name, version) {
				if (confirm ("Do you want to delete dictionary '" + name + "' ver '" + version + "'?")) {
					document.DeltaDictionary.oldDictionaryName.value = name;
					document.DeltaDictionary.oldDictionaryVersion.value = version;
					document.DeltaDictionary.Action.value = "Delete";
					document.DeltaDictionary.submit();
				}
			}
			function deleteCategory (category) {
				if (confirm ("Do you want to delete category '" + category + "'")) {
					document.DeltaCategory.DeltaCategoryName.value = category;
					document.DeltaCategory.Action.value = "Delete";
					document.DeltaCategory.submit();
				}
			}
			function deleteEntry (entry) {
				if (confirm ("Do you want to delete entry '" + entry + "'")) {
					document.DeltaEntry.DeltaEntryName.value = entry;
					document.DeltaEntry.Action.value = "Delete";
					document.DeltaEntry.submit();
				}
			}
		</SCRIPT>
	</HEAD>
	<BODY>
		%ifvar DictionaryName%
			%ifvar CategoryName%
				%ifvar EntryName%
					%include dict-entry.dsp%
				%else%
					%include dict-Category.dsp%
				%endif%
			%else%
				%include dict-view.dsp%
			%endif%
		%else%
			%include dict-manage.dsp%
		%endif%
			<FORM NAME="DeltaDictionary" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="oldDictionaryName" VALUE="">
				<INPUT TYPE="HIDDEN" NAME="oldDictionaryVersion" VALUE="">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
			<FORM NAME="Dictionary" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
				<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
			<FORM NAME="DeltaCategory" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
				<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
				<INPUT TYPE="HIDDEN" NAME="DeltaCategoryName" VALUE="">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
			<FORM NAME="Category" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
				<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
				<INPUT TYPE="HIDDEN" NAME="CategoryName" VALUE="%value CategoryName%">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
			<FORM NAME="DeltaEntry" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
				<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
				<INPUT TYPE="HIDDEN" NAME="CategoryName" VALUE="%value CategoryName%">
				<INPUT TYPE="HIDDEN" NAME="DeltaEntryName" VALUE="">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
			<FORM NAME="Entry" ACTION="dict-index.dsp" METHOD="POST">
				<INPUT TYPE="HIDDEN" NAME="DictionaryName" VALUE="%value DictionaryName%">
				<INPUT TYPE="HIDDEN" NAME="DictionaryVersion" VALUE="%value DictionaryVersion%">
				<INPUT TYPE="HIDDEN" NAME="CategoryName" VALUE="%value CategoryName%">
				<INPUT TYPE="HIDDEN" NAME="EntryName" VALUE="%value EntryName%">
				<INPUT TYPE="HIDDEN" NAME="Action" VALUE="View">
			</FORM>
	</BODY>
</HTML>
