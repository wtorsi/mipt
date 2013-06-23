<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 27.04.13
 * Time: 12:07
 * To change this template use File | Settings | File Templates.
 */

class View extends CApplicationComponent{


	/**
	 * Sets content From template unit
	 * @param $file
	 * @param null $data
	 */
	public static  function set($file, $data = null){
		Yii::app()->controller->render($file, $data);
	}

	/**
	 * Parse Template
	 * @param $file
	 * @param null $data
	 * @return mixed
	 */
	public static  function parse($file, $data=null, $return = true){
		return Yii::app()->controller->renderPartial($file, $data, $return);
	}


}