// included by transcriptions#show or something like that

var zoom_zoom = function() {
    console.log('i am ready - transcriptions/edit.js');
    try {
        // extra paranoid mode
        if ($('.viewer').length ) $(".viewer").zoomer({
            snapFn: zoom_callback
        });
    } catch(oops) {
        // communicate to the user somehow
        console.log('oopsie in transcriptionis/edit.js unfortunately');
        console.log(oops+oops.message);
    }

    return true;
}

var zoom_it = function() {
    console.log('i am ready - transcriptions/edit.js');
    try {
        // extra paranoid mode
        if ($('#zoom_it').length ) $("#zoom_it").elevateZoom({
            scrollZoom: true,
           loadingIcon: '/assets/images/bx_loader.gif',
           easing: true,
           zoomWindowWidth: 600,
           tint: true, 
           tintColour: '#09E', 
           tintOpacity: 0.5
        });
    } catch(oops) {
        // communicate to the user somehow
        console.log('oopsie in transcriptionis/edit.js unfortunately');
        console.log(oops+oops.message);
    }

    return true;
};

$(document).on('ready', zoom_it);
$(document).on('page:load', zoom_it);

$(document).on('ready', zoom_zoom);
$(document).on('page:load', zoom_zoom);

var add_tab = function() {
    alert("if you click me again i'll break your face");
}

var zoom_callback = function(data) {
    console.log(data);

    var tiw = data.targetImageWidth;
    var tih = data.targetImageHeight;
    var til = data.targetImageLeft;
    var tit = data.targetImageTop;
    var tpl = data.targetPositionerLeft;
    var tpt = data.targetPositionerTop;
    var fw = data.frameWidth;
    var fh = data.frameHeight;
    var nw = data.naturalWidth;
    var nh = data.naturalHeight;

    var scale = Math.round((tiw/nw)*1000); // not sure why i round it
    var ratio = scale/1000;
    console.log(ratio);
    if (scale > 833) { // geez, 1% is not enough
        save_coords(ratio, tiw, tih, fw, fh, nw, nh, til, tit, tpl, tpt);
    } else {
        alert("Unable to take snapshot, not zoomed in enough");
    }
}

var num_times = 0;
var save_coords = function(ratio, tiw, tih, fw, fh, nw, nh, til, tit, tpl, tpt) {

    var note_id = "note"+num_times;
    // $( "<p>"+num_times+": "+ratio+"</p><div id="+note_id+"></div>" ).insertAfter( "#notes" );
    var request = $.ajax({
      url: "/portion_of_image/"+img_id,
      type: "POST",
      data: { note_id: note_id, ratio: ratio, tiw: tiw, tih: tih, fw: fw, fh: fh, nw: nw, nh: nh, til: til, tit: tit, tpl: tpl, tpt: tpt },
      dataType: "json"
    });
     
    request.done(function( msg ) {
      // $( "#"+msg.note_id ).html( msg.note_msg );
      $( msg.note_msg ).insertAfter( "#insert_after_me" );
    });
     
    request.fail(function( jqXHR, textStatus ) {
      alert( "Request failed: " + textStatus );
    });
    num_times += 1;
}

var transcription_has_changed = function() {
    return ($('#scan_transcription').val()) != unescapeHTML(original_transcription);
}

var need_to_confirm = true;
var confirm_exit = function() {
    if (need_to_confirm && transcription_has_changed())
        return "You have attempted to leave the transcription page.  If you have made any changes to the transcription without clicking the Update button, your changes will be lost.  Are you sure you want to exit this page?";
}

$(window).on('beforeunload', confirm_exit);
