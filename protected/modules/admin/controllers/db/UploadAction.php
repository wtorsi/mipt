<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 22.06.13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */

class UploadAction extends Action {

	public function run(){
		Yii::import('admin.vendors.FileUpload.*');

		$handler = new UploadHandler(array(
			'upload_dir' => FILES_DIR,
			'upload_url' => FILES_URL,

		),false);

		$files = $handler->post(false);

		try{
			$result = $this->executeFile($files);
			$errors = array();
			foreach($result as $key => $item){
				if(!$item['success']) $errors[] = $key;
			}
			$html = View::parse('upload_success', array('result' => $result, 'errors' => $errors));
		}
		catch(AdminSQLException $e){
			$error = $e->getMessage();
			$html = View::parse('upload_error', array('error' => $error));
		}

		AdminSQL::copyDb();

		echo $html;
		Yii::app()->end();
	}



	/**
	 * Execute sql files
	 * @param $files
	 * @param string $prefix
	 * @return array
	 */
	public function executeFile($files, $prefix = ''){
		$result = array();
		foreach($files as $file){
			$res = AdminSQL::executeFile($file[0]->path, $prefix);
			$result = array_merge_recursive($result, $res);
			unlink($file[0]->path);
		}
		return $result;
	}
}
