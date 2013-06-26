<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 21.06.13
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */

class CheckAction extends Action{

	public $min_rows = 3;
	public $max_rows = 100;
	public $percent = 90;

	public function run(){
		if($command = Request::post('command')){
			/**
			 * @var $test_db DbConnection
			 */
			$test_db = Yii::app()->test_db;
			try{
				$result = $test_db->createCommand($command)->queryAll();
				$countRows = count($result);
				$result = $this->getCutResult($result);
				$data = array(
					'query' => $command,
					'result' => $result,
					'countRows' => $countRows,
				);
				View::parse('check_success', $data , false);
			}
			catch(CDbException $e){
				$error = $e->errorInfo[2];
				View::parse('check_error', array('query' => $command, 'error' => $error), false);
			}
		}
		Yii::app()->end();
	}

	private function getCutResult($result){
		$count = count($result);

		if($count < $this->min_rows){
			return $result;
		}
		elseif($count > $this->max_rows){
			return array_slice($result, 0, $this->max_rows);
		}
		else{
			return array_slice($result, 0, ceil($this->percent / 100 * $count));
		}
	}
}