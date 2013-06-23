<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action{


	public function run(){

		Script::get()->registerPackage('fileupload');
		Script::get()->registerPackage('fancybox');


		View::set('index');
	}

}