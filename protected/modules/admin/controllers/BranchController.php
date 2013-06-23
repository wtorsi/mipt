<?php

class BranchController extends AdminController{

	public function actions()
	{
		return array(

			'index'     =>  'admin.controllers.branch.IndexAction',
			'create'    =>  'admin.controllers.branch.CreateAction',
			'update'    =>  'admin.controllers.branch.UpdateAction',
			'delete'    =>  'admin.controllers.branch.DeleteAction',

		);
	}


}
