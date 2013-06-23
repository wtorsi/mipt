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

	var $fileupload = $('#fu-button');
	var url = $fileupload.attr('data-attr-url');


	var uploadButton = $('<button/>')
		.addClass('btn')
		.prop('disabled', true)
		.text('Выполняется...')
		.on('click', function () {
			var $this = $(this),
				data = $this.data();
			$this
				.off('click')
				.text('Отменить')
				.on('click', function () {
					$this.remove();
					data.abort();
				});
			data.submit().always(function () {
				$this.remove();
			});
	});

	$fileupload.fileupload({
		url:        url,
		dataType:   'json',
		autoUpload: false,
		acceptFileTypes: /(\.|\/)(sql)$/i,
		maxFileSize: 512 * 1024 * 1024 // 512M
	})
	.on('fileuploadadd', function (e, data) {
		data.context = $('<div/>').appendTo('#files');
		$.each(data.files, function (index, file) {
			var node = $('<p/>')
				.append($('<span/>').text(file.name));
			if (!index) {
				node
					.append('<br>')
					.append(uploadButton.clone(true).data(data));
			}
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
		$.each(data.result.files, function (index, file) {
			var link = $('<a>')
				.attr('target', '_blank')
				.prop('href', file.url);
			$(data.context.children()[index])
				.wrap(link);
		});
	})
	.on('fileuploadfail', function (e, data) {
		$.each(data.result.files, function (index, file) {
			var error = $('<span/>').text(file.error);
			$(data.context.children()[index])
				.append('<br>')
				.append(error);
		});
	});

});
