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
	var $upload_result = $("#upload-result");
	var $tables = $('#tables');
	var url = $upload_input.attr('data-attr-url');

	$upload_button.on('click', function () {
		$upload_input.click();
	});
	$upload_submit.on('click', function () {
		$upload_input.submit();
	});


	$upload_input.fileupload({
		url: url,
		dataType: 'html',
		autoUpload: false,
		acceptFileTypes: /(\.|\/)(sql)$/i,
		maxFileSize: 512 * 1024 * 1024,
		replaceFileInput: false,
		add: function (e, data) {
			var file = data.files[0];


			$upload_progress.find('.bar').css('width', 0);

			$upload_info.find('.file-name').html(file.name);
			$upload_info.find('.file-date').html(file.lastModifiedDate);
			$upload_info.find('.file-size').html((file.size / 1024 / 1024).toFixed(2) + ' Mb');
			$upload_info.find('.file-type').html(file.type);

			$upload_submit.removeClass('disabled');
			$upload_submit.one('click',function(){
				data.submit();
			});

		},
		submit: function (e, data) {

			var value = $('#upload-prefix').val();
			data.formData = [{
					name: 'prefix',
					value: value
			}];
			$.fancybox.showLoading();
		},
		progressall: function (e, data) {
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$upload_progress.find('.bar').css(
				'width',
				progress + '%'
			);
		},
		always: function(e, data){
			$upload_submit.addClass('disabled');

			var url = $('#tables').attr('data-attr-url');
			$.ajax({
				url: url,
				method: 'post',
				type: 'json',
				async: false,
				success: function(result){
					$tables.slideUp(600).html(result.tables).slideDown(500);
				}
			});

			$upload_result.html(data.result);
			$.fancybox.hideLoading();

		}
	});


});
