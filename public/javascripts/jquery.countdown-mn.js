/* http://keith-wood.name/countdown.html
 * Mongolian initialisation for the jQuery countdown extension
 * Written by Nomin-erdene nominerdene@gmail.com (2010) */
(function($) {
	$.countdown.regional['mn'] = {
		labels: ['Он', 'Сар', 'Долоо хоног', 'Өдөр', 'Цаг', 'Минут', 'Секунд'],
		labels1: ['Он', 'Сар', 'Долоо хоног', 'Өдөр', 'Цаг', 'Минут', 'Секунд'],
		compactLabels: ['y', 'm', 'w', 'd'], compactLabels1: ['y', 'm', 'w', 'd'],
		whichLabels: null,
		timeSeparator: ':', isRTL: false};
	$.countdown.setDefaults($.countdown.regional['mn']);
})(jQuery);
