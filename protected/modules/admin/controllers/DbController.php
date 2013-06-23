<?php

class DbController extends AdminController
{

	/**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
			'index'        =>  'admin.controllers.db.IndexAction',
			'upload'        => 'admin.controllers.db.UploadAction',
			'tables'        => 'admin.controllers.db.TablesAction',
		);
	}


	public function filters(){
		return array(
			'ajaxOnly + upload,tables',
		);
	}
}