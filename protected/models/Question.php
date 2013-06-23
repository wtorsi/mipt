<?php

/**
 * This is the model class for table "{{question}}".
 *
 * The followings are the available columns in table '{{question}}':
 *
 * @property integer  $id
 * @property string   $question
 * @property string   $answer
 * @property integer  $branch_id
 *
 * The followings are the available model relations:
 * @property Branch   $branch
 * @property Result[] $results
 * @property Test     $test
 */
class Question extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 *
	 * @param string $className active record class name.
	 *
	 * @return Question the static model class
	 */
	public static function model($className = __CLASS__) {
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName() {
		return '{{question}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules() {
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('branch_id', 'numerical', 'integerOnly' => true),
			array('question, answer', 'length', 'max' => 400),
			array('question, answer', 'required'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, question, answer, branch_id', 'safe', 'on' => 'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations() {
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'branch'  => array(self::BELONGS_TO, 'Branch', 'branch_id'),
			'results' => array(self::BELONGS_TO, 'Result', 'question_id'),
			'test'    => array(self::HAS_ONE, 'Test', array('id' => 'branch_id'), 'through' => 'branch'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels() {
		return array(
			'id'        => 'ID',
			'question'  => 'Вопрос',
			'answer'    => 'Ответ',
			'branch_id' => 'Раздел',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search() {
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria = new CDbCriteria;

		$criteria->compare('id', $this->id);
		$criteria->compare('question', $this->question, true);
		$criteria->compare('answer', $this->answer, true);
		$criteria->compare('branch_id', $this->branch_id);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}