<HTML>

<HEAD>
  <TITLE>RosettaNet PIP Import Facility</TITLE>
  %include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>

%switch action%
%case view%
  %include import-view-sample.dsp%
 
%case import%
  %include import-doit-sample.dsp%

%case%
  %include import-list-sample.dsp%

%endswitch%

</BODY>

</HTML>
