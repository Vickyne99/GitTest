%invoke wm.ip.cm:viewScript2%
<html>

<head>
<title>Edit Conversation Script</title>
%include ../../WmRoot/pub/b2bStyle.css%
</head>

<body LINK="#0000ff" VLINK="#800080">


<table width=100%>
<tr class="title">
	<th colspan="8">Edit Conversation Script "%value name%"</th>
</tr>
<tr>
	<th class="heading">Name</th>
	<th class="heading">Focal Role</th>
	<th class="heading">Second Role</th>
</tr>
<tr bgcolor=white>
    <td class="position" align=left>%value name%</a></td>
    <td class="position" align=left>%value focalRole%</td>
    <td class="position" align=left>%value secondRole%</td>
</tr>
</table>

<BR>
<BR>

<FORM ACTION="rn-scripts.dsp" METHOD="post">

    <INPUT TYPE="HIDDEN" NAME="name" VALUE="%value /name%">   
    <INPUT TYPE="HIDDEN" NAME="saveScript" VALUE="true">  

<!-- starting doc types -->              
    <P>Change starting documents:</P>               
    %loop startingDocTypes%
        
        <SELECT NAME="startingDoc">
        %loop /types%
            <OPTION VALUE="%value TypeID%" %ifvar TypeID vequals(../ID)% SELECTED="SELECTED" %endif%>%value TypeName% -- %value TypeDescription%</OPTION>
        %endloop%
        </SELECT>
        <BR>
        
    %endloop%

    <table width=100%>
    <tr bgcolor=yellow>Note: If a starting document is changed, the first wait step should be changed accordingly.</tr>
    </table>

<!-- wait steps -->
    <P>Change wait steps:</P>
    %loop waitSteps%

        <P><B>Step "%value name%"</B></P>
        
        %loop docs%
                <SELECT NAME="%value ../name%_%value destStep%_%value eventName%">
                %loop /types%
                        <OPTION VALUE="%value TypeID%" %ifvar TypeID vequals(../typeID)% SELECTED="SELECTED" %endif%>%value TypeName%</OPTION>
                %endloop%
                </SELECT>
                --> step "%value destStep%" <BR>
        %endloop%
        
    %endloop%
    
    <BR>
    <BR>
    <BR>
    <BR>
    <INPUT TYPE="SUBMIT" VALUE="Save">
    
</FORM>

</body>
</html>
%endinvoke%
