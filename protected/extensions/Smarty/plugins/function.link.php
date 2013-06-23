<?php
/**
 * Allows to generate links using CHtml::link().
 *
 * Syntax:
 * {link text="test"}
 * {link text="test" url="controller/action?param=value"}
 * {link text="test" url="/absolute/url"}
 * {link text="test" url="http://host/absolute/url"}
 *
 * @see CHtml::link().
 *
 * @param $params
 * @param $smarty
 * @return string
 * @throws CException
 */

function smarty_function_link($params, &$smarty){
    if(empty($params['text'])){
        throw new CException("Function 'text' parameter should be specified.");
    }
    
    $text = empty($params['text']) ? '#' : $params['text'];
    $options = empty($params['options']) ? array() : $params['options'];    
    $url = empty($params['url']) ? '#' : $params['url'];

	if(!empty($params['class'])){
		$options['class'] = $params['class'];
	}



    return CHtml::link($text, $url, $options);
}