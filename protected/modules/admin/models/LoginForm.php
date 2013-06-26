<?php

/**
 * LoginForm class.
 * LoginForm is the data structure for keeping
 * user login form data. It is used by the 'login' action of 'SiteController'.
 */
class LoginForm extends CFormModel
{
	public $username;
	public $password;

	public $verifyCode;
	private $_identity;


	public function rules()
	{
		return array(
			array('username, password', 'required'),
			array('password', 'authenticate'),
			array('verifyCode', 'captcha',
				'message' => 'Символы введены не верно'
			),
		);
	}

	public function attributeLabels()
	{
		return array(
			'username'  => 'Login',
			'password'  => 'Пароль',
			'verifyCode' => 'Код изображения',
		);
	}

	public function authenticate($attribute,$params)
	{
		if(!$this->hasErrors())
		{
			$this->_identity = new UserIdentity( $this->username, $this->password);

			if(!$this->_identity->authenticate())
				$this->addError('password', 'Неправильный Login или Пароль');
		}
	}

	public function login()
	{
		if($this->_identity === null){

			$this->_identity = new UserIdentity($this->username,$this->password);
			$this->_identity->authenticate();

		}

		if($this->_identity->errorCode === UserIdentity::ERROR_NONE){

			Yii::app()->user->login($this->_identity);

			return true;
		}
		else{
			return false;
		}

	}
}
