<HTML>

<HEAD>
  <TITLE>RosettaNet Modular PIP Import Facility</TITLE>
  %include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>

%switch action%
%case view%
  %include import-view.dsp%
 
%case import%
  %include import-doit.dsp%

%case%
  %include import-list.dsp%

%endswitch%

</BODY>

</HTML>
