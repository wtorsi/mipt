<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 21.06.13
 * Time: 23:07
 * To change this template use File | Settings | File Templates.
 */

class TestController extends Controller{

	public function actions(){
		return array(
			'check' => 'application.controllers.test.CheckAction',
			'save'  => 'application.controllers.test.SaveAction',
			'do'    => 'application.controllers.test.DoAction',
			'result'    => 'application.controllers.test.ResultAction',
		);
	}


}