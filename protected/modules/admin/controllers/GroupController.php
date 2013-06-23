<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 10.06.13
 * Time: 20:21
 * To change this template use File | Settings | File Templates.
 */

class GroupController  extends  AdminController{

	public function actions(){
		return array(
			'index'     =>  'admin.controllers.group.IndexAction',
			'create'    =>  'admin.controllers.group.CreateAction',
			'update'    =>  'admin.controllers.group.UpdateAction',
			'delete'    =>  'admin.controllers.group.DeleteAction',
		);
	}
}