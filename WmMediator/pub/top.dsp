<HTML>

<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<link rel="stylesheet" type="text/css" href="/WmRoot/top.css">
<link rel="stylesheet" type="text/css" href="css/top.css">
<script src="js/jquery.js" type="text/javascript"></script>

</HEAD>


<script>
$(function() {
	if (window.parent.opener==null) $('span#closeLink').detach();
});

function launchHelp()
{
	if(parent.framebody.main.document.forms["urlsaver"].helpURL.value != null){
    	window.open(parent.framebody.main.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
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

   <BODY  class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">


<table border=0 cellspacing=0 cellpadding=0 height=47 width=100%>
<tr>
<td>

      <TABLE height=14 width=100% CELLSPACING=0 BORDER=0>

         <TR>
			<td class="saglogo">
                <img src="images/mediator_logo.png" />
            </td>

            <TD nowrap class="toptitle" width="100%">

              %value $host%
              ::
              Integration Server
              ::
              Mediator
            </TD>
			
			<TD nowrap class="topmenu">
			 <span id='closeLink'><A  href='javascript:window.parent.close();'>Close Window</A> 
	         |</span>
			 <A href="/WmMediator/doc/OnlineHelp/" target="_blank">Help</font></A>
			  &nbsp;&nbsp;
			</TD>
         </TR>
      </TABLE>


</td>
</tr>
</table></BODY>
</HTML>


