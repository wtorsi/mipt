<?php
/**
 * Controller is the customized base controller class.
 * All controller classes for this application should extend from this base class.
 */
class Controller extends CController
{
	public $layout='//layouts/main';

	public function filters(){
		return array(
			'accessControl',
		);
	}

	public function accessRules(){

//		d('here');
//		d(Yii::app()->getUrlManager());
//		die();
		return array(
			array(
				'allow',
				'actions' => array('captcha'),
				'users'     => array('*'),
			),
			array(
				'deny',
				'actions' => array('login', 'register'),
				'users' => array('@'),
				'deniedCallback' => array($this, 'redirectToHome')
			),
			array(
				'allow',
				'users' => array('@'),
			),
			array(
				'allow',
				'actions' => array('login', 'register'),
				'users' => array('?'),
			),
			array('deny'),
		);

	}


	public function redirectToHome(){
		Request::redirect('/');
	}

	protected  function beforeAction(){
		Script::get()->registerPackage('main');
		return true;
	}


}