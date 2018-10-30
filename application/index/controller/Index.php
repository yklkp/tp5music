<?php
namespace app\index\controller;
use think\Url;
use think\Db;
use think\Session;
use think\Controller;
use app\index\model\Person as PersonModel;
//use app\index\validate\Person as PersonValidate;
use music\MusicSrc\Music;
use music\MusicSrc\Page;
use music\MusicSrc\Pin;

class Index extends Controller
{
	
	public function index()
	{
		$result = Db::name('category')->order('qid','asc')->select();
		//dump($result);die;
		$data = Db::name('category_song')->select();
		//dump($data);
		
		//右
		$result1 = Db::name('category_right')->order('qid','asc')->select();
		//dump($result);die;
		$data1 = Db::name('category_right_song')->select();
		//dump($data);
		
		$va = Db::name('category')->field('qid')->select();
		//dump($va);die;
		$a = Db::name('category_song')->field('mid')->select();
		//dump($a);die;

		$counts = Db::name('category_song')->field("count('mid') as count")->select();
	    //dump($counts);die;
	    $num = $counts[0]['count'];
	    //dump($num);die;
	    $nums = $num + 1;
	    //$result3 = Db::name('category_song')->where("name='$name'")->update(['order' => $nums]);
	    $result4 = Db::name('category_song')->field('order')->select();
	    //dump($result4);die;
		$res = Db::table('music_hotsiner')->field('author,tu')->limit(0,8)->select();

		$uid = Session::get('uid');
		//dump($uid);die;
		$tou = Db::name('user')->where("uid='$uid'")->select();
		//dump($tou);die;
		
		
		$this->assign('res',$res);

		
		$this->assign('result',$result);
		$this->assign('result1',$result1);
		$this->assign('data',$data);
		$this->assign('data1',$data1);
		$this->assign('tou',$tou);
		
		//$this->assign('result3',$result3);
		return $this->fetch();
	}

	
	public function sou()
	{
		
		
	if(!empty($_POST)){
		
		$me = $_POST['name'];
		
		//var_dump($name);
		$api = new Music();
		$result = $api->search($me,15);
		$result = json_decode($result,true);
		$songName = $result['result']['songs'];
		
		
		foreach($songName as $vale){
			
			$da['name'] = $vale['name'];
			$da['songName'] = $vale['ar'][0]['name'];
			$da['id'] = $vale['id'];
			$b = $api->mp3url($vale['id']);
			$bb = json_decode($b,true);
			$da['url'] = $bb['data'][0]['url'];
			$data[] =$da; 
		}	
	
		
		
		}else{
	}
		
		$this->assign('data',$data);
		return $this->fetch();
	}
	
	public function sou1()
	{
		$me = $_GET['name'];
		$api = new Music();
		$result = $api->search($me,10);
		$result = json_decode($result,true);
		$songName = $result['result']['songs'];
		
		foreach($songName as $vale){
			
			$da['name'] = $vale['name'];
			$da['songName'] = $vale['ar'][0]['name'];
			$da['id'] = $vale['id'];
			$b = $api->mp3url($vale['id']);
			$bb = json_decode($b,true);
			$da['url'] = $bb['data'][0]['url'];
			$data[] =$da; 
		}
		$uid = Session::get('uid');
		//dump($uid);die;
		$tou = Db::name('user')->where("uid='$uid'")->select();
		//dump($tou);die;
		$this->assign('tou',$tou);	
		$this->assign('data',$data);
		return $this->fetch();
	}
	
	
	public function find()
	{
		$res = Db::table('music_hotsiner')->field('author,tu')->select();
		$uid = Session::get('uid');
		$re = Db::table('music_user')->where('uid',$uid)->select();
		//dump($re);
		$this->assign('re',$re);
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	public function love()
	{
		
		if(Session::has('uid')){
		$uid = Session::get('uid');
		$re1 = Db::table('music_shou')->where('uid',$uid)->select();
		if(!empty($re1)){
		foreach($re1 as $va){
			$api = new Music();
			//dump($va['songId']);
			$url = $api->mp3url($va['songId']);
			$bb = json_decode($url,true);
			$da['url'] = $bb['data'][0]['url'];
			$bb = $api->detail($va['songId']);
			$bb = json_decode($bb,true);
			$da['pi'] = $bb['songs'][0]['al']['picUrl'];
			$da['name'] = $bb['songs'][0]['name'];
			$da['songName'] = $bb['songs'][0]['ar'][0]['name'];
			$da['id'] = $va['songId'];
			$data[] =$da; 	
		}
		
		//dump($data);
		$this->assign('data',$data);
		
		}
		$this->assign('re1',$re1);
		$re = Db::table('music_user')->where('uid',$uid)->select();
		$e = Db::table('music_gedan')->select();
		
		$this->assign('re',$re);
		$this->assign('e',$e);
		}
		
		$gedan = Db::table('music_gedan')->select();
		//dump($gedan);
		//dump($re1);
		$this->assign('gedan',$gedan);
		return $this->fetch();
	}

	public function ged()
	{
		
		$aid = $_GET['aid'];
		dump($aid);
		$uid = Session::get('uid');
		$re = Db::table('music_shou')->where('uid',$uid)->where('aid',$aid)->select();
		//dump($re);
		if(!empty($re)){
		foreach($re as $va){
			$api = new Music();
			//dump($va['songId']);
			$url = $api->mp3url($va['songId']);
			$bb = json_decode($url,true);
			$da['url'] = $bb['data'][0]['url'];
			$bb = $api->detail($va['songId']);
			$bb = json_decode($bb,true);
			//$da['pi'] = $bb['songs'][0]['al']['picUrl'];
			$da['name'] = $bb['songs'][0]['name'];
			$da['songName'] = $bb['songs'][0]['ar'][0]['name'];
			$da['id'] = $va['songId'];
			$data[] =$da; 	
			
		}
			$this->assign('data',$data);
		}else{
			$this->error('本歌单无歌曲',$_SERVER['HTTP_REFERER']);
		}
		dump($data);
	
		return $this->fetch();
	}

	
	public function bolg()
	{
		$re = Db::table('music_bolg')->select();
		$this->assign('re',$re);
		return $this->fetch();
	}
	public function shop()
	{
		return $this->fetch();
	}
	public function shop_1()
	{
		
		return $this->fetch();
	}
	
	public function play()
	{
		$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;

		
		$id = $_GET['id'];
		
		$api = new Music();
		$url = $api->mp3url($id);
		$re = $api->detail($id);
		
		
		$lyric = $api->lyric($id);
		$lyric = json_decode($lyric,true);
		if(!empty($lyric['lrc']['lyric'])){
			$data['lrc'] = $lyric['lrc']['lyric'];
		}else{
			$data['lrc'] = '[00:00.00]本歌曲为纯音乐，暂无歌词';
		}
		
		$re = json_decode($re,true);
		$name = $re['songs'][0]['name'];
		$songName = $re['songs'][0]['ar'][0]['name'];
		$url = json_decode($url,true);
		$url1 = $url['data'][0]['url'];
		$data['pi'] = $re['songs'][0]['al']['picUrl'];
		$data['url'] = $url1;
		$data['name'] = $name;
		$data['songname'] = $songName;
		$this->assign('data',$data);
		$this->assign('id',$id);
		if(Session::has('uid')){
			
			 $uid = Session::get('uid');
			 
			$res =  Db::table('music_shou')->where('uid',$uid)->select();
			if(empty($res)){
				$log = 0;
				//echo $log;
				$this->assign('log',$log);
			}else{
			foreach ($res as $v){
				//dump($v);
				$b[] = $v['songId'];
				
			}
			if(in_array($id,$b)){
				$log = 1;
				//echo $log;
				$this->assign('log',$log);
			}else{
				$log = 0;
				//echo $log;
				$this->assign('log',$log);
			}
			
					
		 }
		 $tou = Db::name('user')->where("uid='$uid'")->select();
		 $this->assign('tou',$tou);
		//dump($tou);die;
			}
			
		$ping = Db::name('pinlun')->order('istop','desc')->where('songId',$id)->select();
		$ping1 = Db::table('music_pinlun')->where('songId',$id)->select();
		
		//dump($ping);		
		$user = Db::table('music_user')->select();
		//dump($user);
		//$list = Db::table('music_pinlun')->where('songid',$id)->paginate(2);
		
		$data1 = Db::name('category_right_song')->select();
		$result1 = Db::name('category_right')->select();
		$count = count($ping1);
		
		$num = 2;
		$total = ceil($count / $num);
		if($page <= 1){
			$page = 1;
		}
		if($page >= $total){
			$page = $total;
		}
		$offest = ($page - 1)*$num;
		$this->assign('count',$count);

		$this->assign('id',$id);
		$this->assign('num',$num);
		$this->assign('page',$page);


		
		$this->assign('id',$id);
		$this->assign('ping',$ping);
		$this->assign('ping1',$ping1);
		$this->assign('user',$user);

		$this->assign('result1',$result1);
		$this->assign('data1',$data1);
		
		
		return $this->fetch();
	}
	
	public function A()
	{
	
		
		$res = Db::table('music_geshou')->limit(0,47)->select();
		$res1 = Db::table('music_geshou')->select();
		//$pin = Db::table('music_pin')->select();
		foreach ($res1 as $value){
			$author[] = $value['author'];
		}
		$ctp=new Pin();
		$re=array();
		foreach ($author as $key => $value) {
		$first=mb_substr($value, 0,1,'utf-8');//取出第一个汉字,如果是英文则取第一个字母
		$py=mb_substr($ctp->Pinyin($first), 0,1,'utf-8');
		$re[$py][]=$value;
		}
		ksort($re);
		
		//dump($re);
		
		
	$this->assign('res',$res);
		
	return $this->fetch();
	}
	
	
	public function B()
	{
		$res = Db::table('music_geshou')->limit(47,41)->select();
		
		
		$this->assign('res',$res);
		
		return $this->fetch();
	}
	
	
	public function C()
	{
		$res = Db::table('music_geshou')->limit(88,42)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function D()
	{
		$res = Db::table('music_geshou')->limit(130,29)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function E()
	{
		$res = Db::table('music_geshou')->limit(159,19)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function F()
	{
		$res = Db::table('music_geshou')->limit(178,21)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function G()
	{
		$res = Db::table('music_geshou')->limit(199,25)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function H()
	{
	$res = Db::table('music_geshou')->limit(224,24)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function I()
	{
		$res = Db::table('music_geshou')->limit(248,9)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function J()
	{
		$res = Db::table('music_geshou')->limit(257,24)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function K()
	{
		$res = Db::table('music_geshou')->limit(281,22)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function L()
	{
		$res = Db::table('music_geshou')->limit(303,27)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function M()
	{
		$res = Db::table('music_geshou')->limit(330,23)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function N()
	{
		$res = Db::table('music_geshou')->limit(353,18)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function O()
	{
		$res = Db::table('music_geshou')->limit(371,17)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function P()
	{
		$res = Db::table('music_geshou')->limit(388,20)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function Q()
	{
		$res = Db::table('music_geshou')->limit(408,18)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function R()
	{
		$res = Db::table('music_geshou')->limit(426,18)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function S()
	{
		$res = Db::table('music_geshou')->limit(444,22)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function T()
	{
		
		$res = Db::table('music_geshou')->limit(466,16)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function U()
	{
		$res = Db::table('music_geshou')->limit(482,7)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function V()
	{
		$res = Db::table('music_geshou')->limit(489,13)->select();
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function W()
	{
		$res = Db::table('music_geshou')->limit(502,22)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function X()
	{
		$res = Db::table('music_geshou')->limit(524,20)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function Y()
	{
		$res = Db::table('music_geshou')->limit(544,22)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	
	public function Z()
	{
		$res = Db::table('music_geshou')->limit(566,601)->select();
		
		$this->assign('res',$res);
		return $this->fetch();
	}
	
	public function collection()
	{
		dump(Session::has('username'));
	}
	
	public function ajaxs()
	{
		//dump($_GET);
		$data['songId'] = $_GET['id'];
		$data['uid'] = $_GET['uid'];
		if(empty($data['uid'])){
			die('请先登录');
		}
		
		
		$res = Db::table('music_shou')->where('songId',$data['songId'])->select();
		//dump($data);
		 if ($res) {
			 if(in_array($data['uid'],$res[0])){
				 echo   json_encode(['state'=>1],true);
				
				 die;
			 }else{
				 echo json_encode(['state'=>0],true);
				
				Db::table('music_shou')->insert($data);
			 }
			
			
			
		} else {
			echo json_encode(['state'=>0],true);
			Db::table('music_shou')->insert($data);
		}	
	
	}
	
	public function dele()
	{
		
		$data['songId'] = $_GET['id'];
		$data['uid'] = $_GET['uid'];
		if(empty($data['uid'])){
			die('请先登录');
		}
		
		
		$res = Db::table('music_shou')->where('songId',$data['songId'])->select();
		 if ($res) {
			echo   json_encode(['state'=>1],true);
			Db::table('music_shou')->where('songId',$data['songId'])->delete();
			die;
		} else {
			echo json_encode(['state'=>0],true);
			die;
		}	
	
	}
	public function send()
	{
	
		return $this->fetch();
	}
	public function send1()
	{
		$uid = Session::get('uid');
		//$d = input('post.');
		//dump($d);die;
		$data['content'] = $_POST['content'];
		$data['title'] = $_POST['title'];
		$data['author'] = $_POST['author'];
		$data['tags'] = $_POST['select'];
		$data['uid'] = $uid;
		Db::table('music_bolg')->insert($data);
		$this->success('发表成功','index/index/bolg');
	}
	
	public function look()
	{
		$oid = $_GET['id'];
		$re = Db::table('music_bolg')->where('oid',$oid)->select();
		$this->assign('re',$re);
		return $this->fetch();
	}
	
	//歌单添加
	public function move()
	{
		//dump($_GET);
		$id = $_GET['id'];
		$uid = $_GET['uid'];
		$aid = $_GET['class'];
		Db::table('music_shou')->where('id',$id)->update(['aid' => $aid]);
		 echo json_encode(['state'=>1],true);
		
	}
	
	
	public function dell()
	{
		
		$aid = $_GET['aid'];
		$re = Db::table('music_gedan')->where('aid',$aid)->select();
		if($re){
			Db::table('music_gedan')->where('aid',$aid)->delete();
			Db::table('music_shou')->where('aid',$aid)->delete();
			echo json_encode(['state'=>1],true);
		}
	}

	public function addd()
	{
		dump($_GET);
		$name = $_GET['name'];
		$uid = $_GET['uid'];
		$data['uid'] = $uid;
		$data['class'] = $name;
		Db::table('music_gedan')->insert($data);
		 echo json_encode(['state'=>1],true);
	}

	public function ding()
	{
		if(Session::has('uid')){
		$uid = Session::get('uid');
		$color = $_GET['color'];
		$re = Db::table('music_shop')->where('shop_name',$color)->select();
		//dump($re);
		$xiang = Db::table('music_xiang')->where('uid',$uid)->select();
		if($xiang){
			$this->error('对不起您已经购买过，本商品每位用户限购一次',$_SERVER['HTTP_REFERER']);
		}
		
		$ding = Db::table('music_ding')->where('uid',$uid)->select(); 
		$this->assign('re',$re);
		
		
		$this->assign('ding',$ding);
		return $this->fetch();	
		}else{
			$this->error('对不起你还没登录','index/user/login');
		}
		
	}
	
	public function ok()
	{
		//dump($_POST);
		$uid = Session::get('uid');
		$check = $_POST['Checkout'];
		$t = date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
		
		if($check['pay_id'] == 'jpy'){
			$s = Db::table('music_user')->where('uid',$uid)->select();
			if($s[0]['counts'] < 10000000000000){
				$this->error('对不起积分不够',$_SERVER['HTTP_REFERER']);
			}
		}else{
		
		$data = $_POST['newAddress'];
		$data['uid'] = $uid;
		$data['ddan'] = $t;
	
		if(!empty($data['consignee'])){
		$data1 = array_splice($data, 1); 
		Db::table('music_ding')->insert($data1);
		}else{
			
		}
		$d = Db::table('music_ding')->where('uid',$uid)->limit(0,1)->order('sid DESC')->select();
		
		
		$check['liuyan'] = $_POST['liuyan'];
		$check['hid'] = $_POST['hid'];
		$check['uid'] = $uid;
		$check['ddan'] = $t;
		$check['dizhi'] = $d[0]['sid'];
		
		Db::table('music_xiang')->insert($check);
		$this->success('订单创建成功,正在跳往支付页面...','index/index/ding1');
		}
	}
	public function ding1()
	{
		$uid = Session::get('uid');
		
		$re = Db::table('music_xiang')->where('uid',$uid)->limit(0,1)->order('xid DESC')->select();
		
		$user = Db::table('music_ding')->where('sid',$re[0]['dizhi'])->select();
		//dump($user);
		$this->assign('re',$re);
		$this->assign('user',$user);
		return $this->fetch();
		
	}
	public function cg()
	{
		$uid = Session::get('uid');
		
		$re = Db::table('music_xiang')->where('uid',$uid)->limit(0,1)->order('xid DESC')->select();
		
		$user = Db::table('music_ding')->where('sid',$re[0]['dizhi'])->select();
		//dump($user);
		$this->assign('re',$re);
		$this->assign('user',$user);
		return $this->fetch();
	}
	public function dingdan()
	{
		$uid = Session::get('uid');
		
		$re = Db::table('music_xiang')->where('uid',$uid)->limit(0,1)->order('xid DESC')->select();
		
		$user = Db::table('music_ding')->where('sid',$re[0]['dizhi'])->select();
		$shop = Db::table('music_shop')->where('hid',$re[0]['hid'])->select();
		
		
		
		$this->assign('re',$re);
		$this->assign('shop',$shop);
		$this->assign('user',$user);
		return $this->fetch();
	}
	
	public function dingdan1()
	{
		$uid = Session::get('uid');
		if(empty($uid)){
		$this->error('对不起你还没登录','index/user/login');
		}
		$re = Db::table('music_xiang')->where('uid',$uid)->limit(0,1)->order('xid DESC')->select();
		
		if(!empty($re)){
		$user = Db::table('music_ding')->where('sid',$re[0]['dizhi'])->select();
		$shop = Db::table('music_shop')->where('hid',$re[0]['hid'])->select();
		
		$this->assign('shop',$shop);
		$this->assign('user',$user);
		}
		$this->assign('re',$re);
		return $this->fetch();
	}

	
	/*退出登陆*/
	public function outlogin()
	{
		session(null);
		$this->success('成功退出，请稍后……','Index/index');
	}
	
}