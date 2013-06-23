<?php

class DefaultController extends AdminController
{

	/**
	 * Declares class-based actions.
	 */
	public function actions() {

		return array(

			'index'  => 'admin.controllers.default.IndexAction',
			'login'  => 'admin.controllers.default.LoginAction',
			'logout' => 'admin.controllers.default.LogoutAction',

		);
	}


}