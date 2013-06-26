<?php

class AdminModule extends CWebModule
{

	public $user;

	public function init() {


		Yii::setPathOfAlias('admin_ext', dirname(__FILE__) . '/extensions');
		Yii::setPathOfAlias('files', dirname(__FILE__) . '/files');


		$this->setImport(array(
			'admin.models.*',
			'admin.components.*',
			'admin.extensions.*',
			'admin.vendors.*',
		));



		Yii::app()->user->setStateKeyPrefix('_admin');
		Yii::app()->setComponents(array(
			'user' => array(
				'loginUrl'  => Yii::app()->createUrl('admin/login'),
				'returnUrl' => Yii::app()->createUrl('admin'),
			)
		));
	}

	public static function rules() {
		return array(
			'admin'                                        => 'admin/default/index',
			'admin/<action:(login|logout|captcha)>'        => 'admin/default/<action>',
			'admin/<controller:\w+>'                       => 'admin/<controller>/index',
			'admin/<action:\w+>'                           => 'admin/default/<action>',
			'admin/<controller:\w+>/<action:\w+>/<id:\d+>' => 'admin/<controller>/<action>',
			'admin/<controller:\w+>/<action:\w+>'          => 'admin/<controller>/<action>',
		);
	}
}
