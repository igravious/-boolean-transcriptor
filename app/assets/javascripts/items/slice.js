/*
 * this took me a week to figure out
 *
 * because the expanding/collapsing tree stops event propagation
 * the ajax trigger wasn't firing. so you need to create a callback
 * and call handleRemote() with the target explicitly. i then return
 * false to both stop propogation (event bubbling) and also to prevent
 * the default from happening (because it's on a link_to) - an
 * alternative here would be to wire up a div but this is simpler
 */
var handleRemote = function(el, event) {
    // is, ahem, this different from
    console.log("handleRemote: $(this)");
    console.log($(this));
    // um, this?
    console.log("v1: $(el)");
    console.log($(el));
    // why yes it is ...
    
    target = event.target;
    console.log("v2: event");
    console.log(event);
    console.log("v3: $(target)");
    console.log($(target));
    console.log("v4: $(target).data('remote')");
    console.log($(target).data('remote'));
    if ($(target).data('remote')) {
        $.rails.handleRemote($(target));
        return false;
    } else {
        event.stopPropagation();
        return true;
    }
};

/*
 * style the tree: deserialize on load, serialize on unload
 */
var handleSimpleTreeMenu = function() {
    console.log('i am ready or loaded - items/slice.js');
    if ($(".items_tree").length>0) { // are there nested ul?
        console.log("gotcha");
        try {
            $(".items_tree").simpleTreeMenu({callback: handleRemote});
            $(".items_tree").simpleTreeMenu('deserialize', 'cookie'); // session cookie or other?
            $(window).unload(function() {
                    $(".items_tree").simpleTreeMenu('serialize', 'cookie');
            });
        } catch(oops) {
            console.log("why on earth is simple tree menu not loaded? ")
            console.log(oops.message+" from "+oops.stack);
			Bugsnag.notifyException(oops, "Unexpected Error");
        }
    // if there's any kind of slider (of Thumbnail Scans of an Item
    // or Thumbnail Items of an Item Group/Collection ) on the page wrapped
    } else if ($('.slide-wrapper').length ) {
        try {
            doSlider();
        } catch(oops) {
            // let the member know somehow
            console.log('oopsie in doSlider() in items/slice.js unfortunately');
            console.log(oops.message+" from "+oops.stack);
			Bugsnag.notifyException(oops, "Unexpected Error");

        }
    } else if ($('.preview-container').length ) {
        try {
            doLazy();
        } catch(oops) {
            // let the member know somehow
            console.log('oopsie in doLazy() in items/slice.js unfortunately');
            console.log(oops.message+" from "+oops.stack);
			Bugsnag.notifyException(oops, "Unexpected Error");

        }
    } else {
        console.log("no .items_tree or .slide-wrapper or .preview-container found by slice.js");
    }

    // bind to all classes of ajax triggers, should be in dev mode only
    $(".ajax_trigger").bind("ajax:success", function(evt, data, status, xhr){
        console.log('.ajax_trigger success'); //console.log(data);      
        console.log(xhr.responseText);      
        console.log(evt);      
    }).bind("ajax:error", function(evt, data, status, xhr){
        console.log(data);      
        console.log(xhr.responseText);      
        console.log(evt);      
        alert("Something tragic happened - "+xhr.responseText);
		Bugsnag.notify("Ajax Error, xhr.responseText);
    });

    return true;
};

$(document).bind('ready', handleSimpleTreeMenu);
//$(document).on('page:load', handleSimpleTreeMenu);

var pretendWasClicked = function(el_id) {
    // safe selector
    var selector_id = 'a[id="'+el_id+'"]'
    // proof
    console.log("clicky 1: selector_id");
    console.log(selector_id);

    // select it so
    var gotcha = $(selector_id);
    // proof
    console.log("clicky 2: gotcha = $(selector_id)");
    console.log(gotcha);
    gotcha.click();
}

var track_clicks=Array(); // use classes

var wasClicked = function() {}

