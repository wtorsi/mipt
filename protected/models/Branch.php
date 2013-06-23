<?php

/**
 * This is the model class for table "{{branch}}".
 *
 * The followings are the available columns in table '{{branch}}':
 *
 * @property integer    $id
 * @property string     $name
 *
 * The followings are the available model relations:
 * @property Question[] $questions
 * @property Test[]     $tests
 * @property int        $questionsCount
 */
class Branch extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 *
	 * @param string $className active record class name.
	 *
	 * @return Branch the static model class
	 */
	public static function model($className = __CLASS__) {
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName() {
		return '{{branch}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules() {
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name', 'length', 'max' => 45),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name', 'safe', 'on' => 'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations() {
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'questions'      => array(self::HAS_MANY, 'Question', 'branch_id'),
			'tests'          => array(self::HAS_MANY, 'Test', 'branch_id'),
			'questionsCount' => array(self::STAT, 'Question', 'branch_id')
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels() {
		return array(
			'id'   => 'ID',
			'name' => 'Название',
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
		$criteria->compare('name', $this->name, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}


	public function getDeleteUrl() {
		return Yii::app()->createUrl('admin/branch/delete', array('id' => $this->id));
	}

	public function getUpdateUrl() {
		return Yii::app()->createUrl('admin/branch/update', array('id' => $this->id));

	}
}