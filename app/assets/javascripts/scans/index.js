var slide_it = function() {
    console.log('i am ready or loaded - scans/index.js');
    try {
        // check if it's there, paranoia mode
        if ($('.slide-wrapper').length ) doSlider();
    } catch(oops) {
        // let the member know somehow
        console.log('oopsie in scans/index.js unfortunately');
        console.log(oops.message+" from "+oops.stack);
		Bugsnag.notifyException(oops, "Unexpected Error");
    }

    return true;
};

//$(document).on('ready', slide_it);
$(document).bind('page:load', slide_it);

