<?php
namespace app\admin\validate;
use think\Validate;
class Cname extends Validate
{
	protected $rule = [
		'name|用户名'=>'require|max:4',
		'password|密码'=>'require|min:6|confirm:repassword',
	];

	protected $message = [
		'name.require'=>'用户名不能为空',
		'name.max'=>'长度不能大于4位',
		'password.require'=>'密码不能为空',
		'password.min'=>'密码长度不能少于6位',
		'password.confirm'=>'两次密码不一致',
		
	];








}