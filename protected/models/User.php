<?php

/**
 * This is the model class for table "{{user}}".
 *
 * The followings are the available columns in table '{{user}}':
 *
 * @property integer      $id
 * @property string       $name
 * @property string       $surname
 * @property integer      $group_id
 * @property string       $email
 * @property string       $password
 *
 * The followings are the available model relations:
 * @property Group        $group
 * @property Result[]   $results
 *
 *
 * @method User findByPk findByPk($id)
 */
class User extends CActiveRecord
{

	private static $self_model = null;
	/**
	 * Returns the static model of the specified AR class.
	 *
	 * @param string $className active record class name.
	 *
	 * @return User the static model class
	 */
	public static function model($className = __CLASS__) {
		return parent::model($className);
	}


	/**
	 * Returns current user model
	 * @return User
	 */
	public static function get(){
		if(is_null(self::$self_model)){
			self::$self_model = self::model()->findByPk(Yii::app()->user->getId());
		}
		return self::$self_model;
	}


	/**
	 * @return string the associated database table name
	 */
	public function tableName() {
		return '{{user}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules() {
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('group_id', 'numerical', 'integerOnly' => true),
			array('name, surname, email', 'length', 'max' => 45),
			array('password', 'length', 'max' => 50),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, surname, group_id, email, password', 'safe', 'on' => 'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations() {
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'group'         => array(self::BELONGS_TO, 'Group', 'group_id'),
			'results'       => array(self::HAS_MANY, 'Result', 'user_id')
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels() {
		return array(
			'id'       => 'ID',
			'name'     => 'Имя',
			'surname'  => 'Фамилия',
			'group_id' => 'Группа',
			'email'    => 'Email',
			'password' => 'Пароль',
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
		$criteria->compare('surname', $this->surname, true);
		$criteria->compare('group_id', $this->group_id);
		$criteria->compare('email', $this->email, true);
		$criteria->compare('password', $this->password, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}

	protected  function beforeSave(){
		$this->password = MiscUtils::password($this->password);
		return true;
	}


	/**
	 * Check that user has specified test
	 * @param $test_id
	 *
	 * @return bool
	 */
	public function hasTest($test_id){
		$test_ids = ArrayUtils::getValues($this->group->tests);
		return in_array($test_id, $test_ids);
	}


}