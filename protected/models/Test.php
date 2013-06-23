<?php

/**
 * This is the model class for table "{{test}}".
 *
 * The followings are the available columns in table '{{test}}':
 *
 * @property integer             $id
 * @property integer             $question_count
 * @property integer             $branch_id
 * @property string              $name
 *
 * The followings are the available model relations:
 * @property Branch              $branch
 * @property Group[]             $groups
 * @property Question[]          $questions
 *
 * @method Test findByPk findByPk($id)
 */
class Test extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 *
	 * @param string $className active record class name.
	 *
	 * @return Test the static model class
	 */
	public static function model($className = __CLASS__) {
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName() {
		return '{{test}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules() {
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('question_count, branch_id', 'numerical', 'integerOnly' => true),
			array('name', 'length', 'max' => 45),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, question_count, branch_id, name', 'safe', 'on' => 'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations() {
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'branch'    => array(self::BELONGS_TO, 'Branch', 'branch_id'),
			'groups'    => array(self::MANY_MANY, 'Group', 'mipt_group_test(test_id, group_id)'),
			'questions' => array(self::HAS_MANY, 'Question', array('id' => 'branch_id'), 'through' => 'branch'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels() {
		return array(
			'id'             => 'ID',
			'question_count' => 'Кол-во  вопросов',
			'branch_id'      => 'Раздел',
			'name'           => 'Название теста',
			'groups'         => 'Назначенные группы'
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
		$criteria->compare('question_count', $this->question_count);
		$criteria->compare('branch_id', $this->branch_id);
		$criteria->compare('name', $this->name, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}

	public function getDeleteUrl() {
		return Yii::app()->createUrl('/admin/test/delete', array('id' => $this->id));
	}

	public function behaviors() {
		return array(
			'CAdvancedArBehavior' => array(
				'class' => 'admin.extensions.CAdvancedArBehavior.CAdvancedArBehavior'
			)
		);
	}
}