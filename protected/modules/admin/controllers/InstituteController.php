<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 10.06.13
 * Time: 22:54
 * To change this template use File | Settings | File Templates.
 */

class InstituteController extends AdminController{

	public function actions(){
		return array(
			'index'     =>  'admin.controllers.institute.IndexAction',
			'create'    =>  'admin.controllers.institute.CreateAction',
			'update'    =>  'admin.controllers.institute.UpdateAction',
			'delete'    =>  'admin.controllers.institute.DeleteAction',
		);
	}
}