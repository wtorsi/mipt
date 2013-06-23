<?php

/**
 * This is the model class for table "{{institute}}".
 *
 * The followings are the available columns in table '{{institute}}':
 * @property integer $id
 * @property string $name
 *
 * The followings are the available model relations:
 * @property Group[] $groups
 */
class Institute extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Institute the static model class
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
		return '{{institute}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name', 'length', 'max'=>45),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name', 'safe', 'on'=>'search'),
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
			'groups' => array(self::HAS_MANY, 'Group', 'institute_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Название',
			'groups'    => 'Группы'
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
		$criteria->compare('name',$this->name,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	public function getDeleteUrl() {
		return Yii::app()->createUrl('/admin/institute/delete', array('id' => $this->id));
	}

	public function getUpdateUrl() {
		return Yii::app()->createUrl('/admin/institute/update', array('id' => $this->id));

	}

	public function getGroupsList(){
		$vals = 'Групп пока нет';
		if(!empty($this->groups)){
			/**
			 * @var $group Group
			 */
			$vals = array();
			foreach($this->groups as  $group){
				$vals[] = $group->name;
			}
			$vals = implode(',', $vals);
		}

		return $vals;
	}
}