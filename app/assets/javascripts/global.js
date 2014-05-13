/*
 * our default slider - a horizontal carousel
 *
 * deprecated for simpler overflowed div solution
 */
var doSlider = function() {
    // inf is broken :(
    $('.slide-wrapper').bxSlider({
        slideWidth: 100,
        infiniteLoop: false,
        slideMargin: 2,
        minSlides: 6,
        maxSlides: 6,
        moveSlides: 5,
        captions: true,
        pagerType: 'short'
    });
};

/*
 * our default to lazily load images
 * in all containers in the page
 */
var doLazy = function() {
    $('.preview-container').each(function(){
        $("img.lazy").lazyload({
            effect : "fadeIn",
            container: this
        });
    });
};

var doZoomer = function() {
    
};


var unescapeHTML = function(unsafe) {
    return unsafe
        .replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")
        .replace(/&quot;/g, "\"")
        .replace(/&#039;/g, "'")
        .replace(/&#39;/g, "'");
};

// https://stackoverflow.com/questions/8909557/how-to-overwrite-a-builtin-method-of-javascript-native-objects

var base = console.log;
console.log = function() {
    // base.apply(this, {"should only be enabled in dev mode"});
    return base.apply(this, arguments);
};

// https://stackoverflow.com/questions/9338439/how-to-chain-functions-without-using-prototype
