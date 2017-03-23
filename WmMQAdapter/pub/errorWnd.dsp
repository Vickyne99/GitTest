<SCRIPT language="JavaScript">
  function errorWindow() {
   errWnd=window.open("","displayWindow","height=100,width=300,screenX=250,screenY=200,dependent")
   errWnd.document.write("<HTML><HEAD><TITLE>Error</TITLE></HEAD><BODY><CENTER><FONT size='+1' color='red'>") 
   errWnd.document.write("%ifvar localizedMessage -notempty%%value localizedMessage encode(xml)%%else%%value errorMessage encode(xml)%%endif%")
   errWnd.document.write("</FONT></CENTER>")
   errWnd.document.write("<BR>")
   errWnd.document.write("<FORM><CENTER><INPUT type='button' value='Close' onclick='parent.close()'>")
   errWnd.document.write("</CENTER></FORM></BODY></HTML>")
  }
</SCRIPT>
