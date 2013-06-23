<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 02.06.13
 * Time: 19:01
 * To change this template use File | Settings | File Templates.
 */

class Tables {

	public static function getHtml(){
		$tables = Yii::app()->test_db->getSchema()->getTables();
		return  View::parse('application.views.components.tables', array('tables' => $tables));
	}
}