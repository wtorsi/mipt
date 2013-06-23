/*
 * jQuery File Upload Plugin JS Example 8.0
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {

	var $fileupload = $('.fu-button');
	var $fileupload_input = $('#fu-input');
	var $fileupload_submit = $('#fu-submit');
	var $fileupload_info = $("#fu-info");
	var url = $fileupload.attr('data-attr-url');


	$fileupload_input.fileupload({
		url:        url,
		dataType:   'json',
		autoUpload: false,
		acceptFileTypes: /(\.|\/)(sql)$/i,
		maxFileSize: 512 * 1024 * 1024 // 512M
	})
	.on('fileuploadadd', function (e, data) {
			data.context = $('<div/>').appendTo('#fu-files');

			$fileupload_submit.on('click',function(){
				data.submit();
			});

			$('#fu-info').removeClass('hidden');
			$.each(data.files, function (index, file) {
				var node = $('<div/>')
					.append($('<p/>').text(file.name))
					.append($('<p/>').text(parseFloat(file.size / 1024 / 1024).toFixed(2) + ' Мб'));

				node.appendTo(data.context);
			});
	})
	.on('fileuploadprocessalways', function (e, data) {
		var index = data.index,
			file = data.files[index],
			node = $(data.context.children()[index]);


		if (file.error) {
			node
				.append('<br>')
				.append(file.error);
		}
		if (index + 1 === data.files.length) {
			data.context.find('button')
				.text('Upload')
				.prop('disabled', !!data.files.error);
		}
	})
	.on('fileuploadprogressall', function (e, data) {
			var progress = parseInt(data.loaded / data.total * 100, 10);

			$('#fu-progress .bar').css(
				'width',
				progress + '%'
			);
	}).on('fileuploaddone', function (e, data) {

			console.log('done');
			console.log(data);
//			$('#fu-info').addClass('hidden');
//			$('#fu-files').html('');
//			$('#fu-progress .bar').css(
//				'width',
//				0 + '%'
//			);
//
//
//		$.each(data.result.files, function (index, file) {
//			var link = $('<a>')
//				.attr('target', '_blank')
//				.prop('href', file.url);
//			$(data.context.children()[index])
//				.wrap(link);
//		});
	})
	.on('fileuploadfail', function (e, data) {

			console.log('fail');
			console.log(data);

//
//		$.each(data.result.files, function (index, file) {
//			var error = $('<p/>').text(file.error);
//			$(data.context.children()[index])
//				.append('<br>')
//				.append(error);
//		});
	})
	.on('fileuploadsubmit', function(e,data){
		var value = $('#fu-prefix').val();

		data.formData = [
			{
				name: 'prefix',
				value: value
			},
			{
				name: 'method',
				value: 'upload'
			}
		];
		$.fancybox.showLoading();
	});


	$fileupload.on('click', function(){
		$fileupload_input.click();
	});


	$fileupload_submit.on('click', function(){
		$fileupload.submit();
	});
});
