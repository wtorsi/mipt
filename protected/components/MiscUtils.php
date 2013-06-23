<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 18:14
 * To change this template use File | Settings | File Templates.
 */

class MiscUtils extends CApplicationComponent
{

	private static $password = 'mipt password';
	private static $salt = 'mipt salt';


	public static function password($text) {
		return md5(md5($text) . $text . self::$password);
	}

	public static function salt($text) {
		return md5(md5($text) . $text . self::$salt);
	}
}

