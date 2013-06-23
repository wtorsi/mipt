<?php
class LoginForm extends CFormModel
{
	public $username;
	public $password;

	private $_identity;


	public function rules() {
		return array(

			array('username, password', 'required'),
			array('password', 'authenticate'),
		);
	}


	public function attributeLabels() {
		return array(
			'username' => 'Email',
			'password' => 'Пароль',
		);
	}


	public function authenticate($attribute, $params) {
		if (!$this->hasErrors()) {
			$this->_identity = new UserIdentity($this->username, $this->password);
			if (!$this->_identity->authenticate()) {
				if($this->_identity->errorCode == UserIdentity::ERROR_USERNAME_INVALID){
					$this->addError('username', 'Такой пользователь не зарегистрирован');
				}
				elseif($this->_identity->errorCode == UserIdentity::ERROR_PASSWORD_INVALID){
					$this->addError('password', 'Неправильный пароль.');
				}

			}
		}
	}


	/**
	 * Logs in the user using the given username and password in the model.
	 *
	 * @return boolean whether login is successful
	 */
	public function login() {
		if ($this->_identity === null) {
			$this->_identity = new UserIdentity($this->username, $this->password);
			$this->_identity->authenticate();
		}
		if ($this->_identity->errorCode === UserIdentity::ERROR_NONE) {
			$duration =  3600 * 24 * 30;
			Yii::app()->user->login($this->_identity, $duration);
			return true;
		}

		return false;

	}
}
