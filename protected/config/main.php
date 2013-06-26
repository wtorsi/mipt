<?php

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.

Yii::setPathOfAlias('bootstrap', dirname(__FILE__) . '/../extensions/bootstrap');

return array(
	'basePath'          => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
	'name'              => 'Mipt - Test SQL',

	'defaultController' => "user",

	// preloading 'log' component
	'preload'           => array('log'),

	// autoloading model and component classes
	'import'            => array(
		'application.models.*',
		'application.components.*',
	),

	'modules'           => array(


		'gii'   => array(
			'class'    => 'system.gii.GiiModule',
			'password' => false,
		),
		'admin' => array(
			'user'              => array(
				//pair login-password
				'admin' => 'admin',
			),
			'defaultController' => 'default',

		),

	),

	'behaviors'         => array(
		array(
			'class' => 'DModuleUrlRulesBehavior',
		)
	),

	// application components
	'components'        => array(

		'bootstrap'    => array(
			'class'         => 'ext.bootstrap.components.Bootstrap',
			'responsiveCss' => true,
		),

		'viewRenderer' => array(
			'class'         => 'application.extensions.Smarty.ESmartyViewRenderer',
			'fileExtension' => '.tpl',
			'pluginsDir'    => 'application.extensions.Smarty.plugins',
		),
		'user'         => array(
			'allowAutoLogin' => true,
			'loginUrl'       => 'login',

		),

		/**
		 * @string session CHttpSession
		 */
		'session'      => array(
			'autoStart' => true,
		),

		// uncomment the following to enable URLs in path-format

		'urlManager'   => array(
			'urlFormat'      => 'path',
			'showScriptName' => false,
			'caseSensitive'  => false,
			'urlSuffix'      => '',
			'rules'          => array(
				'gii'                                                         => 'gii',
				'gii/<controller:\w+>'                                        => 'gii/<controller>',
				'gii/<controller:\w+>/<action:\w+>'                           => 'gii/<controller>/<action>',

				"<controller:\w+>/<action:\w+>"                               => '<controller>/<action>',
//				"<controller:\w+>/<action:\w+>/<test_id:\d+>"                 => '<controller>/<action>',
//				"<controller:\w+>/<action:\w+>/<test_id:\d+>/<result_id:\d+>" => '<controller>/<action>',

				'<action:\w+>'                                                => 'user/<action>',
				'<action:\w+>/<id:\d+>'                                       => 'user/<action>',
			),
		),


		'db'           => array(
			'connectionString' => 'mysql:host=localhost;dbname=mipt',
			'emulatePrepare'   => true,
			'username'         => 'root',
			'password'         => 'toor',
			'charset'          => 'utf8',
			'tablePrefix'      => 'mipt_',
		),

		'test_db'      => array(
			'connectionString' => 'mysql:host=localhost;dbname=mipt_test',
			'emulatePrepare'   => true,
			'username'         => 'mipt_test',
			'password'         => 'toor',
			'charset'          => 'utf8',
			'class'            => 'DbConnection',
		),
		'stable_db'    => array(
			'connectionString' => 'mysql:host=localhost;dbname=mipt_stable',
			'emulatePrepare'   => true,
			'username'         => 'mipt_stable',
			'password'         => 'toor',
			'charset'          => 'utf8',
			'class'            => 'DbConnection',
		),


		'errorHandler' => array(
			'errorAction' => 'error/error',
		),

		'log'          => array(
			'class'  => 'CLogRouter',
			'routes' => array(
				array(
					'class'      => 'CFileLogRoute',
					'levels'     => 'trace, info',
					'categories' => 'system.*',
				),
			),
		),

//		'assetManager' => array(
//			'forceCopy' => true,
//		),

		'clientScript' => array(
			'class'              => 'CClientScript',
			'coreScriptPosition' => CClientScript::POS_HEAD,
			'corePackages'       => array(
				'jquery'     => array(
					'basePath' => 'application.media.default',
					'js'       => array('js/jquery-2.0.0.min.js'),
				),
				'main'       => array(
					'basePath' => 'application.media.default',
					'js'       => array('js/main.js'),
					'css'      => array('css/mod.css'),
					'depends'  => array('jquery', 'bootstrap', 'fancybox', 'code'),
				),
				'bootstrap'  => array(
					'basePath' => 'application.media.bootstrap',
					'js'       => array('js/bootstrap.min.js'),
					'css'      => array('css/bootstrap.css', 'css/bootstrap-responsive.css'),
					'depends'  => array('jquery'),
				),
				'fancybox'   => array(
					'basePath' => 'application.media.fancybox',
					'js'       => array('source/jquery.fancybox.js', 'source/jquery.fancybox.pack.js'),
					'css'      => array('source/jquery.fancybox.css'),
					'depends'  => array('jquery'),
				),
				'admin'      => array(
					'basePath' => 'application.media.admin',
					'js'       => array('js/admin.js'),
					'css'      => array('css/main.css'),
					'depends'  => array('main'),
				),
				'code'       => array(
					'basePath' => 'application.media.codemirror',
					'js'       => array('lib/codemirror.js', 'mode/sql/sql.js'),
					'css'      => array('lib/codemirror.css'),
					'depends'  => array('jquery'),
				),
				'fileupload' => array(
					'basePath' => 'application.media.fileupload.js',
					'js'       => array('vendor/jquery.ui.widget.js', 'jquery.iframe-transport.js', 'jquery.fileupload.js', 'upload.js'),
					'depends'  => array('jquery'),
				)

			),
		)
	),

	'params'            => array(
		'adminEmail' => 'lukin.andrej@gmail.com',
	),
);