<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 21.06.13
 * Time: 23:16
 * To change this template use File | Settings | File Templates.
 */

class ArrayUtils {

	public static function getValues( $array , $key = 'id'){

		$result = array();
		if(is_array($array)){

			foreach($array as $elem){

				if(is_array($key)){
					$data = array();
					foreach($key as $val){
						$data[$val] = $elem->$val;
					}
					$result[] = $data;
				}
				else{
					$result[] = $elem->$key;
				}
			}
		}
		return $result;

	}

}