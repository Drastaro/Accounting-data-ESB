// jQuery UI Combobox Widget
(function($) {
	$.widget("ui.combobox", {
		_create : function() {
			var input, that = this, wasOpen = false, select = this.element
					.hide(), selected = select
					.children(":selected"), value = selected
					.val() ? selected.text() : "", wrapper = this.wrapper = $(
					"<span>").addClass("ui-combobox")
					.insertAfter(select);
			function removeIfInvalid(element) {
				var value = $(element).val(), matcher = new RegExp(
						"^"
								+ $.ui.autocomplete
										.escapeRegex(value)
								+ "$", "i"), valid = false;
				select.children("option").each(function() {
					if ($(this).text().match(matcher)) {
						this.selected = valid = true;
						return false;
					}
				});
				if (!valid) {
					// remove invalid value, as it didn't match
					// anything
					$(element).val("").attr("title",
							value + " didn't match any item")
							.tooltip("open");
					select.val("");
					setTimeout(function() {
						input.tooltip("close")
								.attr("title", "");
					}, 2500);
					input.data("ui-autocomplete").term = "";
				}
			}
			input = $("<input>")
					.appendTo(wrapper)
					.val(value)
					.attr("title", "")
					.addClass( "ui-state-default ui-combobox-input" )
					.autocomplete({
						delay : 0,
						minLength : 0,
						source : function(request,
								response) {
							var matcher = new RegExp(
									$.ui.autocomplete
											.escapeRegex(request.term),
									"i");
							response(select
									.children("option")
									.map(
											function() {
												var text = $(
														this)
														.text();
												if (this.value
														&& (!request.term || matcher
																.test(text)) )
													return {
														label : text
																.replace(
																		new RegExp(
																				"(?![^&;]+;)(?!<[^<>]*)("
																						+ $.ui.autocomplete
																								.escapeRegex(request.term)
																						+ ")(?![^<>]*>)(?![^&;]+;)",
																				"gi"),
																		"<strong>$1</strong>"),
														value : text,
														option : this
													};
											}));
							},
							select : function(event, ui) {
								ui.item.option.selected = true;
								that
										._trigger(
												"selected",
												event,
												{
													item : ui.item.option
												});
							},
							change : function(event, ui) {
								if (!ui.item) {
									removeIfInvalid(this);
								}
							}
						})
					.addClass(
							"ui-widget ui-widget-content ui-corner-left");
			input.data("ui-autocomplete")._renderItem = function(
					ul, item) {
				return $("<li>").append(
						"<a>" + item.label + "</a>").appendTo(
						ul);
			};
			$("<a>").attr("tabIndex", -1).attr("title",
					"Show All Items").tooltip().appendTo(
					wrapper).button({
				icons : {
					primary : "ui-icon-triangle-1-s"
				},
				text : false
			}).removeClass("ui-corner-all").addClass(
					"ui-corner-right ui-combobox-toggle")
					.mousedown(
							function() {
								wasOpen = input.autocomplete(
										"widget")
										.is(":visible");
							}).click(function() {
						input.focus();
						// close if already visible
						if (wasOpen) {
							return;
						}
						// pass empty string as value to search for, displaying all results
						input.autocomplete("search", "");
					});
			input.tooltip({
				tooltipClass : "ui-state-highlight"
			});
		},
		_destroy : function() {
			this.wrapper.remove();
			this.element.show();
		}
	});
})(jQuery);

$(function() {
	$(".combobox").combobox();
	$(".tooltip").tooltip();
});

var noticeBoxTimeout = null;

function showNoticeBox() {
	clearTimeout(noticeBoxTimeout);
	if( $('#noticeBox').is(':hidden') ) {
		$('#noticeBox').css('top', -$('#noticeBox').outerHeight()).show()
			.animate({top: 0}, 200, function() {
				noticeBoxTimeout = setTimeout(hideNoticeBox, 5000);
			});
	} else {
		noticeBoxTimeout = setTimeout(hideNoticeBox, 5000);
	}
}

function hideNoticeBox() {
	clearTimeout(noticeBoxTimeout);
	if( $('#noticeBox').is(':visible') ) {
		$('#noticeBox').animate({top: -$('#noticeBox').outerHeight()}, 200, function(){$('#noticeBox').hide();});
	}
}

function showNotice(type, message) {
	if (type == 'error') {
		var className = 'noticeBoxRed', title = 'Eroare';
	} else {
		var className = 'noticeBoxGreen', title = 'Succes';
	}
	$('#noticeBox').removeClass().addClass(className);
	$('#noticeBox #noticeBoxText').html('<b>' + title + '!</b> ' + message);
	showNoticeBox();
}

$(document).ready(function(){
	$('#noticeBoxClose').click(function(){
		hideNoticeBox();
		return false;
	});
	if ($('#noticeBoxText').html()) {
		showNoticeBox();
	}
	
	for (var i=1; $('#date' + i).length > 0; i++) {
		$('#date' + i).datepicker({
			dateFormat:	"d M yy",
			altField: 	'#date' + i + "FIX",
			altFormat:	"yy-mm-dd",
			yearRange:	"-70:c",
			changeMonth:true,
			changeYear: true,
		});
	}
});
