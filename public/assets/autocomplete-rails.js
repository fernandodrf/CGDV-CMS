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
$(document).ready(function(){$("input[data-autocomplete]").railsAutocomplete()}),function(a){var b=null;a.fn.railsAutocomplete=function(){return this.live("focus",function(){this.railsAutoCompleter||(this.railsAutoCompleter=new a.railsAutocomplete(this))})},a.railsAutocomplete=function(a){_e=a,this.init(_e)},a.railsAutocomplete.fn=a.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},a.railsAutocomplete.fn.extend=a.railsAutocomplete.extend=a.extend,a.railsAutocomplete.fn.extend({init:function(a){function b(a){return c(a).pop().replace(/^\s+/,"")}function c(b){return b.split(a.delimiter)}a.delimiter=$(a).attr("data-delimiter")||null,$(a).autocomplete({source:function(c,d){$.getJSON($(a).attr("data-autocomplete"),{term:b(c.term)},function(){$(arguments[0]).each(function(b,c){var d={};d[c.id]=c,$(a).data(d)}),d.apply(null,arguments)})},search:function(){var a=b(this.value);if(a.length<2)return!1},focus:function(){return!1},select:function(b,d){var e=c(this.value);e.pop(),e.push(d.item.value);if(a.delimiter!=null)e.push(""),this.value=e.join(a.delimiter);else{this.value=e.join(""),$(this).attr("data-id-element")&&$($(this).attr("data-id-element")).val(d.item.id);if($(this).attr("data-update-elements")){var f=$(this).data(d.item.id.toString()),g=$.parseJSON($(this).attr("data-update-elements"));for(var h in g)$(g[h]).val(f[h])}}var i=this.value;return $(this).bind("keyup.clearId",function(){$(this).val().trim()!=i.trim()&&($($(this).attr("data-id-element")).val(""),$(this).unbind("keyup.clearId"))}),$(this).trigger("railsAutocomplete.select",d),!1}})}})}(jQuery)