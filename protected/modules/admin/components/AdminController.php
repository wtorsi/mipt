<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 14:48
 * To change this template use File | Settings | File Templates.
 */

class AdminController extends CController{
	public $layout='admin.views.layouts.main';

	public function filters()
	{
		return array(
			'accessControl',
		);
	}

	public function accessRules(){
		return array(
			array(
				'deny',
				'actions' => array('login'),
				'users' => array('@'),
				'deniedCallback' => array($this, 'redirectToHome')
			),
			array(
				'allow',
				'users' => array('@'),
			),
			array(
				'allow',
				'actions' => array('login'),
				'users' => array('?'),
			),
			array('deny'),

		);
	}



	public function redirectToHome($user){
		$this->redirect(Yii::app()->createUrl('admin'),true);
	}

	protected  function beforeAction(){
		Script::get()->registerPackage('admin');
		return true;
	}
}