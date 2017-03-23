<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='content-type' content='text/html; charset=utf-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    </head>
    
    <script>
        function launchHelp() {
            if (parent.menu != null){
                //window.open(parent.menu.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
				window.open('doc/OnlineHelp/HL7ModuleOH.html', 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
            }
        }
        
        function loadPage(url) {
            window.location.replace(url);
        }

		%ifvar message%
			%ifvar norefresh%
			%else%
				setTimeout("loadPage('top.dsp')", 30000);
			%endif%
		%endif%
    </script>
    
    <body  class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
        <table border=0 cellspacing=0 cellpadding=0 height=47 width=100%>
            <tr>
                <td>
                    <table height=14 width=100% cellspacing=0 border=0>
                        <tr>
                            <td nowrap class="toptitle" width="100%">
                                %value $host% :: Integration Server :: HL7
                            </td>
                            <td bgcolor="FFFFFF">
                                <img src="/WmRoot/images/newlogo.gif" border=0>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height=100%>
                <td>
                    <table width=100% height=33 cellspacing=0 border=0>
                        <tr>
                            <td nowrap width=100% class="topmenu">
                            </td>
                            <td nowrap valign="bottom" class="topmenu">
                                <a href='javascript:window.parent.close();'>Close Window</a>
								| 
                                <a target='body' onclick="launchHelp();return false;" href='#'>Help</a>&nbsp;
                            </td>
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
	</body>
</html>






