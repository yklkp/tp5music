<?php
namespace app\admin\controller;
use app\admin\controller\Base;
use app\admin\model\User as UserModel;
use app\admin\validate\User as UserValidate;
use think\Url;
use think\Request;
use think\Session;
use think\Db;

class User extends Base
{

	
	public function index()
	{
		return $this->fetch();
	}
	
	

	public function go()
	{
		$data = input('post.');
		//dump($data);die;
		$name = $data['username'];

		

		$result = db('user')->where("username='$name'")->select();
		//dump($result);die;
		
		$realname = Session::get('username');
		//dump($realname);die;
		$id = Db::name('admin')->field('user_id')->where("admin_name='$realname'")->find();
		//dump($id);die;
		$uid = $id['user_id'];
		
		if ($result[0]['username'] == $realname) {
			session('username',$result[0]['username']);
			session('uid',$uid);
			$this->success('管理员登陆成功','admin/index/index');
		} else {
			$this->error('登陆失败','admin/index/login');
		}
	}
	public function rego()
	{
		session(null);
		$this->success('正在切换管理员，请稍后重新登陆','index/user/login');
	}
	
}

