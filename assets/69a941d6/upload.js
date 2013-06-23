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


	var $upload_button = $('#upload-button');
	var $upload_input = $('#upload-input');
	var $upload_submit = $('#upload-submit');
	var $upload_info = $("#upload-info");
	var $upload_progress = $("#upload-progress");

	$upload_button.on('click', function(){
		$upload_input.click();
	});
	$upload_submit.on('click', function(){
		$upload_input.submit();
	});


	$upload_input.fileupload({
		dataType:       'json',
		autoUpload: false,
		acceptFileTypes: /(\.|\/)(sql)$/i,
		maxFileSize: 512 * 1024 * 1024,
		add: function(e, data){


			var file = data.files[0];

			$upload_progress.find('.bar').css('width', 0).hide();
			$upload_info.find('.file-name').html(file.name);
			$upload_info.find('.file-date').html(file.lastModifiedDate);
			$upload_info.find('.file-size').html((file.size / 1024 / 1024).toFixed(2) + ' Mb');
			$upload_info.find('.file-type').html(file.type);


		},
		submit: function(e,data){
			$upload_progress.show(300);
		},
		progressall: function(e, data){
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$upload_progress.find('.bar').css(
				'width',
				progress + '%'
			);
		}
	});
//	.on('fileuploadadd', function (e, data) {
//			data.context = $('<div/>').appendTo('#fu-files');
//
//			$fileupload_submit.on('click',function(){
//				data.submit();
//			});
//
//			$('#fu-info').removeClass('hidden');
//			$.each(data.files, function (index, file) {
//				var node = $('<div/>')
//					.append($('<p/>').text(file.name))
//					.append($('<p/>').text(parseFloat(file.size / 1024 / 1024).toFixed(2) + ' Мб'));
//
//				node.appendTo(data.context);
//			});
//	})
//	.on('fileuploadprocessalways', function (e, data) {
//		var index = data.index,
//			file = data.files[index],
//			node = $(data.context.children()[index]);
//
//
//		if (file.error) {
//			node
//				.append('<br>')
//				.append(file.error);
//		}
//		if (index + 1 === data.files.length) {
//			data.context.find('button')
//				.text('Upload')
//				.prop('disabled', !!data.files.error);
//		}
//	})
//	.on('fileuploadprogressall', function (e, data) {
//			var progress = parseInt(data.loaded / data.total * 100, 10);
//
//			$('#fu-progress .bar').css(
//				'width',
//				progress + '%'
//			);
//	}).on('fileuploaddone', function (e, data) {
//
//			console.log('done');
//			console.log(data);
////			$('#fu-info').addClass('hidden');
////			$('#fu-files').html('');
////			$('#fu-progress .bar').css(
////				'width',
////				0 + '%'
////			);
////
////
////		$.each(data.result.files, function (index, file) {
////			var link = $('<a>')
////				.attr('target', '_blank')
////				.prop('href', file.url);
////			$(data.context.children()[index])
////				.wrap(link);
////		});
//	})
//	.on('fileuploadfail', function (e, data) {
//
//			console.log('fail');
//			console.log(data);
//
////
////		$.each(data.result.files, function (index, file) {
////			var error = $('<p/>').text(file.error);
////			$(data.context.children()[index])
////				.append('<br>')
////				.append(error);
////		});
//	})
//	.on('fileuploadsubmit', function(e,data){
//		var value = $('#fu-prefix').val();
//
//		data.formData = [
//			{
//				name: 'prefix',
//				value: value
//			},
//			{
//				name: 'method',
//				value: 'upload'
//			}
//		];
//		$.fancybox.showLoading();
//	});
//
//

});
