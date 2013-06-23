<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 11:06
 * To change this template use File | Settings | File Templates.
 */

class TablesAction extends Action{

	public function run(){
		echo CJSON::encode(array('tables' => Tables::getHtml()));
		Yii::app()->end();
	}
}