<?php

class DefaultController extends AdminController
{

	/**
	 * Declares class-based actions.
	 */
	public function actions() {

		return array(
			'captcha' => array(
				'class'     => 'CCaptchaAction',
				'backColor' => 0xFFFFFF,
			),
			'index'  => 'admin.controllers.default.IndexAction',
			'login'  => 'admin.controllers.default.LoginAction',
			'logout' => 'admin.controllers.default.LogoutAction',
		);
	}


}