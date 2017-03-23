<SCRIPT>
	function validate() {
		var errMsg = "";
		if (document.CreateArchive.FileName.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "File Name";
		}
		if (document.CreateArchive.PIPName.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "PIP Name";
		}
		if (document.CreateArchive.PIPNumber.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "PIP Number";
		}
		if (document.CreateArchive.PIPVersion.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "PIP Version";
		}
		if (errMsg.length > 0 ) {
			alert ("Please specify values for the following fields: " + errMsg);
	 	} else {
			document.CreateArchive.submit();
		}
	}
</SCRIPT>

<TABLE WIDTH="75%">

	<TR>
		<TH COLSPAN="2" CLASS="title">Create PIP Export Archive</TH>
	</TR>
	<FORM NAME="CreateArchive" ACTION="rn-export.dsp" METHOD="POST">
	<TR>
		<TH WIDTH="20%" CLASS="rowlabel">File Name</TH>
		<TD CLASS="rowdata"><INPUT NAME="FileName" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">PIP Name</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPName" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">PIP Number</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPNumber" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">PIP Version</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPVersion" TYPE="TEXT"></TD>
	</TR>
	%invoke wm.tn.doctype:list%
		%ifvar typeCount equals('0')%
			<TR> <TD COLSPAN="2" CLASS="rowdata">No TN Biz Doc Types to Export</TD> </TR>
		%else%
			<TR> <TH CLASS="rowlabel">Select TN Biz Doc Types to Export</TH>
			<TD CLASS="rowdata">
				<TABLE WIDTH="100%">
					%loop types%
						%ifvar Deleted equals('false')%
							<TR>
								<TD CLASS="rowdata"><INPUT TYPE="CHECKBOX" NAME="docTypeName" 
VALUE="%value TypeName%"> %value TypeName%</TD>
							</TR>
						%endif%
					%endloop%
				</TABLE>
			</TD>
			</TR>
		%endif%
		%onerror%
		<TR> <TD COLSPAN="2" CLASS="rowdata">Error = %value error% </TD></TR>
	%endinvoke%
	%invoke wm.estd.rosettaNet.expt:getAllTPAs%

		%ifvar tpaCount equals('0')%
			<TR> <TD COLSPAN="2" CLASS="rowdata">No TPAs' to Export</TD>
</TR>
		%else%
			<TR> 
				<TH CLASS="rowlabel">Select TPAs' to Export</TH> 
				<TD CLASS="rowdata">
					<TABLE WIDTH="100%">
						%loop TPAList%
							<TR>
								<TD><INPUT TYPE="CHECKBOX" NAME="tpaID" VALUE="%value senderID%:%value receiverID%:%value agreementID%">
									TPA between sender ('%value sender%') and receiver ('%value receiver%')  with
									AgreementID '%value agreementID%'</TD>
							</TR>
			
						%endloop%
					</TABLE>
				</TD>
			</TR>
		%endif%
	%endinvoke%
	%invoke wm.estd.rosettaNet.expt:getPipRecords%
		%ifvar count equals('0')%
			<TR> <TD COLSPAN="2" CLASS="rowdata">No PIP Folders to Export</TD></TD>
		%else%
			<TR>
				<TH CLASS="rowlabel">Select PIP Folders to Export</TH>
				<TD CLASS="rowdata">
					<TABLE WIDTH="100%">
					%loop PIPInfo%
						<TR>
							<TD>
								<INPUT TYPE="CHECKBOX" NAME="nsName" VALUE="%value index%">&nbsp;%value interfaceName%
							</TD>
						</TR>
					%endloop%
					</TABLE>
				</TD>
			</TR>
		%endif%

	%endinvoke%
	<TR><TD COLSPAN="2" CLASS="heading">
		<INPUT 	TYPE="BUTTON" 
					NAME="SUBMIT" 
					VALUE="Create Archive" 
					onClick="javascript:validate();">
	</TD></TR>
	<INPUT TYPE="HIDDEN" NAME="action" VALUE="export">
	</FORM>

</TABLE>
