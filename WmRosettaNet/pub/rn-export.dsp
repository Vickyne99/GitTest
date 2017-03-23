<HTML>

<HEAD>
  <TITLE>RosettaNet PIP Export Facility</TITLE>
  %include ../../WmRoot/pub/b2bStyle.css%
</HEAD>

<BODY>

%switch action%
	%case export%
		%include export-doit.dsp%
	%case step2%
		%include export-page2.dsp%
	%case%
		%include export-view.dsp%

%endswitch%

</BODY>

</HTML>
