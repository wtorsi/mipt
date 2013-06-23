<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 16:25
 * To change this template use File | Settings | File Templates.
 */

class UserController extends Controller{

	public function actions() {
		return array(
			'captcha' => array(
				'class'     => 'CCaptchaAction',
				'backColor' => 0xFFFFFF,
			),


			'index' => 'application.controllers.user.IndexAction',
			'register' => 'application.controllers.user.RegisterAction',
			'login' => 'application.controllers.user.LoginAction',
			'logout' => 'application.controllers.user.LogoutAction',
		);
	}
}