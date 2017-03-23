<html>

	<head>
		<title>BIC Search Results</title>
%include ../../WmRoot/pub/b2bStyle.css%
	</head>

	<body >

		<table width="100%" >
			<tr width="100%">
				<td class="menusection-Logs" colspan=2>SWIFT &gt; Search BIC Information&gt; Search Results&nbsp;</td>
			</tr>

			<tr>
				<td valign="top">
					<ul>
						<li><a href="fin-bic-search.dsp">Return to BIC Search</a></li>
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
						<tr>
							<td class="evenrow">Code</td>
							%ifvar code%
							<td class="evenrow-l">&nbsp;&nbsp;%value code%</td>
							%else%
							<td class="evenrow-l">&nbsp;&nbsp;</td>
							%endif%
						</tr>
						%ifvar institution%
						<tr>
							<td class="evenrow">Institution</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value institution%</td>
						</tr>
						%endif%
						%ifvar branch%
						<tr>
							<td class="evenrow">Branch</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value branch%</td>
						</tr>
						%endif%
						%ifvar city%
						<tr>
							<td class="evenrow">City</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value city%</td>
						</tr>
						%endif%
						%ifvar modFlag%
						<tr>
							<td class="evenrow">Modified Flag</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value modFlag%</td>
						</tr>
						%endif%
						%ifvar location%
						<tr>
							<td class="evenrow">Location</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value location%</td>
						</tr>
						%endif%
						%ifvar countryName%
						<tr>
							<td class="evenrow">Country Name</td>
							<td class="evenrow-l">&nbsp;&nbsp;%value countryName%</td>
						</tr>
						%endif%

		%invoke wm.fin.bic:getBICInfo%
					<tr>
						<td class="evenrow">Results Retrieved</td>
                                          %ifvar BICInfo%
						<td class="evenrow-l">&nbsp;&nbsp;%value count%</td>
                                          %else%
						<td class="evenrow-l">&nbsp;&nbsp;0</td>
                                          %endif BICInfo%
					</tr>

					</table>
				</td>
			</tr>

			<tr><td>&nbsp;</td></tr>

			<tr>
				<td>
					<table width="100%">
                                      %ifvar BICInfo%			
					
						<tr><td class="heading" colspan="7">Results</td></tr>
						<tr>
							<td class="oddcol">Code</td>
							<td class="oddcol">Institution</td>
							<td class="oddcol">Branch</td>
							<td class="oddcol">City</td>
							<td class="oddcol">Modified Flag</td>
							<td class="oddcol">Location</td>
							<td class="oddcol">Country Name</td>
						</tr>
						%loop BICInfo%
						<tr>
							
							<td class="evenrow-l">%value code%&nbsp;</td>
							<td class="evenrow-l">%value institution%&nbsp;</td>
							<td class="evenrow-l">%value branch% &nbsp;</td>
							<td class="evenrow-l">%value city% &nbsp;</td>
							<td class="evenrow-l">%value modFlag% &nbsp;</td>
							<td class="evenrow-l">%value location% &nbsp;</td>
							<td class="evenrow-l">%value countryName% &nbsp;</td>
						</tr>
						%endloop BICInfo%
						<tr><td></td></tr>
					%endif BICInfo%

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
			%end invoke searchPageSearch%

		<p>&nbsp;</p>

	</body>
</html>
