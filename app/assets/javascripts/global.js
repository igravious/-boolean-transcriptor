/*
 * our default slider - a horizontal carousel
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

var doLazy = function() {
    $('.item_container').each(function(){
        $("img.lazy").lazyload({
            effect : "fadeIn",
            container: this
        });
    });
}

function unescapeHTML(unsafe) {
    return unsafe
        .replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")
        .replace(/&quot;/g, "\"")
        .replace(/&#039;/g, "'")
        .replace(/&#39;/g, "'");
}
