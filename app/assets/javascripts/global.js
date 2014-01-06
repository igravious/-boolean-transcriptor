/*
 * our default slider - a horizontal carousel
 *
 * deprecated for simpler overflowed div solution
 */
var doSlider = function() {
    $('.slide-wrapper').bxSlider({
        slideWidth: 100,
        slideMargin: 33,
        minSlides: 1,
        maxSlides: 6,
        captions: true,
        pagerType: 'short'
    });
}

/*
 * our default to lazily load images
 * in all containers in the page
 */
var doLazy = function() {
    $('.items_preview_container').each(function(){
        $("img.lazy").lazyload({
            effect : "fadeIn",
            container: this
        });
    });
}

var doZoomer = function() {
    
}


var unescapeHTML = function(unsafe) {
    return unsafe
        .replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")
        .replace(/&quot;/g, "\"")
        .replace(/&#039;/g, "'")
        .replace(/&#39;/g, "'");
}
