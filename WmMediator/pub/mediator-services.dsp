<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
    <title>Integration Server - Mediator Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/mediator.css" type="text/css"/>
	<link rel="stylesheet" href="css/consumers.css" type="text/css"/>
    <link rel="stylesheet" href="css/services.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/consumers.js" type="text/javascript"></script>
    <script src="js/services.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb" style="height:1em">
    List of Mediator Services
</div>

<br/>
<div id="container">
%invoke pg.UIConfig:getServices%
    %ifvar services -notempty %
		<div class="links">
			<a href="#" class="expand">Expand All</a> / <a href="#" class="collapse">Collapse All</a>
		</div>
			
        %loop services%
            <div class="consumer">
              <table class="tableView">
				<tr>
				  <th width=80% class="services-heading" id="%value display-name%">
					<span class="img">
						<img id=%value idx% 
							src="images/expanded.gif" 
						alt="expand/collapse"/>
						
						<span>%value display-name%</span>
						%ifvar version -notempty% <span>%value version%</span> %endif%
					</span>
				  </th>
				  <th class="services-heading">
					<span>
						<form class="serviceDetails" action="service-details.dsp" method="post">
							<input type="hidden" name="serviceName" value="%value name%"/>
							<input type="hidden" name="type" value="vsd"/>
							[<a style="color:#FFF" href="#">VSD</a>]
						</form>
					</span>
					<span>
					   %ifvar wsdlUrl -notempty% [<a style="color:#FFF" href="%value wsdlUrl%" target="_blank">WSDL</a>] %endif%
					</span>
				  </th>
				</tr>
			  </table>
            
				<div class="details">
					<table class="tableView">
                        <tr>
                            <td width=20%>Service Type</td>
                            <td>%value service-type%</td>
                        </tr>

                        %ifvar service-type equals('REST')%
                        <tr>
                            <td>Deployment Type</td>
                            %ifvar rest-stack-used equals('true')%
                            <td>Axis-free</td>
                            %else%
                            <td>WSStack</td>
                            %endif%
                        </tr>
						%endif%

						%ifvar service-type equals('ODATA')%
						%else%
							<tr>
								<td>Operations</td>
								<td>
                                    %ifvar operations -notempty%
    	                                %loop operations%
    	                                    <li>%value operations%</li>
    	                                %endloop%
                               	    %else%
                                	   <span class="noconsumers">(no operations)</span>
                                    %endif%
								</td>
							</tr>
						%endif%

						<tr>
							<td>Consumers</td>
                            <td>
                                %ifvar consumers -notempty%
                                    <ul>
                                        %loop consumers%
                                            <li><a href="consumers.dsp#%value consumers%">%value consumers%</a></li>
                                        %endloop%
                                    </ul>
                                %else%
                                    <span class="noconsumers">(no registered consumers)</span>
                                %endif%
							</td>
						</tr>
					</table>
				</div>
            </div>
        %endloop%
    %else%
        <div class="info">No Virtual Services found!</div>
    %endif%
%endinvoke%
</div>


</body>
</html>