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

		View::set('update',array(
			'model'         => $branch,
			'dataProvider'  => $dataProvider,
			'question'      => $question,
		));
	}
}