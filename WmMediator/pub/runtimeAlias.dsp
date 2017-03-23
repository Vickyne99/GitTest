<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
    <title>Integration Server - Mediator Runtime Alias</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
    <link rel="stylesheet" href="css/consumers.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/consumers.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    List of Runtime Alias
</div>
<br/>
<div id="container">

   %invoke pg.UIConfig:getRuntimeAlias%

        %ifvar runtimealias -notempty%
            <div class="links">
                <a href="#" class="expand">Expand All</a> / <a href="#" class="collapse">Collapse All</a>
            </div>

            %loop runtimealias%
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
							<td width=25%>Runtime Alias Type</td>
							<td>%value type%</td>
						</tr>						
						
						%ifvar description -notempty%
						<tr>
							<td>Description</td>
							<td>%value description%</td>
						</tr>
						%endif%
				
						%ifvar type equals('Simple Alias')%
						%ifvar value -notempty%
						<tr>
							<td>value</td>
							<td>%value value%</td>
						</tr>
						%endif%						
						%endif%
						
						%ifvar type equals('Secure Alias')%				 
						%ifvar authentication -notempty%
							<tr>
								<td>Authentication</td>
								<td>%value authentication%</td>
							</tr>
						%endif%						
						%endif%
						 
						%ifvar type equals('Endpoint Alias')%				 
							%ifvar endpointvalue -notempty%
							<tr>
								<td>Endpoint</td>
								<td>%value endpointvalue%</td>
							</tr>
							%endif%						 
								
							<tr>
								<td>EndPoint Properties</td>
								<td>								
									<li>SOAP optimization method : %value soapoptimization%</li>
									<li>Connection timeout : %value connectiontimeout%</li>								
									<li>Read timeout : %value readtimeout%</li> 
									<li>WS-Security header : %value headers%</li>
								</td>
							</tr>	                    
						 %endif%		

						%ifvar type equals('WebMethodsISService Alias')%				 
							%ifvar serviceName -notempty%
							<tr>
								<td>Service Name</td> 
								<td>%value serviceName%</td>
							</tr>
							%endif%						
						%endif%				 
						 
						%ifvar type equals('XSLT Alias')%				 
							%ifvar key -notempty%
							<tr>
								<td>Key</td>
								<td>%value key%</td>
							</tr>
							%endif%						
						%endif%				 
					</table>
				</div>
            </div>  
            %endloop%
        %else%
              <div class="info">No Runtime Alias found!</div>
        %endifvar%

   %endinvoke%
</div>
</body>
</html>