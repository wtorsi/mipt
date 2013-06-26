<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 04.06.13
 * Time: 23:29
 * To change this template use File | Settings | File Templates.
 */

class TestController extends AdminController {

	public function actions(){
		return array(
			'index'     =>  'admin.controllers.test.IndexAction',
			'create'    =>  'admin.controllers.test.CreateAction',
			'update'    =>  'admin.controllers.test.UpdateAction',
			'delete'    =>  'admin.controllers.test.DeleteAction',
		);
	}
}