<html>

	<head>
		<title>Persistence Search Results</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	%include ../../WmRoot/pub/b2bStyle.css%
	<script type="text/javascript" src="tablesort.js"></script>

	</head>

	<body >

		<table width="100%" >
			<tr width="100%">
    <td class="menusection-adapters" colspan="2">
      %ifvar productKey%
      	%value productKey% &gt;
      %else%
      	IP Finance &gt;
	  %endif%
      Persistence &gt;
      Search Results
    </td>
			</tr>

			<tr>
				<td valign="top">
					<ul>
						<li><a href="Persist.dsp?productKey=%value productKey%">Return to Persistence Query</a></li>
					</ul>
				</td>
			</tr>

			<tr>
				<td>
					<table>

						<!-- title bar -->
						<tr>
							<td class="heading" colspan=2>Search criteria</td>
						</tr>
						%ifvar productKey%
						<tr>
							<td class="evenrow">Product</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value productKey%</td>
						</tr>
						%endif%
						%ifvar msgType%
						<tr>
							<td class="oddrow">Message Type</td>
							<td class="oddrow-l">&nbsp;&nbsp;%value msgType%</td>
						</tr>
						%endif%
						%ifvar version%
						<tr>
							<td class="evenrow">Message Version</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value version%</td>
						</tr>
						%endif%
						%ifvar senderId%
						<tr>
							<td class="oddrow">Sender ID</td>
							<td class="oddrow-l">&nbsp;&nbsp;%value senderId%</td>
						</tr>
						%endif%
						%ifvar senderId%
						<tr>
							<td class="evenrow">Receiver ID</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value receiverId%</td>
						</tr>
						%endif%
						%ifvar fromDate%
						<tr>
							<td class="oddrow">From Date</td>
							<td class="oddrow-l">&nbsp;&nbsp;%value fromDate%</td>
						</tr>
						%endif%
						%ifvar toDate%
						<tr>
							<td class="evenrow">To Date</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value toDate%</td>
						</tr>
						%endif%

					%invoke wm.ip.persist.util:query%

					%ifvar additionalQueryFields%
					%loop -struct additionalQueryFields%
					<TR>
						<TD CLASS="rowlabel"><B>%value $key%</B></TD>
						<TD CLASS="rowdata">&nbsp;&nbsp;%value%</TD>
					</TR>
					%endloop%
					%endif%

					<tr>
						<td class="oddrow">Messages Retrieved</td>
						<td class="oddrow-l">&nbsp;&nbsp;%value resultCount%</td>
					</tr>

					</table>
				</td>
			</tr>

			<tr><td>&nbsp;</td></tr>
			%ifvar resultMessage%
			<tr >
				<td class="message">
				%value resultMessage%
				</td>
			</tr>
			%endif%

			<tr>
				<td>
					<TABLE class="tableView" onclick="sortColumn(event)" width="100%">

					%ifvar resultInfo%
						<thead>
						<tr><td class="heading" colspan="7">Messages</td></tr>
						<tr>
							<td class="oddcol">Date</td>
							<td class="oddcol">Product</td>
							<td class="oddcol">Message Type</td>
							<td class="oddcol">Message Version</td>
							<td class="oddcol">Sender ID</td>
							<td class="oddcol">Receiver ID</td>
						</tr>
						</thead>
						<tbody>
						%loop resultInfo%
						<tr>
							<td class="evenrow-l"><a href="ViewDocDetail.dsp?productKey=%value productKey%&msgType=%value msgType%&version=%value version%&senderId=%value senderId%&receiverId=%value receiverId%&msgId=%value msgId%">%value date%</a> &nbsp;</td>
							<td class="evenrow-l">%value productKey% &nbsp;</td>
							<td class="evenrow-l">%value msgType% &nbsp;</td>
							<td class="evenrow-l">%value version% &nbsp;</td>
							<td class="evenrow-l">%value senderId% &nbsp;</td>
							<td class="evenrow-l">%value receiverId% &nbsp;</td>
						</tr>
						%endloop resultInfo%
					</tbody>
					%endif resultInfo%
					<tr><td></td></tr>
				</table>
			</td>
		</tr>
	</table>

			%onerror%
			<hr>
			<p><font color="red">The Server could not process your request because the following error occurred. Contact your server administrator.</font></p>
			<TABLE WIDTH="30%" BORDER="1"> <TR><TD><B>Service</B></TD><TD>%value errorService%</TD></TR>
				<TR><TD><B>Error</B></TD><TD>%value error% &nbsp; %value errorMessage%</TD></TR>
				<TR><TD><B>Error Inputs</B></TD><TD>%value errorInputs% &nbsp;  </TD></TR>
				<TR><TD><B>Error Outputs</B></TD><TD>%value errorOutputs% &nbsp; </TD></TR>
			</TABLE>
			%end invoke queryStore%

		<p>&nbsp;</p>

	</body>
</html>
