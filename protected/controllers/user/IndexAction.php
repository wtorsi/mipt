<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 17:28
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action {

	public function run(){
		$tests = User::get()->group->tests;

		$data = array(
			'user' => User::get(),
			'tests' => $tests,
		);
		View::set('index', $data);
	}

}