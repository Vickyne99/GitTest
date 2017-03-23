%comment%----- Displays Connection Parameters and Properties -----%endcomment%

<HTML> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Connection Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script SRC="artconnjs.txt"></script>
	
    </head>
	
    
    <body onLoad=handleConnectionTypeChangeOnLoad()>
        <form name="form" action="ListResources.dsp" method="POST">
        <input type="hidden" name="action" value="saveConnection">
        <input type="hidden" name="listAllConnection" value="listAllConnection">
        <input type="hidden" name="passwordChange" value="false">
     
        %invoke wm.art.admin:retrieveAdapterTypeData%
        %onerror%
        %endinvoke%
    
      %include ConfConnection.dsp%
	  
        <table width=100%>
        <td class="action" colspan="2">
            <input type="submit" name="SUBMIT" value="Save Connection"  onclick="return validateForm(this.form)"></input>
            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%"> 
        </td>    
        </tr>
        </table>
        </form>    
    </body>
</html>
