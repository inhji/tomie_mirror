// AwesompleteUtil - Nico Hoogervorst - MIT license
var AwesompleteUtil=function(){function e(e){var t=Array.isArray(e)?{label:e[0],value:e[1]}:"object"==typeof e&&"label"in e&&"value"in e?e:{label:e,value:e};return{label:t.label||t.value,value:t.value}}function t(e,t,n){return F.fire(e,t,{detail:n})}function n(n,r){var i,l,a,u,o=n.input,p=o.classList,s=n.utilprops,c=s.selected,v=s.convertInput.call(n,o.value),d=n.opened,f=[],h=n._list;if(s.prepop=!1,h){for(u=0;u<h.length;u++)if(a=h[u],i=e(n.data(a,v)),0===n.maxItems&&(i.toString=function(){return""+this.label},n.filter(i,v)&&(d=!0)),l={input:{value:""}},n.replace.call(l,i),s.convertInput.call(n,l.input.value)===v){if(c&&c.value===i.value&&c.label===i.label){f=[a];break}f.push(a)}s.prevSelected!==f&&(f.length>0?r?t(o,I,f):s.changed&&(s.prevSelected=f,p.remove(j),p.add(w),t(o,k,f)):r?t(o,I,[]):s.changed&&(s.prevSelected=[],p.remove(w),d&&o===document.activeElement?p.remove(j):v.length>0&&(p.add(j),t(o,k,[]))))}}function r(e){var t=this;e.type!==A&&e.type!==E&&"blur"!=e.type||e.target!==t.input||n(t,t.utilprops.prepop&&e.type===E)}function i(e){var t=this;e.target===t.input&&9===e.keyCode&&t.select()}function l(e){var t=this;t.utilprops.changed=!0,t.utilprops.selected=e.text}function a(e){return 0===Object.keys(e).length&&e.constructor===Object}function u(e,t,n){var r=e.utilprops;return!r.a||!r.loadall&&0===t.lastIndexOf(n,0)&&(0!==t.lastIndexOf(r.a,0)||"number"==typeof r.limit&&e._list.length>=r.limit)}function o(e,n,r){e.list=n,e.utilprops.a=r,t(e.input,E,r)}function p(){var e,t,n=this,r=n.b,i=n.c,l=n.queryVal,p=r.utilprops.val;if(200===i.status){if(e=JSON.parse(i.responseText),r.utilprops.convertResponse&&(e=r.utilprops.convertResponse(e)),!Array.isArray(e))if(0===r.utilprops.limit||1===r.utilprops.limit)e=a(e)?[]:[e];else for(t in e)if(Array.isArray(e[t])){e=e[t];break}Array.isArray(e)&&u(r,p,l)&&o(r,e,l||r.utilprops.loadall)}}function s(e,t){var r;e.utilprops.url&&u(e,t,t)?(r=new XMLHttpRequest,e.utilprops.ajax.call(e,e.utilprops.url,e.utilprops.urlEnd,e.utilprops.loadall?"":t,p.bind({b:e,c:r,queryVal:t}),r)):n(e,e.utilprops.prepop)}function c(e){var n=e.input,r=n.classList;r.remove(j),r.remove(w),t(n,k,[])}function v(e,t,n){return e.utilprops.prepop=n||!1,e.utilprops.val!==t&&(e.utilprops.selected=null,e.utilprops.changed=!0,e.utilprops.val=t,(t.length<e.minChars||0==t.length)&&c(e),t.length>=e.minChars&&s(e,t)),e}function d(e){var t,n=this;e.target===n.input&&(t=n.utilprops.convertInput.call(n,n.input.value),v(n,t))}function f(e){return F.create("li",{innerHTML:e,"aria-selected":"false"})}function h(e){return e.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")}function m(e){var t,n,r=this,i=r.d,l=r.e,a=r.f;e.target===F(i)&&("function"==typeof a?a(e,l):(t=F(a),t&&t!==document.activeElement&&(n=Array.isArray(e.detail)&&1===e.detail.length?e.detail[0]:null,n=(l&&n?n[l]:n)||"","undefined"!=typeof t.value?(t.value=n,t.classList&&t.classList.remove&&t.classList.remove(j)):"undefined"!=typeof t.src?t.src=n:t.innerHTML=n)))}function b(e){var t,n,r=this;e.target===F(r.g)&&(e.preventDefault(),t=r.b,0===t.ul.childNodes.length||t.ul.hasAttribute("hidden")?(n=t.minChars,t.minChars=0,t.evaluate(),t.minChars=n):t.close())}function y(e,t,n){var r=F.regExpEscape(h(t).trim()),i=r.length<=0?null:n?RegExp("^"+r,"i"):RegExp("(?!<[^>]+?>)"+r+"(?![^<]*?>)","gi");return e.replace(i,"<mark>$&</mark>")}function g(e,t,n,r,i){var l,a=i.root,u=i.value,o=i.label||i.value,p=!0,s=[];if(0===r&&a&&n&&0!==(n+".").lastIndexOf(a+".",0)&&0!==(a+".").lastIndexOf(n+".",0))return e;if(Object(t)!==t)n?e[n]=t:e=t;else if(Array.isArray(t)){for(l=0;l<t.length;l++)s.push(g({},t[l],"",r+1,i));n?e[n]=s:e=s}else{for(l in t)p=!1,g(e,t[l],n?n+"."+l:l,r,i);p&&n&&(e[n]={})}return r<2&&n&&(u&&0===(n+".").lastIndexOf(u+".",0)&&(e.value=e[n]),o&&0===(n+".").lastIndexOf(o+".",0)&&(e.label=e[n])),0===r&&(!u||"value"in e||(e.value=null),!o||"label"in e||(e.label=null)),e}function C(){var e=this,t=e.b.input,n=e.h,r=e.i,i=e.j,l=e.k;t.removeEventListener(x,l),t.removeEventListener(E,n),t.removeEventListener(A,n),t.removeEventListener("blur",n),t.removeEventListener("input",r),t.removeEventListener("keydown",i)}var L="awesomplete-",E=L+"loadcomplete",A=L+"close",k=L+"match",I=L+"prepop",x=L+"select",w="awe-found",j="awe-not-found",F=Awesomplete.$;return{ajax:function(e,t,n,r,i){return i=i||new XMLHttpRequest,i.open("GET",e+encodeURIComponent(n)+(t||"")),i.onload=r,i.send(),i},convertInput:function(e){return"string"==typeof e?e.trim().toLowerCase():""},item:f,load:o,mark:y,itemContains:function(e,t){var n;return t.trim().length>0&&(n=(""+e).split(/<p>/),n[0]=y(n[0],t),e=n.join("<p>")),f(e,t)},itemMarkAll:function(e,t){return f(""===t.trim()?""+e:y(""+e,t),t)},itemStartsWith:function(e,t){return f(""===t.trim()?""+e:y(""+e,t,!0),t)},create:function(e,t,n){n.item=n.item||this.itemContains;var r=new Awesomplete(e,n);return r.utilprops=t||{},r.utilprops.url||"undefined"!=typeof r.utilprops.loadall||(r.utilprops.loadall=!0),r.utilprops.ajax=r.utilprops.ajax||this.ajax,r.utilprops.convertInput=r.utilprops.convertInput||this.convertInput,r},attach:function(e){var t=e.input,n=r.bind(e),a=i.bind(e),u=d.bind(e),o=l.bind(e),p=C.bind({b:e,h:n,i:u,j:a,k:o}),c={keydown:a,input:u};return c.blur=c[A]=c[E]=n,c[x]=o,F.bind(t,c),e.utilprops.detach=p,e.utilprops.prepop&&(e.utilprops.loadall||t.value.length>0)&&(e.utilprops.val=e.utilprops.convertInput.call(e,t.value),s(e,e.utilprops.val)),e},update:function(e,t,n){return e.input.value=t,v(e,t,n)},start:function(e,t,n){return this.attach(this.create(e,t,n))},detach:function(e){return e.utilprops.detach&&(e.utilprops.detach(),delete e.utilprops.detach),e},createCopyFun:function(e,t,n){return m.bind({d:e,e:t,f:F(n)||n})},attachCopyFun:function(e,t,n){return t="boolean"!=typeof t||t,n=n||document.body,n.addEventListener(k,e),t&&n.addEventListener(I,e),e},startCopy:function(e,t,n,r){var i=F(e);return this.attachCopyFun(this.createCopyFun(i||e,t,n),r,i)},detachCopyFun:function(e,t){return t=t||document.body,t.removeEventListener(I,e),t.removeEventListener(k,e),e},createClickFun:function(e,t){return b.bind({g:e,b:t})},attachClickFun:function(e,t){return t=t||document.body,t.addEventListener("click",e),e},startClick:function(e,t){var n=F(e);return this.attachClickFun(this.createClickFun(n||e,t),n)},detachClickFun:function(e,t){return t=t||document.body,t.removeEventListener("click",e),e},filterContains:function(e,t){return Awesomplete.FILTER_CONTAINS(e.value,t)},filterStartsWith:function(e,t){return Awesomplete.FILTER_STARTSWITH(e.value,t)},jsonFlatten:function(e){return g({},e,"",0,this)}}}();
//# sourceMappingURL=awesomplete-util.min.js.map
