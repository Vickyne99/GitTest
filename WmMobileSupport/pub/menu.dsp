<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <script src="menu.js.txt"></script>
    <style>
    body {     border-top: 1px solid #97A6CB; }
    </style>
        <script src="/WmRoot/common-menu.js"></script>
    <script type="text/javascript">
var selected = null;
var menuInit = false;

function menuSelect(object, id) {
  selected = menuext.select(object, id, selected);
}

function menuMouseOver(object, id) {
  menuext.mouseOver(object, id, selected);
}

function menuMouseOut(object, id) {
  menuext.mouseOut(object, id, selected);
}

function initMenu(firstImage) {
    menuInit = true;
    return true;
}
</script>
</head>

<body class="menu" onload="initMenu('mobile-sync-component.dsp');">
<table width="100%" cellspacing="0" cellpadding="1" border="0">
    <table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
      %scope param(expanded='true')%
        %include ../../WmRoot/pub/menu/section-top.dsp%
          Mobile Support
        %include ../../WmRoot/pub/menu/section-bottom.dsp%
      %endscope%

      %scope param(section='MobileSupport') param(url='mobile-sync-component.dsp')%
        %include ../../WmRoot/pub/menu-subelement-top.dsp%
        Mobile Sync Components
        %include ../../WmRoot/pub/menu-subelement-bottom.dsp%
      %endscope%

      %scope param(section='MobileSupport') param(url='mobile-app.dsp')%
        %include ../../WmRoot/pub/menu-subelement-top.dsp%
        Mobile Applications
        %include ../../WmRoot/pub/menu-subelement-bottom.dsp%
      %endscope%
    </table>
  </body>
</html>
