// included by transcriptions#show

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

var transcription_has_changed = function() {
    return ($('#scan_transcription').val()) != unescapeHTML(original_transcription);
}

var need_to_confirm = true;
var confirm_exit = function() {
    if (need_to_confirm && transcription_has_changed())
        return "You have attempted to leave the transcription page.  If you have made any changes to the transcription without clicking the Update button, your changes will be lost.  Are you sure you want to exit this page?";
}

$(window).on('beforeunload', confirm_exit);
