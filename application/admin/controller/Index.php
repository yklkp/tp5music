<?php
namespace app\admin\controller;
use think\Url;
use think\Controller;
use app\admin\model\Index as IndexModel;
use think\Db;
use think\Request;
use think\Session;

use app\admin\validate\Cname as CnameValidate;

use classa\Clla\Level;

class Index extends Controller
{
	public function index()
	{
		//歌曲
		$ge = Db::name('category_song')->field("count('qid') as count")->select();
		//dump($ge);die;
		$ge2 = Db::name('category_right_song')->field("count('qid') as count")->select();
		$gecount = $ge[0]['count'];
		$gecount2 = $ge2[0]['count'];
		$gequ = $gecount + $gecount2;
		//dump($gequ);die;
		//今日新增
		/*$nowtime = time();
		//dump("$nowtime");die;
		$countid = Db::name('category_song')->field("count('vid') as count")->select();
		$countids = $countid[0]['count'];
		dump($countids);die; 
		$addtime = Db::name('category_song')->field('addtime')->select();
		//dump($addtime);die;
		for(i==0; i < $countids; i++){
			$time = $addtime[i];
			dump($time);die;
			//echo i;
		}*/
		
		
		//博客
		$blog = Db::name('bolg')->field("count('oid') as count")->select();
		//dump($ge);die;
		$blogcount = $blog[0]['count'];
		//dump($blogcount);die;
		
		//用户
		$user = Db::name('user')->field("count('uid') as count")->select();
		//dump($user);die;
		$usercount = $user[0]['count'];
		//dump($usercount);die;
		
		//产品
		$shops = Db::name('shop')->field("count('hid') as count")->select();
		$shops = $shops[0]['count'];
		
		//管理员
		$admin = Db::name('admin')->field("count('xid') as count")->select();
		//dump($admin);die;
		$admincount = $admin[0]['count'];
		//dump($admincount);die;

		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('gequ',$gequ);
		$this->assign('blogcount',$blogcount);
		$this->assign('usercount',$usercount);
		$this->assign('admincount',$admincount);
		$this->assign('shops',$shops);
		return $this->fetch();
	}
	
	public function login()
	{
		return $this->fetch();
	}
	
	//博客
	public function blog_list()
	{
		$data = Db::name('bolg')->select();
		//dump($data);die;
		$counts = Db::name('bolg')->field("count('oid') as count")->where('del=0')->select();
		$counts = $counts[0]['count'];

		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function blog_details()
	{
		$id = input('get.id');
		$result = Db::name('bolg')->where("oid='$id'")->select();

		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		return $this->fetch();
	}

	public function blog_del()
	{
		$data = Db::name('bolg')->select();
		$counts = Db::name('bolg')->field("count('oid') as count")->where('del=1')->select();
		$counts = $counts[0]['count'];
		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function blogdel()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$result1 = Db::name('bolg')->field('del')->where("oid='$id'")->select();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('bolg')->where("oid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//批量删除
	public function qbdel1()
	{
		$ids = $_GET['id'];
		//dump($ids);die;
		
		$d = explode(",",$ids);
		
		foreach($d as $value){
			Db::name('bolg')->where("oid='$value'")->update(['del' => 1]);
		}
		if($d) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	/*回收站博客恢复*/
	public function blogback()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('bolg')->field('del')->where("oid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('bolg')->where("oid='$id'")->update(['del' => 0]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	/*博客列表里的彻底删除*/
	public function delle11()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('bolg')->where("oid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('bolg')->where("oid='$id'")->delete();
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	

	/*回收站里的彻底删除*/
	public function delle1()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('bolg')->field('del')->where("oid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('bolg')->where("oid='$id'")->delete();
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

/**********板   块    操    作**********/
	public function system_category()
	{
		//return '22222';

		$result = Db::name('category')->select();
		//dump($result);die;
		$counts = Db::name('category')->field("count('qid') as count")->select();
		$counts = $counts[0]['count'];
		//$counts = Db::name('category')->select();
		//$counts = count($counts);
		//dump($counts);die;
		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);

		$this->assign('result',$result);
		$this->assign('counts',$counts);
		return $this->fetch();
	}

	public function system_category_edit()
	{
		$a = input('');
		//dump($a);die;
		$b = $a['id'];
		//dump($b);die;
		$c = $a['name'];
		//dump($c);die;
		
		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('b',$b);
		$this->assign('c',$c);
		return $this->fetch();
	}

	public function edit()
	{
		$data = input('post.name');
		//dump($data);die;
		$data1 = input('post.oldname');
		//dump($data1);die;
		if (strlen($data) < 15) {
				$result = Db::name('category')->field('name')->where("name='$data1'")->update(['name'=>$data]);
				//dump($result);die;
				$this->success('修改成功','admin/index/system_category');
				exit;
			} else {
				$this->error('修改失败','admin/index/system_category');
			}
	}

	public function system_category_add()
	{
		$big = Db::name('category')->select();


		$uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('big',$big);
		return $this->fetch();
	}
	public function add()
	{
		$data = input('post.name');
		//dump($data);die;
		
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('image');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;

	    if($info){
	        // 成功上传后 获取上传信息
	        // 输出 jpg
	        //echo $info->getExtension();
	        // 输出 20160820/42a79759f284b767dfcb2a0197904287.jpg
	        //dump($b);
	        // 输出 42a79759f284b767dfcb2a0197904287.jpg
	        //echo $info->getFilename();
	    }else{
	        // 上传失败获取错误信息
	        echo $file->getError();
	    }

	    $a =  $info->getSaveName();
	    // dump($a);die;
	    $b = "uploads\\".$a;
	    //dump($b);die;
	    
	    $counts = Db::name('category')->field("count('qid') as count")->select();
	    //dump($counts);die;
	    $num = $counts[0]['count'];
	    //dump($num);die;
	    $nums = $num + 1;
	    //dump($nums);die;
	    //$result3 = Db::name('category')->where("name='$data'")->update(['orderby' => $nums]);
	    //$result4 = Db::name('category')->field('orderby')->select();
	    //dump($result4);die;

	    if (strlen($data) < 15 && strlen($data) > 0) {
	    	$result = Db::name('category')->insert(['name' => $data]);
	    	//dump($result);die;
	    	$c = Db::name('category')->where("name='$data'")->update(['image' => $b, 'orderby' => $nums]);
	    	$this->success('添加成功','admin/index/system_category');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/system_category');
	    }
	    //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
	    $this->assign('result',$result);
	    $this->assign('c',$c);
	    //$this->assign('result3',$result3);
	    return $this->fetch();
	}

	public function small()
	{
		$data2 = input('post.');
		//dump($data2);die;
		$id1 = $data2['select'];
		//dump($id1);die;
		$name = $data2['name'];
		//dump($name);die;
		$singer = $data2['singer'];
		//dump($singer);die;
		//$result1 = Db::name('category_song')->field('mid')->where("mid='$id1'")->select();
		//dump($result1);die;
		//$id2 = $result1[0]['mid'];
		//dump($id2);die;
		
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($b);die;
	    
	    
	    
	    //$result2 = Db::name('category_song')->insert(['name' => $name, 'mid' => $id1, 'tou' => $bb]);
	    //dump($result2);die;
	   
	    $counts = Db::name('category_song')->field("count('mid') as count")->where("mid='$id1'")->select();
	    //dump($counts);die;
	    $num = $counts[0]['count'];
	    //dump($num);die;
	    $nums = $num + 1;
	    $result2 = Db::name('category_song')->insert(['name' => $name, 'singer' => $singer, 'mid' => $id1, 'tou' => $bb, 'order' => $nums]);
	    
	  
	    if ($result2) {
	    	$this->success('添加成功','admin/index/system_category');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/system_category');
	    }
	    
	}
	public function system_category_details()
	{
		$data = input('get.id');
		//dump($data);die;
		
		$detail = Db::name('category_song')->where("mid='$data'")->select();
		//dump($detail);die;

		$big = Db::name('category')->where("qid='$data'")->field('name')->find();
		//dump($big);die;
		$name = $big['name'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('detail',$detail);
		$this->assign('name',$name);
		return $this->fetch();
	}

	
	public function dell()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_song')->where("vid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	public function system_category_change()
	{
		$vid = input('get.vid');
		//dump($vid);die;
		$result = Db::name('category_song')->where("vid='$vid'")->select();

		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		return $this->fetch();
	}

	public function change()
	{
		$vid = input('post.');
		//dump($vid);die;
		$id = $vid['oldname'];
		$name = $vid['name'];
		$singer = $vid['singer'];
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $tou = "uploads\\".$aa;
	    //dump($b);die;
		$result1 = Db::name('category_song')->where("vid='$id'")->update(['name' => $name, 'tou' => $tou, 'singer' => $singer]);
		if($result1){
			$this->success('修改成功','admin/index/system_category');
		} else {
			$this->error('修改失败','admin/index/system_category');
		}
	}

	/*ajax删除*/
	//大板块删除
	public function delate()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('category')->field('del')->where("qid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category')->where("qid='$id'")->update(['del' => 1]);
			$b = Db::name('category_song')->where("mid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}



	//大板块批量删除
	public function qbdel()
	{
		$ids = $_GET['id'];
		//dump($ids);die;
		
		$d = explode(",",$ids);
		
		foreach($d as $value){
			Db::name('category')->where("qid='$value'")->update(['del' => 1]);
		}
		if($d) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
/**********板     块    结    束************/



/*******右    侧    板    块*********/
	public function system_category_right()
	{

		$result = Db::name('category_right')->select();
		//dump($result);die;
		$counts = Db::name('category_right')->field("count('qid') as count")->select();
		$counts = $counts[0]['count'];
		//$counts = Db::name('category')->select();
		//$counts = count($counts);
		//dump($counts);die;
		
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		$this->assign('counts',$counts);
		return $this->fetch();
	}

	//右板块批量删除
	public function qbdela()
	{
		$ids = $_GET['id'];
		//dump($ids);die;
		
		$d = explode(",",$ids);
		
		foreach($d as $value){
			Db::name('category_right')->where("qid='$value'")->update(['del' => 1]);
		}
		if($d) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	public function system_category_add_r()
	{
		$big = Db::name('category_right')->select();


		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('big',$big);
		return $this->fetch();
	}
	public function add_r()
	{
		$data = input('post.name');
		//dump($data);die;
	    if (strlen($data) < 15 && strlen($data) > 0) {
	    	$result = Db::name('category_right')->insert(['name' => $data]);
	    	//dump($result);die;
	    	
	    	$this->success('添加成功','admin/index/system_category_right');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/system_category_right');
	    }
	     //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
	    $this->assign('result',$result);
	  
	    //$this->assign('result3',$result3);
	    return $this->fetch();
	}

	public function small_r()
	{
		$data2 = input('post.');
		//dump($data2);die;
		$id1 = $data2['select'];
		//dump($id1);die;
		$name = $data2['name'];
		//dump($name);die;
		$singer = $data2['singer'];
		//dump($singer);die;
		//$result1 = Db::name('category_song')->field('mid')->where("mid='$id1'")->select();
		//dump($result1);die;
		//$id2 = $result1[0]['mid'];
		//dump($id2);die;
		
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($b);die;
	    
	    
	    
	   
	    $result2 = Db::name('category_right_song')->insert(['name' => $name, 'singer' => $singer, 'mid' => $id1, 'tou' => $bb]);
	    
	  
	    if ($result2) {
	    	$this->success('添加成功','admin/index/system_category_right');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/system_category_right');
	    }
	    
	}

	public function system_category_edit_r()
	{
		$a = input('');
		//dump($a);die;
		$b = $a['id'];
		//dump($b);die;
		$c = $a['name'];
		//dump($c);die;
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('b',$b);
		$this->assign('c',$c);
		return $this->fetch();
	}

	public function edit_r()
	{
		$data = input('post.name');
		//dump($data);die;
		$data1 = input('post.oldname');
		//dump($data1);die;
		if (strlen($data) < 15) {
				$result = Db::name('category_right')->field('name')->where("name='$data1'")->update(['name'=>$data]);
				//dump($result);die;
				$this->success('修改成功','admin/index/system_category_right');
				exit;
			} else {
				$this->error('修改失败','admin/index/system_category_right');
			}
	}

	

	
	public function system_category_details_r()
	{
		$data = input('get.id');
		//dump($data);die;
		
		$detail = Db::name('category_right_song')->where("mid='$data'")->select();
		//dump($detail);die;

		$big = Db::name('category_right')->where("qid='$data'")->field('name')->find();
		//dump($big);die;
		$name = $big['name'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('detail',$detail);
		$this->assign('name',$name);
		return $this->fetch();
	}

	
	public function dell_r()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_right_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_right_song')->where("vid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	public function system_category_change_r()
	{
		$vid = input('get.vid');
		//dump($vid);die;
		$result = Db::name('category_right_song')->where("vid='$vid'")->select();

		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		return $this->fetch();
	}

	public function change_r()
	{
		$vid = input('post.');
		//dump($vid);die;
		$id = $vid['oldname'];
		$name = $vid['name'];
		$singer = $vid['singer'];
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $tou = "uploads\\".$aa;
	    //dump($b);die;
		$result1 = Db::name('category_right_song')->where("vid='$id'")->update(['name' => $name, 'tou' => $tou, 'singer' => $singer]);
		if($result1){
			$this->success('修改成功','admin/index/system_category_right');
		} else {
			$this->error('修改失败','admin/index/system_category_right');
		}
	}

	/*ajax删除*/
	//大板块删除
	public function delate_r()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('category_right')->field('del')->where("qid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_right')->where("qid='$id'")->update(['del' => 1]);
			$b = Db::name('category_right_song')->where("mid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}



/*********左    板    块    结    束***************/

/***********歌     曲     管     理**************/
	public function song_list()
	{
		//下面板块的歌曲
		$detail = Db::name('category_song')->select();
		//dump($detail);die;

		//右板块的歌曲
		$big = Db::name('category_right_song')->select();
		//dump($big);die;
		
		$conts1 = Db::name('category_song')->field("count('vid') as count")->select();
		//dump($conts);die;
		$conts1 = $conts1[0]['count'];
		$conts2 = Db::name('category_right_song')->field("count('vid') as count")->select();
		//dump($conts);die;
		$conts2 = $conts2[0]['count'];
		$counts = $conts1 + $conts2;

		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('detail',$detail);
		$this->assign('big',$big);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function song_add()
	{
		//下面的板块
		$big = Db::name('category')->select();


		$uid = Session::get('uid');
		//dump($uid);die; 
		
		//右边的板块	
		$big1 = Db::name('category_right')->select();
		$this->assign('big1',$big1);

		$this->assign('uid',$uid);
		$this->assign('big',$big);
		return $this->fetch();
	}
	//右
	public function ssd()
	{
		$data2 = input('post.');
		//dump($data2);die;
		$id1 = $data2['select'];
		//dump($id1);die;
		$name = $data2['name'];
		//dump($name);die;
		$singer = $data2['singer'];
		//dump($singer);die;
		//$result1 = Db::name('category_song')->field('mid')->where("mid='$id1'")->select();
		//dump($result1);die;
		//$id2 = $result1[0]['mid'];
		//dump($id2);die;
		
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($bb);die;
	    
	    
	    
	    //$result2 = Db::name('category_song')->insert(['name' => $name, 'mid' => $id1, 'tou' => $bb]);
	    //dump($result2);die;
	   
	   
	    $result2 = Db::name('category_right_song')->insert(['name' => $name, 'singer' => $singer, 'mid' => $id1, 'tou' => $bb]);
	    if ($result2) {
	    	$this->success('添加成功','admin/index/song_list');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/song_list');
	    }
	}
	//下
	public function sdd()
	{
		$data2 = input('post.');
		//dump($data2);die;
		$id1 = $data2['select'];
		//dump($id1);die;
		$name = $data2['name'];
		//dump($name);die;
		$singer = $data2['singer'];
		//dump($singer);die;
		//$result1 = Db::name('category_song')->field('mid')->where("mid='$id1'")->select();
		//dump($result1);die;
		//$id2 = $result1[0]['mid'];
		//dump($id2);die;
		
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($bb);die;
	    
	    
	    
	    //$result2 = Db::name('category_song')->insert(['name' => $name, 'mid' => $id1, 'tou' => $bb]);
	    //dump($result2);die;
	   
	    $counts = Db::name('category_song')->field("count('mid') as count")->where("mid='$id1'")->select();
	    //dump($counts);die;
	    $num = $counts[0]['count'];
	    //dump($num);die;
	    $nums = $num + 1;
	    $result2 = Db::name('category_song')->insert(['name' => $name, 'singer' => $singer, 'mid' => $id1, 'tou' => $bb, 'order' => $nums]);
	    
	  
	    if ($result2) {
	    	$this->success('添加成功','admin/index/song_list');
	    	exit;
	    } else {
	    	$this->error('添加失败','admin/index/song_list');
	    }
	}
	public function song_del()
	{
		$data1 = Db::name('category_song')->where('del=1')->select();
		//dump($data1);die;
		$data2 = Db::name('category_right_song')->where('del=1')->select();
		//dump($data2);die;
		
		//积分判断等级
		$le = new Level();
		$conts1 = Db::name('category_song')->field("count('vid') as count")->where('del=1')->select();
		//dump($conts);die;
		$conts1 = $conts1[0]['count'];
		$conts2 = Db::name('category_right_song')->field("count('vid') as count")->where('del=1')->select();
		//dump($conts);die;
		$conts2 = $conts2[0]['count'];
		$counts = $conts1 + $conts2;
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('le',$le);
		$this->assign('data1',$data1);
		$this->assign('data2',$data2);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function del1()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_song')->where("vid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	public function del2()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_right_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_right_song')->where("vid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//彻底删除
	public function delly()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_right_song')->where("vid='$id'")->delete();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	public function dellx()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$mid = input('get.mid');

		$result1 = Db::name('category_song')->where("vid='$id'")->delete();
		//dump($result);die;
		if($result1) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//回收站歌曲恢复
	public function backed()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('category_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_song')->where("vid='$id'")->update(['del' => 0]);
		} else {
			echo json_encode(['state' => 0],true);
			$b = Db::name('category_right_song')->where("vid='$id'")->update(['del' => 0]);
		}
	}

	//回收站歌曲彻底删除
	public function deepdeled()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('category_song')->field('del')->where("vid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('category_song')->where("vid='$id'")->delete();
		} else {
			echo json_encode(['state' => 0],true);
			$a = Db::name('category_right_song')->where("vid='$id'")->delete();
		}
	}
	
	//编辑
	public function song_edit()
	{
		$id = input('get.id');
		//dump($id);die;
		$n = input('get.n');
		//dump($n);die;
		$result = Db::name('category_song')->where("vid='$id'")->select();
		if($result){
			$mid = $result[0]['mid'];
			//dump($mid);die;
			$name = Db::name('category')->field('name')->where("qid='$mid'")->find();
			$name1 = $name['name'];

			$this->assign('mid',$mid);
			$this->assign('name1',$name1);
		}
		
		$result1 = Db::name('category_right_song')->where("vid='$id'")->select();
		//dump($result1);die;
		if($result1){
			$mid1 = $result1[0]['mid'];
			//dump($mid1);die;
			$names = Db::name('category_right')->field('name')->where("qid='$mid1'")->find();
			$name2 = $names['name'];

			$this->assign('mid1',$mid1);
			$this->assign('name2',$name2);
		}

		$conts1 = Db::name('category_song')->field("count('vid') as count")->where('del=0')->select();
		//dump($conts);die;
		$conts1 = $conts1[0]['count'];
		$conts2 = Db::name('category_right_song')->field("count('vid') as count")->where('del=0')->select();
		//dump($conts);die;
		$conts2 = $conts2[0]['count'];
		$counts = $conts1 + $conts2;
		
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('id',$id);
		$this->assign('n',$n);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function edita()
	{
		$data = input('');
		//dump($data);die;
		$m = input('get.m');
		//dump($m);die;
		// 获取表单上传文件 例如上传了001.jpg
	    $file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($bb);die;
	    $name = $data['name'];
	    $singer = $data['singer'];
	    //dump($singer);die;
	    
	    $result = Db::name('category_song')->field('name')->where("name='$m'")->find();
	    if($result) {
	    	$changes = Db::name('category_song')->where("name='$m'")->update(['name' => $name, 'singer' => $singer, 'tou' => $bb]);
	    	$this->success('修改分类栏成功','admin/index/song_list');
	    } else {
	    	$changes = Db::name('category_right_song')->where("name='$m'")->update(['name' => $name, 'singer' => $singer, 'tou' => $bb]);
	    	$this->success('修改右边栏歌曲成功','admin/index/song_list');
	    }
	    
	}


/***********管     理      员    管     理**************/
	public function admin_role()
	{
		$adminer = Db::name('admin')->select();
		//dump($adminer);die;
		$conts = Db::name('admin')->field("count('xid') as count")->select();
		//dump($conts);die;
		$conts = $conts[0]['count'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('adminer',$adminer);
		$this->assign('conts',$conts);
		return $this->fetch();
	}
	public function admin_list()
	{
		
		return $this->fetch();
	}
	public function admin_permission()
	{
		
		return $this->fetch();
	}
	//type=3管理范围
	public function power()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('admin')->field('type')->where("user_id='$id'")->find();
		//dump($result);die;
		if($result['type'] == 3 || $result['type'] == 1) {
			echo json_encode(['state' => 1],true);
			
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//type=2管理范围
	public function pow()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('admin')->field('type')->where("user_id='$id'")->find();
		//dump($result);die;
		if($result['type'] == 2 || $result['type'] == 1) {
			echo json_encode(['state' => 1],true);
			
		} else {
			echo json_encode(['state' => 0],true);
		}
	}



/**********会     员    管   理   操   作***********/
	public function member_list()
	{

		$data = Db::name('user')->select();
		//dump($data);die;
		$conts = Db::name('user')->field("count('uid') as count")->select();
		//dump($conts);die;
		$conts = $conts[0]['count'];
		

		//积分判断等级
		$le = new Level();

		$this->assign('le',$le);
		
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('conts',$conts);
		return $this->fetch();
	}
	public function userdel()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('user')->field('del')->where("uid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('user')->where("uid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	public function member_del()
	{
		$data = Db::name('user')->select();
		//dump($data);die;
		
		//积分判断等级
		$le = new Level();
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('le',$le);
		$this->assign('data',$data);
		return $this->fetch();
	}
	/*回收站会员恢复*/
	public function rego()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('user')->field('del')->where("uid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('user')->where("uid='$id'")->update(['del' => 0]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	/*回收站里的彻底删除*/
	public function delle()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('user')->field('del')->where("uid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('user')->where("uid='$id'")->delete();
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//用户禁止
	public function lock()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('user')->field('lock')->where("uid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('user')->where("uid='$id'")->update(['lock' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//用户开启
	public function open()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('user')->field('lock')->where("uid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('user')->where("uid='$id'")->update(['lock' => 0]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	public function member_add()
	{
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		return $this->fetch();
	}
	public function addperson()
	{
		$data = input('post.');
		//dump($data);die;
		$username = $data['username'];
		$pwd = $data['pwd'];
		$tel = $data['tel'];
		$email = $data['email'];
		$counts = $data['counts'];
		$ip = $data['ip'];

		$file = request()->file('tou');
	    //dump($file);die;
	    // 移动到框架应用根目录/public/uploads/ 目录下
	    $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	   // dump($info);die;
	    $aa =  $info->getSaveName();
	    // dump($a);die;
	    $bb = "uploads\\".$aa;
	    //dump($b);die;
	    
	    $result = Db::name('user')->insert(['username' => $username, 'pwd' => $pwd, 'tel' => $tel, 'email' => $email, 'counts' => $counts, 'tou' => $bb, 'ip' => $ip]);
	    //dump($result);die;

	    if($result) {
	    	$this->success('添加成功');
	    } else {
	    	$this->error('添加失败','admin/index/member_add');
	    }
		
	}
	public function change_password()
	{
		$data = input('get.id');
		//dump($data);die;
		$result = Db::name('user')->where("uid='$data'")->select();

		$realname = Session::get('username');
		//dump($realname);die;
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		return $this->fetch();
	}
	public function pass()
	{
		$data = input('');
		
		//dump($data);die;
		$id = $data['id'];
		//dump($id);die;
		$old = $data['oldpwd'];
		//dump($old);
		$newpwd = $data['newpassword'];
		//dump($newpwd);


		if($old === $newpwd) {
			$this->error('不能与原密码相同','admin/index/member_list');
			exit;
		} else {
			$result = Db::name('user')->where("uid='$id'")->update(['pwd' => $newpwd]);
			$name = Db::name('user')->field('username')->where("uid='$id'")->find();
			//dump($name);
			$name = $name['username'];
			$realname = Session::get('username');
			//dump($realname);die;
			if($name === $realname) {
				$this->success('修改成功，正在退出，稍后重新登陆','index/user/outlogin');
			} else {
				$this->success('修改成功','admin/index/member_list');
			}
			
		}
	}
	public function member_dengji()
	{
		$data = input('get.id');
		$result = Db::name('user')->where("uid='$data'")->select();
		//dump($result);die;
		$name = $result[0]['username'];

		//积分判断等级
		$le = new Level();
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('le',$le);

		$this->assign('result',$result);
		$this->assign('name',$name);
		return $this->fetch();
	}
	public function dengji()
	{
		$data1 = input('');
		//dump($data1);die;
		$id = $data1['id'];
		$count = $data1['counts'];
		//dump($id);die;
		//dump($count);die;
		
		$counts = Db::name('user')->where("uid='$id'")->update(['counts' => $count]);
		$this->success('修改成功','admin/index/member_list');
	}

	//成员批量删除
	public function alldel()
	{
		$ids = $_GET['id'];
		//dump($ids);die;
		
		$d = explode(",",$ids);
		
		foreach($d as $value){
			Db::name('user')->where("uid='$value'")->update(['del' => 1]);
		}
		if($d) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	
	public function member_record_download()
	{
		
		return $this->fetch();
	}
	
	public function member_level()
	{
		
		return $this->fetch();
	}
/*********用     户   管    理    结    束***********/


/*********评     论     管    理*********/
	public function feedback_list()
	{
		//查出用户
		$user = Db::name('user')->select();
		//评论的歌曲
		$result = Db::name('pinlun')->order('istop','desc')->select();
		//dump($result);die;
		
		$conts = Db::name('pinlun')->field("count('pid') as count")->where('del=0')->select();
		//dump($conts);die;
		$conts = $conts[0]['count'];

		//回复数量
		$conts1 = Db::name('pinlun')->field("count('pid') as count")->where('replayId=1')->select();
		//dump($conts);die;
		$conts1 = $conts1[0]['count'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		$this->assign('conts',$conts);
		$this->assign('conts1',$conts1);
		$this->assign('user',$user);
	
		return $this->fetch();
	}
	
	public function feedback_content()
	{
		//以置顶的顺序排列
		$result1 = Db::name('pinlun')->order('istop','desc')->select();
		//dump($result1);die;
		$songName = input('get.songName');
		//dump($songName);die;
		//查询回复的帖子
		$replay = Db::name('pinlun')->where('replayId = 1')->select();
		//dump($replay);die;
		$count = Db::name('pinlun')->field("count('replayId') as count")->where("songName='$songName' && replayId=1")->select();
		//dump($count);die;
		$cont = $count[0]['count'];
		//dump($cont);die;
		//判断是否有回帖的
		$re = Db::name('pinlun')->field('replayId')->where("songName='$songName'")->select();
		//dump($re);die;
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result1',$result1);
		$this->assign('songName',$songName);
		$this->assign('replay',$replay);
		$this->assign('cont',$cont);
		$this->assign('re',$re);
		return $this->fetch();
	}
	//置顶
	public function istop()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		//$songName = input('get.songName');
		//dump($songName);die;

		$result1 = Db::name('pinlun')->field('istop')->where("pid='$id'")->select();
		//dump($result1);die;
		$top = $result1[0]['istop'];
		if($top == 0) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('pinlun')->where("pid='$id'")->update(['istop' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
			$b = Db::name('pinlun')->where("pid='$id'")->update(['istop' => 0]);
		}
	}
	//楼主删除
	public function shan()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$result2 = Db::name('pinlun')->field('del')->where("pid='$id'")->select();
		//dump($result2);die;
		if($result2) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('pinlun')->where("pid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//回帖删除
	public function shana()
	{
		//dump($_GET);die;
		$id = input('get.id');
		//dump($id);die;
		$result2 = Db::name('pinlun')->field('del')->where("pid='$id'")->select();
		//dump($result2);die;
		if($result2) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('pinlun')->where("pid='$id'")->update(['del' => 1]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	//删除的帖子回收站
	public function feedback_back()
	{
		//查出用户
		$user = Db::name('user')->select();
		//评论的歌曲
		$result = Db::name('pinlun')->where('del=1')->select();
		$conts = Db::name('pinlun')->field("count('pid') as count")->where('del=1')->select();
		//dump($conts);die;
		$conts = $conts[0]['count'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('result',$result);
		$this->assign('conts',$conts);
		$this->assign('user',$user);
		return $this->fetch();
	}
	//回收站评论恢复
	public function back()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('pinlun')->field('del')->where("pid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('pinlun')->where("pid='$id'")->update(['del' => 0]);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}

	//回收站评论彻底删除
	public function deepdel()
	{
		//dump($_GET);
		$id = input('get.id');
		//dump($id);die;
		$result = Db::name('pinlun')->field('del')->where("pid='$id'")->select();
		//dump($result);die;
		if($result) {
			echo json_encode(['state' => 1],true);
			$a = Db::name('pinlun')->where("pid='$id'")->delete();
		} else {
			echo json_encode(['state' => 0],true);
		}
	}


	//评论批量删除
	public function pindel()
	{
		$ids = $_GET['id'];
		//dump($ids);die;
		
		$d = explode(",",$ids);
		
		foreach($d as $value){
			Db::name('pinlun')->where("pid='$value'")->update(['del' => 1]);
		}
		if($d) {
			echo json_encode(['state' => 1],true);
		} else {
			echo json_encode(['state' => 0],true);
		}
	}
	
/*********评   论    结    束************/


/**************产 品******************/

	
	public function product_brand()
	{
		$data = Db::name('ding')->select();
		//dump($data);die;
		$count = Db::name('ding')->field("count('sid') as count")->select();
		$counts = $count[0]['count'];
		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	
	public function product_list()
	{
		$data = Db::name('shop')->select();
		//dump($data);die;
		$count = Db::name('shop')->field("count('hid') as count")->select();
		$counts = $count[0]['count'];

		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('counts',$counts);
		return $this->fetch();
	}
	public function product_category()
	{
		$ddan = input('get.ddan');
		//dump($ddan);die;

		$hid = Db::name('xiang')->field('hid')->find();
		//dump($hid);die;
		$hid = $hid['hid'];
		$data = Db::name('shop')->where("hid='$hid'")->select();
		//dump($data);die;
		$count = Db::name('shop')->field("count('hid') as count")->select();
		$counts = $count[0]['count'];

		 //权限
	    $uid = Session::get('uid');
		//dump($uid);die; 
		
		$this->assign('uid',$uid);
		$this->assign('data',$data);
		$this->assign('counts',$counts);
		return $this->fetch();
	}


}
