%invoke pg.UIConfig:mainMenu%

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--suppress ALL -->
<html>
<head>
  <link rel="stylesheet" type="text/css" href="/WmRoot/layout.css">
  <title>%value $host% - webMethods Integration Server</title>
  <link rel="icon" HREF="/WmRoot/favicon.ico" />
</head>
<body>
  <div><iframe class="top" src="top.dsp"></iframe></div>
  <div class="bottom">
    <iframe class="menuframe" name="menu" src="menu.dsp" scrolling="yes" seamless="seamless"></iframe>
    <iframe class="contentframe" name="body" src="apiportal-config.dsp"></iframe>
  </div>
</body>
</html>