<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 18:45
 * To change this template use File | Settings | File Templates.
 */
class RegisterForm extends CFormModel
{

	public $username;
	public $name;
	public $surname;
	public $group_id;
	public $password;
	public $password2;
	public $verifyCode;

	public function rules() {
		return array(

			array('name,surname,group_id,username, password, password2',
				'required',
				'message'  => 'Это поле не может быть пустым'
			),
			array('username', 'email',
				'message'   => 'Email введен не верно'
			),
			array('group_id', 'numerical',
				'integerOnly' => true,
				'allowEmpty' => false,
				'message'   => 'Это поле может содержать только цифры',
			),
			array('group_id', 'exist',
				'allowEmpty'    => false,
				'className'     => 'Group',
				'attributeName' => 'id',
				'message'       => 'Выбранный пункт не существует'
			),
			array('password2', 'compare',
				'compareAttribute' => 'password',
				'message'           => 'Поля должны быть одинаковыми',
			),
			array('username', 'unique',
				'className'     => 'User',
				'caseSensitive' => false,
				'attributeName' => 'email',
				'allowEmpty'    => false,
				'message'       => 'Такой email уже зарегистрирован'
			),
			array('verifyCode', 'captcha',
				'message' => 'Символы введены не верно'
			),
			array('password', 'length', 'min' => 6,
				'message'   => 'Минимальная длина 6 символов'
			)
		);
	}


	public function attributeLabels() {
		return array(
			'username' => 'Email',
			'password' => 'Пароль',
			'password2'  => 'Повторите',
			'name'      => 'Имя',
			'surname'   => 'Фамилия',
			'group_id'  => 'Группа',
			'verifyCode'=> 'Код с изображения'
		);
	}

}