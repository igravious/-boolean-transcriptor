/* SimpleTreeMenu v1.2.5 */

/* to stop http://jsfiddle.net/ complaining
var jQuery;
var window;
*/

(function ($) {
	"use strict";

	/* private stuff */
	var prv = {

		localStorageKeyPrefix: "jQuery-simpleTreeMenu-treeState-",

		hasLocalStorage: function () {
			// https://developer.mozilla.org/en/DOM/Storage
			if (window.localStorage && window.localStorage.setItem && window.localStorage.getItem) {
				return true;
			} else {
				return false;
			}
		},

		localStorageKey: function () {
			return prv.localStorageKeyPrefix + $(this).attr("id");
		}
		
		// for cookies: https://github.com/carhartl/jquery-cookie

	}, methods = {

		init: function (options) {
			return this.each(function () {
				var $this = $(this);
				if ($this.hasClass("simpleTreeMenu") === false) {
                    console.log("setting up simpleTreeMenu");
					$this.hide();
					$(this).addClass("simpleTreeMenu");
					$this.children("li").each(function () {
						methods.buildNode($(this), options);
					});
					$(this).show();
				} else {
                    console.log("already set up, not bothering");
                }
			});
		},

		buildNode: function ($li, options) {
			if ($li.children("ul").length > 0) { // nested ul
				$li.children("ul").hide();

				var $how_many = 0;
				$li.children("ul").children("li").each(function () {
					$how_many += 1;
					methods.buildNode($(this), options);
				});

				$li.addClass("Node");
				if ($how_many > 0) {
					$li.click(function (event) {
						var self = $(this);
                        var $target = $(event.target);
                        //if (self.attr('id')==$target.attr('id')) {
						    if (self.hasClass("expanded")) {
							    self.removeClass("expanded");
							    self.children("ul").hide();
						    } else {
							    self.addClass("expanded");
							    self.children("ul").show();
						    }
                        //}
                        console.log("node event stop");
                        console.log(this);
                        console.log(event.target);
                        return false;

						//event.stopPropagation();
                        //return true;
					});
				} else { /* i no longer understand this use-case
					// do not show arrow-head if no leaves
					$li.addClass(blank?"EmptyBlank":"EmptyDot").click(function (event) {
                        console.log("node empty event stop");
                        console.log(this);
                        console.log(event.target);
						//return false;
                        
                        //event.stopPropagation();
                        //return true;
					});
                    */
				}

			} else {
				$li.addClass("Leaf").click(function (event) { // non-nested ul
						    var self = $(this);
						    if (self.hasClass("leaf_opened")) {
							    self.removeClass("leaf_opened");
							    //self.children("ul").hide();
						    } else {
							    self.addClass("leaf_opened");
							    //self.children("ul").show();
						    }
                    console.log("leaf event stop");
                    //console.log(this);
                    //console.log(event.target);
                    if (options && options.callback) {
                        var callback = options.callback
                        return callback(this, event);
                    } else {
					    //return false;
                        
                        event.stopPropagation();
                        return true;
                    }
				});
			}
		},

		/* helpers */

		/* maintaining state */

		arrayify: function () {
			var state = [];
			$('.Node, .Leaf', $(this)).each(function (index) {
				state[index] = $(this).hasClass("expanded");
			});
			//console.log(state);
			return state;
		},

		fromArray: function (state) {
			state = state.split(",");
			var nodes = $('.Node, .Leaf', $(this));
			if (state.length !== nodes.length) {
				return;
			}
			return JSON.parse(state, function (key, value) {
				if (value && typeof value === 'boolean') {
					$(nodes[key]).addClass("expanded").children("ul").show();
				}
			});
		},

		toLocalStorage: function (state) {
			if (prv.hasLocalStorage() === true) {
				window.localStorage.setItem(prv.localStorageKey.apply(this), state);
			}
		},

		fromLocalStorage: function () {
			if (prv.hasLocalStorage() === true) {
				return window.localStorage.getItem(prv.localStorageKey.apply(this));
			}
			return null;
		},

		toCookieJar: function (state) {
			$.cookie(prv.localStorageKeyPrefix, state, { expires: 10 });
		},

		fromCookieJar: function () {
			return $.cookie(prv.localStorageKeyPrefix);
		},

		serialize: function (storage) {
			var state = methods.arrayify.apply(this);
			state = JSON.stringify(state);
			if (storage === "cookie") {
				methods.toCookieJar.call(this, state);
			} else if (storage === "html5") {
				methods.toLocalStorage.call(this, state);
			}
		},

		deserialize: function (storage) {
			var state;
			if (storage === "cookie") {
				state = methods.fromCookieJar.apply(this);
			} else if (storage === "html5") {
				state = methods.fromLocalStorage.apply(this);
			}
			if (state !== null) { methods.fromArray.call(this, state); }
		},

		/* opening and closing operations */

		expandToNode: function ($li) {
			if ($li.parent().hasClass("simpleTreeMenu")) {
				if (!$li.hasClass("expanded")) {
					$li.addClass("expanded");
					$li.children("ul").show();
				}
			}
			$li.parents("li", "ul.simpleTreeMenu").each(function () {
				var $t = jQuery(this);
				if (!$t.hasClass("expanded")) {
					$t.addClass("expanded");
					$t.children("ul").show();
				}
			});
		},

		expandAll: function () {
			jQuery(this).find("li.Node").each(function () {
				var $t = jQuery(this);
				if (!$t.hasClass("expanded")) {
					$t.addClass("expanded");
					$t.children("ul").show();
				}
			});
		},

		closeAll: function () {
			jQuery("ul", jQuery(this)).hide();
			var $li = jQuery("li.Node");
			if ($li.hasClass("expanded")) {
				$li.removeClass("expanded");
			}
		}

	};

	/* kick start */

	$.fn.simpleTreeMenu = function (method) {
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
	    } else if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
	    } else {
			$.error('Method ' +  method + ' does not exist on jQuery.simpleTreeMenu');
	    }
	};

}(jQuery));
