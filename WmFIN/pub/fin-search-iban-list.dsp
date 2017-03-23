<html>

	<head>
		<title>BICPlus Search Results</title>
%include ../../WmRoot/pub/b2bStyle.css%
	</head>

	<body >

		<table width="100%" >
			<tr width="100%">
				<td class="menusection-Logs" colspan=2>SWIFT &gt; Search BankDirectoryPlus Information&gt; Search Results&nbsp;</td>
			</tr>

			<tr>
				<td valign="top">
					<ul>
						<li><a href="fin-bicplus-search.dsp">Return to BankDirectoryPlus Search</a></li>
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

		%invoke wm.fin.bic:getBICPlusInfo%
					<tr>
						<td class="evenrow">Results Retrieved</td>
                                          %ifvar BDPInfo%
						<td class="evenrow-l">&nbsp;&nbsp;%value count%</td>
                                          %else%
						<td class="evenrow-l">&nbsp;&nbsp;0</td>
                                          %endif BDPInfo%
					</tr>

					</table>
				</td>
			</tr>

			<tr><td>&nbsp;</td></tr>

			<tr>
				<td>
					<table width="100%">
                                      %ifvar BDPInfo%			
					
						<tr><td class="heading" colspan="8">Results</td></tr>
						<tr>
							<td class="oddcol">Code</td>
							<td class="oddcol">Institution</td>
							<td class="oddcol">Branch</td>
							<td class="oddcol">City</td>
							<td class="oddcol">Modified Flag</td>
							<td class="oddcol">Location</td>
							<td class="oddcol">Physical Address</td>
							<td class="oddcol">Country Name</td>
						</tr>
						%loop BDPInfo%
						<tr>
							
							<td class="evenrow-l">%value BIC_8%&nbsp;</td>
							<td class="evenrow-l">%value INSTITUTION_NAME%&nbsp;</td>
							<td class="evenrow-l">%value BRANCH_BIC% &nbsp;</td>
							<td class="evenrow-l">%value CITY% &nbsp;</td>
							<td class="evenrow-l">%value MODFLAG% &nbsp;</td>
							<td class="evenrow-l">%value CPS% &nbsp;</td>
							<td class="evenrow-l">%value STREET_ADDRESS_1% &nbsp;</td>
							<td class="evenrow-l">%value COUNTRY_NAME% &nbsp;</td>
						</tr>
						%endloop BDPInfo%
						<tr><td></td></tr>
					%endif BDPInfo%

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
