<?php

/**
 * This is the model class for table "{{test_result}}".
 *
 * The followings are the available columns in table '{{test_result}}':
 * @property integer $id
 * @property integer $test_id
 * @property integer $user_id
 * @property string $start_time
 * @property string $end_time
 * @property integer $answered
 * @property integer $answered_right
 *
 * The followings are the available model relations:
 * @property Answer[] $answers
 * @property User $user
 * @property Test $test
 *
 *
 * @method Result findByPk findByPk($id)
 */
class Result extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Result the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return '{{result}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('test_id, user_id, answered, answered_right', 'numerical', 'integerOnly'=>true),
			array('start_time, end_time', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, test_id, user_id, start_time, end_time, answered, answered_right', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'answers' => array(self::HAS_MANY, 'Answer', 'result_id'),
			'user' => array(self::BELONGS_TO, 'User', 'user_id'),
			'test' => array(self::BELONGS_TO, 'Test', 'test_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'test_id' => 'Test',
			'user_id' => 'User',
			'start_time' => 'Start Time',
			'end_time' => 'End Time',
			'answered' => 'Answered',
			'answered_right' => 'Answered Right',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('test_id',$this->test_id);
		$criteria->compare('user_id',$this->user_id);
		$criteria->compare('start_time',$this->start_time,true);
		$criteria->compare('end_time',$this->end_time,true);
		$criteria->compare('answered',$this->answered);
		$criteria->compare('answered_right',$this->answered_right);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}


	/**
	 * Gets random question from current test
	 * where questions_ids are not in already asked questions
	 *
	 * @return null|Question
	 */
	public function getRandomQuestion(){

 		$question_asked_ids =  ArrayUtils::getValues($this->answers, 'question_id');

		$criteria = new CDbCriteria();
		$criteria->with = array(
			'test' => array(
				'select' => false,
				'conditions' => array(
					'test.id' => $this->test_id,
				)
			)
		);
		$criteria->addNotInCondition('id', $question_asked_ids);
		$criteria->order = 'RAND()';

		return Question::model()->find($criteria);
	}


	/**
	 * if test is completed, return true, false - otherwise
	 * @return bool
	 */
	public function isCompleted(){
		return ($this->answered >= $this->test->question_count);
	}
}