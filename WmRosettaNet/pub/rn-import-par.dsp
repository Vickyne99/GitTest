<HTML>

<HEAD>
  <TITLE>RosettaNet PIP Import Facility</TITLE>
  %include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>

%switch action%
%case view%
  %include import-view-par.dsp%
 
%case import%
  %include import-doit-par.dsp%

%case%
  %include import-list-par.dsp%

%endswitch%

</BODY>

</HTML>
