<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 01.06.13
 * Time: 17:01
 * To change this template use File | Settings | File Templates.
 */

class UpdateAction extends Action {

	public function run($id){
		$branch = Branch::model()->findByPk($id);

		$dataProvider = new CActiveDataProvider('Question', array(
			'criteria' => array(
				'with' => array(
					'branch' => array(
						'condition' => 'branch_id='. $branch->id,
					)
				),
			)
		));

		$question = new Question();
		if($pdata = Request::post('Question')){
			$question->setAttributes($pdata);
			$question->branch_id = $branch->id;

			if( $question->save() )
				Request::refresh();
		}


		View::set('update',array(
			'model' => $branch,
			'dataProvider' => $dataProvider,
		));
	}
}