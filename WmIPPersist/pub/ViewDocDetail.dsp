<html>

<head>
	%include ../../WmRoot/pub/b2bStyle.css%


	<title>Persistence Document Detail</title>
	<link rel="stylesheet" type="text/css" href="webMethods.css">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>

	<script language="JavaScript">
		function popUpDoc( URL, title ) {
			var OpenContent = window.open (URL,title,'width=800,height=700,scrollbars=yes,toolbar=no,location=no,resizable=yes');
			}
	</script>
</head>

<body>
	<table width="100%" >
		<tr width="100%">
			<td class="menusection-adapters" colspan=2>
      %ifvar productKey%
      	%value productKey% &gt;
      %else%
      	IP Finance &gt;
	  %endif%
	  Persistence &gt;
	Document Details&nbsp;</td>
		</tr>

		<tr>
			<td valign="top">
				<ul>
					<li><a href="Persist.dsp?productKey=%value productKey%">Return to Persistence Query</a></li>
				</ul>
			</td>
		</tr>

		<!--- Doc Attr --->
		%invoke wm.ip.persist.util:get%
		<tr>
			<td>
				<table>
					<tr><td class="heading" colspan="2">Message Attributes</td></tr>

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
						%ifvar date%
						<tr>
							<td class="oddrow">Date Created</td>
							<td class="oddrow-l">&nbsp;&nbsp;%value date%</td>
						</tr>
						%endif%
				</table>
			</td>
		</tr>


		<tr>
			<td>
				<table width="100%">
					<tr><td class="heading">Message</td></tr>
					<tr>
						<td class="evencol-l">%value msg%</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td></td></tr>
	%endinvoke%
	</table>
</body>
</html>
