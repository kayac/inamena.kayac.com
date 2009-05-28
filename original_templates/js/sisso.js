/**
 * sisso.js - 質素なWeb制作のためのJS
 *
 * Copyright (C) KAYAC Inc. | http://www.kayac.com/
 * Dual licensed under the MIT <http://www.opensource.org/licenses/mit-license.php>
 * and GPL <http://www.opensource.org/licenses/gpl-license.php> licenses.
 * Date: 2009-03-09
 * @author kyo_ago <http://tech.kayac.com/archive/iepngfix-library-sisso-js.html>
 * @version 1.0.9
 *
 * thanks from
 *   http://www.isella.com/aod2/js/iepngfix.js
 *   http://jquery.com/
 *   http://kyosuke.jp/portfolio/javascript/yuga.html
 *   http://webtech-walker.com/archive/2008/11/02151611.html
 *   http://code.google.com/p/uupaa-js/source/browse/trunk/src/ieboost.js
 */
;new function () {
	var name_space = 'Sisso';
	var self = window[name_space] || {};
	window[name_space] = self;

	var Event, $ = window.jQuery;
	if (!window.jQuery) {
		load_lib();
		$ = function () {};
		$.data = function () {};
		$.removeData = function () {};
		self.Event = Event;
	};

	var $d = document;

	new function () {
		var scp = $d.getElementsByTagName('script');
		var reg = new RegExp(name_space + '\\.js');
		var i = scp.length;
		while (i--) {
			if (!reg.test(scp[i].src.toLowerCase())) continue;
			var sp = scp[i].src.split('#');
			if (sp.length === 1) return;
			var pair = sp.pop().split(/[&;]+/);
			var j = pair.length;
			while (j--) {
				var k_v = pair[j].split('=');
				self[k_v[0]] = k_v[1];
			}
			return;
		}
	};

	self.blankUrl = self.blankUrl || 'http://tech.kayac.com/data/iepngfix-library-sisso-js/blank.gif';
	self.overClass = self.overClass || 'btn';
	self.externalClass = self.externalClass || 'external';
	self.breakAllClass = self.breakAllClass || 'wordBreak';
	self.noRoll = self.noRoll || false;
	self.noFix = self.noFix || false;
	self.noExternal = self.noExternal || false;
	self.noBreakAll = self.noBreakAll || false;

	self.get_elems = (function () {
		if ($d.getElementsByClassName) return function (cname) {
			return $d.getElementsByClassName(cname);
		}
		if ($d.querySelectorAll) return function (cname) {
			return $d.querySelectorAll('*.' + cname);
		}
		if ($d.evaluate) return function (cname) {
			var elems = $d.evaluate("descendant::*[@class=" + cname + " or contains(concat(' ', @class, ' '), ' " + cname + " ')]", $d, null, 7, null);
			var result = [];
			for (var i = 0, l = elems.snapshotLength; i < l; result.push(elems.snapshotItem(i++)));
			return result;
		}
		return function (cname) {
			var reg = new RegExp('(?:^|[ \\n\\r\\t])' + cname + '(?:[ \\n\\r\\t]|$)');
			var elems = $d.body.getElementsByTagName('*');
			var result = [];
			for (var i = 0, l = elems.length; i < l; ++i) {
				var elem = elems[i];
				if (elem.className.indexOf(cname) === -1) continue;
				if (!reg.test(elem.className)) continue;
				result.push(elem);
			}
			return result;
		};
	})();

	self.get_src = function (elem) {
		if (elem.src) return elem.src;
		src = (elem.currentStyle || $d.defaultView.getComputedStyle(elem, '')).backgroundImage;
		return (src.match(/^url\((["']?)(.*\.png)\1\)$/i) || [undefined]).pop();
	};

	self.hover = function (elem) {
		var src = self.get_src(elem);
		var over = self.replace_over(src);
		return elem.src ? self.add_src_over(elem, src, over) : self.add_bg_over(elem, src, over);
	};

	self.replace_over = function (src) {
		return src.replace(/(?:_o)?(\.\w+)$/, '_o$1');
	};

	new function () {
		self.bind = window.jQuery ? _jq : window.addEventListener ? _add : _on;

		function _jq (target, type, listener) {
			$(target).bind(type + '.' + name_space, listener);
		};
		function _add (target, type, listener) {
			target.addEventListener(type, listener, false);
		};
		function _on (target, type, listener) {
			target.attachEvent('on' + type, listener);
		};
	};

	self.add_src_over = function (elem, src, over) {
		var img = new Image();
		img.src = over;
		self.bind(elem, 'mouseover', (function (target) {
			return function () {
				target.src = over;
			};
		})(elem));
		self.bind(elem, 'mouseout', (function (target) {
			return function () {
				target.src = src;
			};
		})(elem));
	};

	self.add_bg_over = function (elem, src, over) {
		(new Image()).src = over;
		self.bind(elem, 'mouseover', (function (target) {
				return function () {
				target.style.backgroundImage = 'url(' + over + ')';
			};
		})(elem));
		self.bind(elem, 'mouseout', (function (target) {
			return function () {
				target.style.backgroundImage = 'url(' + src + ')';
			};
		})(elem));
	};

	self.exec_hover = function () {
		self.bind(window, 'load', function () {
			var elems = self.get_elems(self.overClass);
			for (var i = 0, l = elems.length; i < l; self.hover(elems[i++]));
		});
	};

	self.exec_external = function () {
		self.bind(window, 'load', function () {
			var elems = self.get_elems(self.externalClass);
			for (var i = 0, l = elems.length; i < l; elems[i++].target = '_blank');
		});
	};

	self.exec_break_all = function () {
		var userAgent = navigator.userAgent;
		var splitter = userAgent.indexOf(' Gecko/') !== -1 && userAgent.indexOf('; rv:1.8.1') !== -1 ? '<wbr/>' : String.fromCharCode(8203);
		var split_text_node = function (elem) {
			var elems = elem.childNodes;
			var child = [];
			var i = 0;
			var len = elems.length;
			while (i < len) {
				child[i] = elems[i++];
			}
			for (i = 0, len = child.length; i < len; ++i) {
				var self = child[i];
				if (self.nodeType === 1) {
					if (self.childNodes && self.childNodes.length) arguments.callee(self);
					continue;
				}
				var val = self.nodeValue;
				if (!val || /^[ \n\r\t]*$/.test(val)) continue;
				var div = $d.createElement('div');
				div.innerHTML = val.split('').join(splitter);
				var parent = self.parentNode;
				while (div.firstChild) parent.insertBefore(div.removeChild(div.firstChild), self);
				parent.removeChild(self);
			}
		};
		if (userAgent.indexOf('Mozilla/4.0 (compatible; MSIE ') === 0 && userAgent.toLowerCase().indexOf('opera') === -1) {
			split_text_node = function (elem) {
				elem.style.wordBreak = 'break-all';
			};
		}

		var exec = function () {
			var elems = self.get_elems(self.breakAllClass);
			for (var i = 0, l = elems.length; i < l; split_text_node(elems[i++]));
		};
		window.jQuery ? $(exec) : Event.domReady.add(exec);
	};

	if (!self.noExternal) self.exec_external();
	if (!self.noBreakAll) self.exec_break_all();

	if (!/^Mozilla\/4\.0 \(compatible; MSIE (?:5\.5|[67]\.)/.test(navigator.userAgent)) {
		if (!self.noRoll) self.exec_hover();
		return;
	}

//-----------------------------------
// for old IE only
//-----------------------------------

	self.eid = '_' + name_space + '_src';

	self.store = function (elem, val) {
		return val ? elem[self.eid] = val : elem[self.eid];
	};

	self.hover = function (elem) {
		var src = elem[self.eid] || (elem[self.eid] = self.get_src(elem));
		var over = self.replace_over(src);
		return elem.src ? self.add_src_over(elem, src, over) : self.add_bg_over(elem, src, over);
	};

	self.set_width = function (elem) {
		var cur = elem.currentStyle;
		if (cur.width !== 'auto' || cur.height !== 'auto') return;
		elem.style.width = elem.offsetWidth + 'px';
	};

	self.fix = function (elem) {
		elem.runtimeStyle.behavior = 'none';
		var src = elem[self.eid] || (elem[self.eid] = self.get_src(elem));
		if (!src) src = elem.src;
		if (!src || !/\.png$/.test(src.toLowerCase())) return;
		self.set_width(elem);
		if (elem.src) elem.src = self.blankUrl;
		if (!elem.style.zoom && elem.style.zoom !== '0') elem.style.zoom = 1;
		self.swap(elem, src);
		if (!elem.src) self.fix_bg_elem(elem);
		self.bind(elem, 'propertychange', function () {
			propertychange.apply(this, arguments);
		});

		function propertychange () {
			var env = window.event;
			var target = env.srcElement;
			if (window.jQuery) target = this;
			var tmp = propertychange;
			propertychange = function () {};
			new function () {
				if (target.src) {
					if (target.src === self.blankUrl) return;
					self.swap(target, target.src);
					target[self.eid] = target.src;
					target.src = self.blankUrl;
					return;
				}
				var src = self.get_src(target);
				if (!src) return;
				self.swap(target, src);
				target.style.backgroundImage = 'none';
				target[self.eid] = src;
			};
			propertychange = tmp;
		};
	};

	self.fix_bg_elem = function (elem) {
		elem.style.backgroundImage = 'none';
		self.set_pos(elem);
		(elem.tagName.toUpperCase() === 'A') && (elem.style.cursor = elem.style.cursor || 'pointer');
		var unclickable = ({'relative':1,'absolute':1})[(elem.currentStyle.position || '').toLowerCase()];
		var msg = '\n\n<' + elem.nodeName + (elem.id && ' id="' + elem.id) + '">';
		(function (elems) {
			if (!elems.length) return;
			if (unclickable) return alert(name_space + ': Unclickable children' + msg);
			for (var i = 0, n = elems.length; i < n; ++i) {
				var elem = elems[i];
				if (!elem.style) continue;
				if (elem.style.position) continue;
				elem.style.position = 'relative';
alert(elem.style.position);
			}
		})(elem.getElementsByTagName('a'));
	};

	self.set_pos = function (elem) {
		var tags = ['input', 'textarea', 'select'];
		var set = function (nodes, cursor) {
			for (var i = nodes.length, node; node = nodes[--i];) {
				var style = node.style;
				!style.position && (style.position = 'relative');
				if (!cursor) continue;
				!style.cursor && (style.cursor = cursor);
			}
		};
		while (tags.length) set(elem.getElementsByTagName(tags.pop()));
		set(elem.getElementsByTagName('a'), 'pointer');
	};

	self.swap = function (elem, src) {
		if (src === self.blankUrl) return;
		var sizing = (elem.currentStyle.backgroundRepeat === 'no-repeat') ? 'crop' : 'scale';
		var al = 'DXImageTransform.Microsoft.AlphaImageLoader';
		if (elem.filters.length && al in elem.filters) {
			elem.filters[al].enabled = 1;
			elem.filters[al].src = src;
			return;
		}
		elem.style.filter = 'progid:' + al + '(src="' + src + '",sizingMethod="' + sizing + '");';
	};

	self.exec_pngfix = function () {
		var exp = 'expression(' + name_space + '.fix(this));';
		var div = $d.createElement('div');
		div.innerHTML = ([
			'div<div><style type="text/css">',
				'img, input { behavior : ' + exp + ' };',
				'.bgpng { behavior : ' + exp + ' };',
			'</style></div>'
		]).join('');
		$d.getElementsByTagName('head')[0].appendChild(div.getElementsByTagName('style')[0]);
	};

	if (!self.noRoll) self.exec_hover();
	if (!self.noFix) self.exec_pngfix();

	function load_lib () {
		/**
		 * domready.js
		 * 
		 * Copyright (c) 2007 Takanori Ishikawa.
		 * License: MIT-style license.
		 * 
		 * MooTools Copyright:
		 * copyright (c) 2007 Valerio Proietti, <http://mad4milk.net>
		 * http://www.metareal.org/2007/07/10/domready-js-cross-browser-ondomcontentloaded/
		 * http://snipplr.com/view/6029/domreadyjs/
		 */
		if(typeof Event=="undefined"){Event=new Object()}Event.domReady={add:function(b){if(Event.domReady.loaded){return b()}var e=Event.domReady.observers;if(!e){e=Event.domReady.observers=[]}e[e.length]=b;if(Event.domReady.callback){return}Event.domReady.callback=function(){if(Event.domReady.loaded){return}Event.domReady.loaded=true;if(Event.domReady.timer){clearInterval(Event.domReady.timer);Event.domReady.timer=null}var j=Event.domReady.observers;for(var f=0,h=j.length;f<h;f++){var g=j[f];j[f]=null;g()}Event.domReady.callback=Event.domReady.observers=null};var d=!!(window.attachEvent&&!window.opera);var a=navigator.userAgent.indexOf("AppleWebKit/")>-1;if(document.readyState&&a){Event.domReady.timer=setInterval(function(){var f=document.readyState;if(f=="loaded"||f=="complete"){Event.domReady.callback()}},50)}else{if(document.readyState&&d){var c=(window.location.protocol=="https:")?"://0":"javascript:void(0)";document.write('<script type="text/javascript" defer="defer" src="'+c+'" onreadystatechange="if (this.readyState == \'complete\') '+name_space+'.Event.domReady.callback();"><\/script>')}else{if(window.addEventListener){document.addEventListener("DOMContentLoaded",Event.domReady.callback,false);window.addEventListener("load",Event.domReady.callback,false)}else{if(window.attachEvent){window.attachEvent("onload",Event.domReady.callback)}else{var b=window.onload;window.onload=function(){Event.domReady.callback();if(b){b()}}}}}}}};
	};
};
