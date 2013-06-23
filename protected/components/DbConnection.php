<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 14:16
 * To change this template use File | Settings | File Templates.
 */

class DbConnection extends CDbConnection {

	public $dbName;
	protected  function open(){
		preg_match('/dbname=([^:;]*)/', $this->connectionString, $m);
		$this->dbName = $m[1];
		parent::open();
	}
}