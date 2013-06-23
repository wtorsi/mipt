var codeInput;

$(function(){

	if($('#inputAnswer').size() > 0){
		var mime = 'text/x-mysql';
		window.codeInput = CodeMirror.fromTextArea(document.getElementById('inputAnswer'),{
			mode: mime,
			indentWithTabs: true,
			smartIndent: true,
			lineNumbers: true,
			matchBrackets : true,
			autofocus: true
		});
	}
});

function showTableDescription(obj){
	$.fancybox({
		'content': $(obj).closest('.tables-parent').find('.columns').html()
	});
	return false;
}
function initCodeInput(){

}

function getCommandData(){
	return {
		command: window.codeInput.getValue(' ')
	}
}
function setCommandResult(data){
	$('#command-result').html(data);
}