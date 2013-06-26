<?php

/**
 * This is the model class for table "{{answer}}".
 *
 * The followings are the available columns in table '{{answer}}':
 * @property integer $id
 * @property integer $question_id
 * @property string $answer
 * @property integer $is_right
 * @property integer $result_id
 *
 * The followings are the available model relations:
 * @property Result $result
 * @property Question $question
 */
class Answer extends CActiveRecord
{

	public $salt;

	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Answer the static model class
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
		return '{{answer}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('question_id, is_right, result_id', 'numerical', 'integerOnly'=>true),
			array('answer', 'length', 'max'=>400),

			array('salt', 'salt',),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, question_id, answer, is_right, result_id', 'safe', 'on'=>'search'),
		);
	}

	public function salt($attribute, $params){
		$salt     = MiscUtils::salt(User::get()->id . $this->result->test_id . $this->result_id . $this->question_id);
		if($this->$attribute != $salt){
			$this->addError($attribute, 'Хэш не совпадает');
		};
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'result' => array(self::BELONGS_TO, 'Result', 'result_id'),
			'question' => array(self::BELONGS_TO, 'Question', 'question_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'question_id' => 'Question',
			'answer' => 'Answer',
			'is_right' => 'Is Right',
			'result_id' => 'Result',

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
		$criteria->compare('question_id',$this->question_id);
		$criteria->compare('answer',$this->answer,true);
		$criteria->compare('is_right',$this->is_right);
		$criteria->compare('result_id',$this->result_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	protected function beforeSave(){

		$is_right = false;

		try{
			/**
			 * @var $test_db DbConnection
			 */
			$test_db = Yii::app()->test_db;
			$stable_answer =   $this->question->answer;
			$test_answer = $this->answer;

			$test_cnt =  $test_db->createCommand("SELECT count(*) FROM (" . $test_answer . ") test_ans")->queryScalar();
			$stable_cnt = $test_db->createCommand("SELECT count(*) FROM (" . $stable_answer . ") stable_ans ")->queryScalar();

			$union_query = "SELECT count(*) FROM ( (" . $test_answer . ")  UNION (" . $stable_answer . ")  ) as union_table ";
			$union_cnt = $test_db->createCommand($union_query)->queryScalar();

			$is_right = ($test_cnt == $stable_cnt and $union_cnt == $stable_cnt);
		}
		catch(CDbException $e){}
		$this->is_right = $is_right;

		return true;
	}
}