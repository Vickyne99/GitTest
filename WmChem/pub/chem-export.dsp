<HTML>

<HEAD>
  <TITLE>Export Facility</TITLE>
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

%case display%
	<Br>Display<Br>
	%loop -struct%
		%value $key% = '%value%'
		%loopsep '<br>'%
	%endcomment%

	<br>NameList = <br>
	%ifvar nsNameList%
		%loop nsNameList%
			%value%
			%loopsep '<br>'%
		%endloop%
	%endif%
	
        <br>scripts = <br>
	%ifvar scriptNameList%
		%loop scriptNameList%
			%value%
			%loopsep '<br>'%
		%endloop%
	%endif%


	<Br>doctype list = <br>
	%ifvar docTypeNameList%
		%loop docTypeNameList%
			%value%
			%loopsep '<br>'%
		%endloop%
	%endif%



%endswitch%

</BODY>

</HTML>
