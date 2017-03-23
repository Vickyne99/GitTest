<SCRIPT>
	function validate() {
		var errMsg = "";
		if (document.CreateArchive.FileName.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "File Name";
		}
		if (document.CreateArchive.PIPName.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "Transaction Name";
		}
		if (document.CreateArchive.PIPNumber.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "Transaction Number";
		}
		if (document.CreateArchive.PIPVersion.value.length == 0) {
			if (errMsg.length != 0) { errMsg = errMsg + ", "; }
			errMsg = errMsg + "Transaction Version";
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
		<TH COLSPAN="2" CLASS="heading">Create Transaction Export Archive</TH>
	</TR>
	<FORM NAME="CreateArchive" ACTION="chem-export.dsp" METHOD="POST">
	<TR>
		<TH WIDTH="20%" CLASS="rowlabel">File Name</TH>
		<TD CLASS="rowdata"><INPUT NAME="FileName" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">Transaction Name</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPName" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">Transaction Number</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPNumber" TYPE="TEXT"></TD>
	</TR>
	<TR>
		<TH CLASS="rowlabel">Transaction Version</TH>
		<TD CLASS="rowdata"><INPUT NAME="PIPVersion" TYPE="TEXT"></TD>
	</TR>
	%invoke wm.estd.chemical.expt:getPipRecords%
		%ifvar count equals('0')%
			<TR> <TD COLSPAN="2" CLASS="rowdata">No IS Document Types to Export</TD></TD>
		%else%
			<TR>
				<TH CLASS="rowlabel">Select IS Document Types to Export</TH>
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
        %invoke wm.tn.doctype:list%
		%ifvar typeCount equals('0')%
			<TR> <TD COLSPAN="2" CLASS="rowdata">No TN BizDocTypes to Export</TD> </TR>
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
	%invoke wm.estd.chemical.expt:getAllTPAs%

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
	<TR><TD COLSPAN="2" CLASS="heading">
		<INPUT 	TYPE="BUTTON" 
					NAME="SUBMIT" 
					VALUE="Create Archive" 
					onClick="javascript:validate();">
	</TD></TR>
	<INPUT TYPE="HIDDEN" NAME="action" VALUE="export">
	</FORM>

</TABLE>
