<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 7:02
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends CAction{

	public function run(){
		View::set('index/index');
	}

}