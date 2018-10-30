<?php
namespace app\index\validate;
use think\Validate;
class User extends Validate
{
	protected $rule = [
		'username|用户名'=>'require|min:3',
		'pwd|密码'=>'require|min:6|confirm:repwd',
	];

	protected $message = [
		'username.require'=>'用户名不能为空',
		'username.min'=>'用户名不长度不能少于3位',
		'pwd.require'=>'密码不能为空',
		'pwd.min'=>'密码长度不能少于6位',
		'pwd.confirm'=>'两次密码不一致',
		
	];








}