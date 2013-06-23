<?

function d() {
$data = func_get_args();
$debug = debug_backtrace();
echo '<pre>';
	print_r('In file: '. $debug[0]['file'] . '<br>');
	print_r('On line: '  . $debug[0]['line'] );
	echo '</pre>';
echo '<pre>';
	if(is_array($data)) {
		foreach ($data as $var) {
			print_r($var);
		}
	}
	else{
		print_r($data);
	}
	echo '</pre>';
}

