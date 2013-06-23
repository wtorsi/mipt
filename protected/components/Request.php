<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 14:58
 * To change this template use File | Settings | File Templates.
 */

class Request extends CApplicationComponent {

	/**
	 * @var CHttpRequest
	 */
	private static $self = null;

	public static  function get(){
		if(is_null(self::$self)){
			self::$self = Yii::app()->getRequest();
		}
		return self::$self;
	}

	public static function redirect($url, $status = 302, $terminate = true){
		if(is_array($url))
		{
			$route = isset($url[0]) ? $url[0] : '';
			$url = Yii::app()->createUrl($route,array_splice($url,1));
		}
		self::get()->redirect($url, $terminate, $status);
	}

	public static function goBack(){
		if($ref = self::get()->getUrlReferrer())
			self::redirect($ref);
	}

	public static function post($name, $default = null){
		return self::get()->getPost($name, $default);
	}

	public static function refresh(){
		Yii::app()->getController()->refresh();
	}

}