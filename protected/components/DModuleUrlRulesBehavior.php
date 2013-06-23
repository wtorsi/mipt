<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 8:51
 * To change this template use File | Settings | File Templates.
 */

class DModuleUrlRulesBehavior extends CBehavior
{
	public function events() {
		return array_merge(parent::events(), array(
			'onBeginRequest' => 'beginRequest',
		));
	}

	public function beginRequest($event) {
		$moduleName = $this->_getCurrentModuleName();


		if (Yii::app()->hasModule($moduleName)) {
			$class = ucfirst($moduleName) . 'Module';
			Yii::import($moduleName . '.' . $class);
			if (method_exists($class, 'rules')) {
				$moduleRules = call_user_func($class . '::rules');


				Yii::app()->getUrlManager()->addRules($moduleRules, false);


			}
		}

	}

	protected function _getCurrentModuleName() {
		$route      = Yii::app()->getRequest()->getPathInfo();
		$domains    = explode('/', $route);
		$moduleName = array_shift($domains);

		return $moduleName;
	}
}