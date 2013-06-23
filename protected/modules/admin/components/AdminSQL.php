<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 26.05.13
 * Time: 19:54
 * To change this template use File | Settings | File Templates.
 */

class AdminSQL {




	/**
	 * @param $file string
	 * @param $prefix string
	 * @return array
	 */
	public  static  function executeFile($file, $prefix = ''){
		if(!$prefix) $prefix = null;
		return self::processFile($file, $prefix);
	}


	/**
	 * Process files to upload
	 * @param $file_name
	 * @param null $prefix
	 * @return array
	 */
	public static function processFile($file_name, $prefix = null){

		$result = array();
		if($file = file_get_contents($file_name) ){
			$result =  self::_processFile($file_name, ';', $prefix);
		}

		return $result;
	}


	/**
	 * @param        $file
	 * @param string $delimiter
	 * @param null   $prefix
	 *
	 * @return array
	 * @throws AdminSQLException
	 */
	private static  function _processFile($file, $delimiter = ';', $prefix  = null){
		set_time_limit(0);

		$result = array();
		if (is_file($file) === true){
			$file = fopen($file, 'r');

			if (is_resource($file) === true){
				$query = array();

				while (feof($file) === false){
					$line = fgets($file);
					if(substr($line, 0, 2) == '--') continue;

					if(!is_null($prefix)){
						$line = str_replace($prefix, '', $line);
					}


					$query[] = $line;

					if (preg_match('~' . preg_quote($delimiter, '~') . '\s*$~iS', end($query)) === 1){
						$query = trim(implode('', $query));


						try{
							Yii::app()->stable_db->createCommand($query)
								->execute();

							$result[] = array(
								'query' => $query,
								'shortQuery' => self::cutStr($query, 400),
								'success'  => true,
							);
						}
						catch(CDbException $e){
							$result[] = array(
								'query' => $query,
								'shortQuery' => self::cutStr($query, 400),
								'success'  => false,
								'message' => $e->errorInfo[2],
							);
						}
					}

					if (is_string($query) === true){
						$query = array();
					}
				}
				fclose($file);
				return  $result;
			}
			else{

				throw new AdminSQLException( "{$file} is not a resource" );
			}
		}
		else{
			throw new AdminSQLException("{$file} can not be read");
		}
	}


	public static function cutStr($data, $pos) {
		$data = strip_tags($data);
		return substr($data,0, $pos);
	}


	public static function copyDb(){

		/**
		 * @var $stable_db DbConnection
		 * @var $test_db DbConnection
		 */
		$stable_db = Yii::app()->stable_db;
		$test_db = Yii::app()->test_db;
		$db = Yii::app()->db;

		$query = "
		SET @tables = NULL;
			SELECT GROUP_CONCAT(table_schema, '.', table_name) INTO @tables
            FROM information_schema.tables
            WHERE table_schema = '" . $test_db->dbName . "';

			SET @tables = CONCAT('DROP TABLE ', @tables);
			PREPARE stmt FROM @tables;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;";


		$db->createCommand($query)->execute();

		$tables = $stable_db->getSchema()->tableNames;

		foreach($tables as $table_name){

			$from   = $stable_db->dbName . "." . $table_name;
			$to     = $test_db->dbName . "." . $table_name;

			$query = "CREATE TABLE " . $to .  " LIKE " . $from;
			$db->createCommand($query)->execute();

			$query = "INSERT INTO ". $to . " SELECT * FROM " . $from;
			$db->createCommand($query)->execute();
		}
	}
}

class AdminSQLException extends Exception{

}