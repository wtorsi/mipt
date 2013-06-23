<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 21.06.13
 * Time: 21:35
 * To change this template use File | Settings | File Templates.
 */

class DoAction extends Action
{


	public function run($test_id, $result_id = null) {

		Script::get()->registerPackage('code');

		//checks that test is exist and curent user has this test
		if (!User::get()->hasTest($test_id)) {
			Request::redirect('/');
		}

		//create new result if it is null
		if (is_null($result_id)) {

			$result          = new Result();
			$result->test_id = $test_id;
			$result->user_id = User::get()->id;
			$result->save(false);

			Request::redirect(array('test/do', 'test_id' => $test_id, 'result_id' => $result->primaryKey));
		}


		$result = Result::model()->findByPk($result_id);
		if ($result->isCompleted()) {
			Request::redirect(array('test/result', 'result_id' => $result->id));
		}

		$question = $result->getRandomQuestion();
		$salt     = MiscUtils::salt(User::get()->id . $test_id . $result_id . $question->id);

		$data = array(
			'question' => $question,
			'salt'     => $salt,
		);

		View::set('do', $data);
	}

}