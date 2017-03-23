/**
 * @author mgunasek
 */

$(function() {

    //make an Ajax POST call to get the list of aliases for the chosen keystore
    $("select[name='pg.keystore.keyStoreHandle']").bind('change', function() {
        var sel = this.options[this.selectedIndex].text;

        $('div#busy').css('display', 'inline');   //show busy

        $.post("getAliases.dsp",
        {
            "action": "getAliases",
            "keyStore": sel
        }, function(data) {
            $("select[name='pg.rampartdeploymenthandler.signingCertAlias']").html(data);
            $('div#busy').css('display', 'none');   //hide busy
        });
    });

    $('div#busy').hide(); //initially hidden

    $('input[name=pg.lb.http.url]').change(function() {
        var result = validateUrl(this);
        updateSave(result);
    });

    $('input[name=pg.lb.https.url]').change(function() {
        var result = validateUrl(this);
        updateSave(result);
    });

    //bind the click handlers for Add and Remove links
    $('a#addHttp').click(function(e) {
        return !$('#availableHttpPorts :selected').remove().appendTo($('#selectedHttpPorts'));
    });
    $('a#removeHttp').click(function(e) {
        updateSelectedHttpPorts();
    });

    $('a#addHttps').click(function(e) {
        return !$('#availableHttpsPorts :selected').remove().appendTo($('#selectedHttpsPorts'));
    });
    $('a#removeHttps').click(function(e) {
        return !$('#selectedHttpsPorts :selected').remove().appendTo($('#availableHttpsPorts'));
    });

    //select all unselected values in the right select box - only selected values are sent to server
    $('#btnSubmit').click(function() {
        $('#selectedHttpPorts :not(option[selected])').attr('selected', 'selected');
        $('#selectedHttpsPorts :not(option[selected])').attr('selected', 'selected');
        
        //if there are no https ports selected, send an empty value
        if ($('#selectedHttpsPorts option').length == 0) {
            $('#selectedHttpsPorts').after("<input type='hidden' name='pg.https.ports' value=''/>");
        }
    });

    //bind the dblclick handler for the select options
    moveOnDblClick('#availableHttpPorts', '#selectedHttpPorts');
    moveOnDblClick('#availableHttpsPorts', '#selectedHttpsPorts');
    moveOnDblClick('#selectedHttpPorts', '#availableHttpPorts');
    moveOnDblClick('#selectedHttpsPorts', '#availableHttpsPorts');

});

function moveOnDblClick(src, target) { 
    $(src).dblclick(function(e) {
        //move non-primary ports only
        $(src + " option:selected").not($(".primary")).remove().appendTo($(target));
    });
}

function updateSelectedHttpPorts() {

    var selectedPorts = $('#selectedHttpPorts').val().join(",");
    //get the primary http port
    $.post("getPrimaryPort.dsp",
            function(data) {
	        var port = $.trim(data);
                if (selectedPorts.indexOf(port) != -1) {
                    var key = "port.remove.error";
					var msg = getmsg(key, port);
					document.getElementById("primaryPort-remove-error").innerHTML = "<div class=\"message\"><span>"+msg+"</span></div>";
                    var selector = "#selectedHttpPorts option:contains('" + port + "')";
                    $(selector).removeAttr('selected');
                }

                $('#selectedHttpPorts option:selected').remove().appendTo($('#availableHttpPorts'));

            });
}

function validateUrl(urlEl) {
    var result = true;
    //var urlPattern = /https?:\/\/[\w\d\.-]{3,}:\d{2,5}/;
	var urlPattern = /https?:\/\/[\w\d\.-]{3,}/;

    if (urlEl != undefined && urlEl != null) {
        //reset the field first
        $(urlEl).removeClass('invalid');
        $(urlEl).next('span').remove();

        var val = $(urlEl).val();
        if (val.length > 0 && (val.search(urlPattern) == -1)) {
            result = false;
            $(urlEl).addClass('invalid');
            var msg = getmsg("url.invalid");
            $(urlEl).after("<span>" + msg + "</span>");
        }
    }
    return result;
}