<?php

/**
 * This is the model class for table "{{group}}".
 *
 * The followings are the available columns in table '{{group}}':
 *
 * @property integer    $id
 * @property string     $name
 * @property integer    $institute_id
 *
 * The followings are the available model relations:
 * @property Institute  $institute
 * @property User[]     $users
 * @property int        $testsCount
 * @property Test[]     $tests
 */
class Group extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 *
	 * @param string $className active record class name.
	 *
	 * @return Group the static model class
	 */
	public static function model($className = __CLASS__) {
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName() {
		return '{{group}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules() {
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('institute_id', 'numerical', 'integerOnly' => true),
			array('name', 'length', 'max' => 45),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, institute_id', 'safe', 'on' => 'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations() {
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'institute'  => array(self::BELONGS_TO, 'Institute', 'institute_id'),
			'tests'      => array(self::MANY_MANY, 'Test', 'mipt_group_test(test_id, group_id)'),
			'testsCount' => array(self::STAT, 'Test', 'mipt_group_test(test_id, group_id)'),
			'users'      => array(self::HAS_MANY, 'User', 'group_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels() {
		return array(
			'id'         => 'ID',
			'name'       => 'Группа (номер)',
			'institute'  => 'Институт',
			'institute_id' => 'Институт',
			'testsCount' => 'Назначенных тестов',
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
		$criteria->compare('institute', $this->institute);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}


	public function getDeleteUrl() {
		return Yii::app()->createUrl('/admin/group/delete', array('id' => $this->id));
	}

	public function getUpdateUrl() {
		return Yii::app()->createUrl('/admin/group/update', array('id' => $this->id));

	}

	public function behaviors(){
		return array( 'CAdvancedArBehavior' => array(
			'class' => 'admin.extensions.CAdvancedArBehavior.CAdvancedArBehavior'));
	}
}