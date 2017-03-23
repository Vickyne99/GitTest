<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

    <link rel="stylesheet" type="text/css" href="/WmRoot/top.css">

<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">

</HEAD>


<script>
function launchHelp() {
            var url="";
            if (parent.menu != null){
			    var helpURLFromPage = parent.menu.document.forms["urlsaver"].helpURL.value;
				var helptopic = helpURLFromPage.lastIndexOf("=");				
				var topic = helpURLFromPage.substring(helptopic+1);
				
				%invoke wm.server.admin:getHelpTopicUrlMappings%			
					%ifvar result%
					%loop result%
						var id = "%value id%";
							if(id==topic)
							{
								url="%value url%";
							}
					%endloop%		
					%endif%
				%endinvoke%
				window.open(url, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
            }
}


function loadPage(url)
{
	window.location.replace(url);
}


%ifvar message%
  %ifvar norefresh%%else%
    setTimeout("loadPage('top.dsp')", 30000);
        %endif%
%endif%



</script>

  <body class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
    <table border=0 cellspacing=0 cellpadding=0 height=70 width="100%">
      <tr>
        <td>
          <table height=14 width="100%" cellspacing=0 cellpadding=0 border=0>
            <tr>
              %invoke wm.server.query:getServerInstanceName%

              <td class="saglogo">
                %ifvar productname equals('Integration Agent')%
                  <img src="/WmRoot/images/ia_logo.png" /><br/>
                %else%
                  <img src="/WmRoot/images/is_logo.png" /><br/>
                %endif%
              </td>

              <td width="100%">
                 <table width="100%">
                 <tr>
                   <td class="toptitle" width="30%">
                   %ifvar instancename%
                     %value instancename% ::
                   %endif%
                   %value $host% ::
                   Mobile Support
                   </td>
              %endinvoke%
            </tr>
          </table>
        </td>

        <td nowrap class="topmenu" width="25%">
          <a target='body' onclick="launchHelp();return false;" href='#'>Help</a>&nbsp;
        </td>
      </tr>
    </table>
    </td>
    </tr>
      
    <tr height="100%">
      <td nowrap valign="top">
        <table width="100%" height="40" CELLSPACING="0"  cellpadding="0">
          <tr>
          </tr>
        </table>
        </td>
      </tr>
    </table>
  </body>
</html>
