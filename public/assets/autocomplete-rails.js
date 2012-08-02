/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" data-id-element="#id_field">
*/
$(document).ready(function(){$("input[data-autocomplete]").railsAutocomplete()}),function(e){var t=null;e.fn.railsAutocomplete=function(){return this.live("focus",function(){this.railsAutoCompleter||(this.railsAutoCompleter=new e.railsAutocomplete(this))})},e.railsAutocomplete=function(e){_e=e,this.init(_e)},e.railsAutocomplete.fn=e.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},e.railsAutocomplete.fn.extend=e.railsAutocomplete.extend=e.extend,e.railsAutocomplete.fn.extend({init:function(e){function t(e){return n(e).pop().replace(/^\s+/,"")}function n(t){return t.split(e.delimiter)}e.delimiter=$(e).attr("data-delimiter")||null,$(e).autocomplete({source:function(n,r){$.getJSON($(e).attr("data-autocomplete"),{term:t(n.term)},function(){$(arguments[0]).each(function(t,n){var r={};r[n.id]=n,$(e).data(r)}),r.apply(null,arguments)})},search:function(){var e=t(this.value);if(e.length<2)return!1},focus:function(){return!1},select:function(t,r){var i=n(this.value);i.pop(),i.push(r.item.value);if(e.delimiter!=null)i.push(""),this.value=i.join(e.delimiter);else{this.value=i.join(""),$(this).attr("data-id-element")&&$($(this).attr("data-id-element")).val(r.item.id);if($(this).attr("data-update-elements")){var s=$(this).data(r.item.id.toString()),o=$.parseJSON($(this).attr("data-update-elements"));for(var u in o)$(o[u]).val(s[u])}}var f=this.value;return $(this).bind("keyup.clearId",function(){$(this).val().trim()!=f.trim()&&($($(this).attr("data-id-element")).val(""),$(this).unbind("keyup.clearId"))}),$(this).trigger("railsAutocomplete.select",r),!1}})}})}(jQuery);