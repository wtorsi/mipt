<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 18:40
 * To change this template use File | Settings | File Templates.
 */

class RegisterAction extends Action {

	public function run(){

		$model = new RegisterForm();

		if($pdata = Request::post('RegisterForm')){
			$model->setAttributes($pdata);
			if($model->validate()){

				$user = new User();

				$email      = $model->username;
				$password   = $model->password;

				foreach($user->getAttributes() as $name => $value){
					if(isset($pdata[$name])){
						$user->$name = $pdata[$name];
					}
				}
				$user->email = $email;
				$user->save(false);


				$identity = new UserIdentity($email, $password);
				$identity->authenticate();
				$duration = 3600 * 24 * 30;



				Yii::app()->user->login($identity, $duration);

				Request::redirect('/');
			}
		}


		View::set('register', array('model' => $model));
	}
}