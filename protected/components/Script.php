<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 15:14
 * To change this template use File | Settings | File Templates.
 */

class Script extends CApplicationComponent{

	/**
	 * @var CClientScript
	 */
	private  static $self = null;

	public static  function get(){
		if(is_null(self::$self)){
			self::$self = Yii::app()->getClientScript();
		}
		return self::$self;
	}




}