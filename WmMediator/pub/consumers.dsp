<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
    <title>Integration Server - Mediator Consumers</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/consumers.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/consumers.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    List of Mediator Consumers
</div>
<br/>
<div id="container">

   %invoke pg.UIConfig:getConsumers%

        %ifvar consumers -notempty%
            <div class="links">
                <a href="#" class="expand">Expand All</a> / <a href="#" class="collapse">Collapse All</a>
            </div>

            %loop consumers%
            <div class="consumer">
                <table class="tableView">
                    <tr>
                        <th colspan=2 class="consumer-heading" id="%value name%">
                            <span class="img">
								<img id=%value idx% 
									src="images/expanded.gif" 
								alt="expand/collapse"/>
                            %value name%
							</span>
                        </th>
                    </tr>
                </table>
                <div class="details">
					<table class="tableView">
						<tr>
							<td width=25%>Created</td> 
							<td>%value created%</td>
						</tr>
						<tr>
							<td>Modified</td>
							<td>%value modified%</td>
						</tr>
						
						%ifvar description -notempty%
						<tr>
							<td>Description</td>
							<td>%value description%</td>
						</tr>
						%endif%
						
						%ifvar partnerid -notempty%
						<tr>
							<td>PartnerID</td>
							<td>%value partnerid%</td>
						</tr>
						%endif%
						
						%ifvar tokens -notempty%
						<tr>
							<td>Tokens</td>
							<td>
								%loop tokens%
								<li>%value token%</li>
								%endloop%
							</td>
						</tr>
						%endif%
						
						%ifvar ranges -notempty%
						<tr>
							<td>IP Ranges</td>
							<td>
								%loop ranges%
								<li>%value rangeFrom% - %value rangeTo%</li>
								%endloop%
							</td>
						</tr>
						%endif%
						
						%ifvar serialNumber -notempty%
						<tr>
							<td>Certificate Information</td>
							<td>
								<span class="sublabel">Serial Number:</span> %value serialNumber%
								<br/>
								<span class="sublabel">Subject DN:</span> %value subjectDN%
								<br/>
								<span class="sublabel">Issued By:</span> %value issuerDN%
							</td>
						</tr>
						%endif%
					</table>
                </div>
            </div>
            %endloop%
        %else%
              <div class="info">No Consumer Applications found!</div>
        %endif%

   %endinvoke%
</div>
</body>
</html>