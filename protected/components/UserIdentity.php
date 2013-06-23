<?php
class UserIdentity extends CUserIdentity
{
	private $_id;

	public function authenticate() {

		/**
		 * @var $record User
		 */
		$record = User::model()->findByAttributes(array('email' => $this->username));

		if ($record === null) {
			$this->errorCode = self::ERROR_USERNAME_INVALID;
		}
		elseif ($record->password !== MiscUtils::password($this->password)) {
			$this->errorCode = self::ERROR_PASSWORD_INVALID;
		}
		else {
			$this->_id = $record->id;
			$this->errorCode = self::ERROR_NONE;
		}

		return !$this->errorCode;
	}

	public function getId() {
		return $this->_id;
	}
}