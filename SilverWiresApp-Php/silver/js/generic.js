// GLOBAL VARS
var contactMail = 'asd@asd.ro';


// FUNCTIONS
function showLoader(elem) {
	if ($(elem).find('#genericLoader').length == 0) {
		$('<div id="genericLoader" />').hide().appendTo(elem);
	}
	$('#genericLoader').fadeIn('fast');
}
function hideLoader() {
	$('#genericLoader').fadeOut('fast');
}



// DOCUMENT READY
$(document).ready(function(){
	
});


// WINDOW LOAD
$(window).load(function(){
	
});