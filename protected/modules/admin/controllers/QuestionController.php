<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 02.06.13
 * Time: 21:52
 * To change this template use File | Settings | File Templates.
 */

class QuestionController extends AdminController {

	public function actions(){
		return array(

			'index'     =>  'admin.controllers.question.IndexAction',
			'create'    =>  'admin.controllers.question.CreateAction',
			'update'    =>  'admin.controllers.question.UpdateAction',
			'delete'    =>  'admin.controllers.question.DeleteAction',
			'check'     =>  'admin.controllers.question.CheckAction',

		);
	}

	public function filters(){
		return array(
			'ajaxOnly + check',
		);
	}


}