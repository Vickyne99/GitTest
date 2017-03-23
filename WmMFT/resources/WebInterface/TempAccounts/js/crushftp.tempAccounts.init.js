/*!
* CrushFTP Web GUI Initial events
*
* Copyright @ SoftwareAG
*
*/

$(document).ready(function(){
	$(".tabs").tabs();
	crushFTP.UI.initLoadingIndicator();
	crushFTP.userLogin.bindUserName(function (response, username) {
		crushFTP.UI.showLoadingIndicator({});
		$("#tempAccounts").form();
		css_browser_selector(navigator.userAgent);
		$(".button").button();
		if (response == "failure") {
			window.location = "/WebInterface/login.html?link=/WebInterface/TempAccounts/index.html";
		} else {
			tempAccounts.methods.initGUI();
		}
	});
});

function doLogout()
{
	var rndm = crushFTPTools.getToken();
	$.ajax({type: "POST",url: "/WebInterface/function/",data: {command: "logout",random: rndm},
		error: function (XMLHttpRequest, textStatus, errorThrown)
		{
			$.cookie("CrushAuth", "", {path: '/',expires: -1});
			document.location = "/WebInterface/login.html";
		},
		success: function (msg)
		{
			$.cookie("CrushAuth", "", {path: '/',expires: -1});
			document.location = "/WebInterface/login.html";
		}
	});
	return false;
}