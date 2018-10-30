<?php

namespace app\index\controller;


use think\Url;
use think\Controller;
use app\index\model\User as UserModel;
use app\index\validate\User as UserValidate;
use think\Request;
use think\Db;
use think\Session;
use music\MusicSrc\Level;
use yun\Mass\Ucpaas;
use think\Cookie;
use weibo\Wei\SaeTClientV2;
use weibo\Wei\SaeTOAuthV2;
use em\sendMail;

class User extends Controller
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
		//$this->assign('wei_name',$wei_name);
		//$this->assign('wei_picture',$wei_picture);
		
		//$this->assign('result3',$result3);

		return $this->fetch();
	}

	public function weibo()
	{
		//微博登陆
		$o = new SaeTClientV2( WB_AKEY , WB_SKEY ,session('token')['access_token']);
		$ms = $o->home_timeline();
		$uid_get = $o->get_uid();
		$uid = $uid_get['uid'];
		$user_message = $o->show_user_by_id($uid);//根据用户ID获取基本信息
		//dump($user_message);die;
		$wei_name = $user_message['name'];
		//dump($wei_name);
		$wei_picture = $user_message['profile_image_url'];
		//dump($wei_picture);
		//$wei = Db::name('user')->insert(['username' => $wei_name, 'picture' => $wei_picture]);
		//$wb = Db::name('user')->select();
		session('wei_name',$wei_name);
		session('wei_picture',$wei_picture);
		if ($user_message) {
			$this->success('微博登陆成功','index/index/index');
		}
	}
	
	public function login()
	{


		//获取ip
		$request = Request::instance();
		$ip = $request->ip();

		$o = new SaeTOAuthV2( WB_AKEY , WB_SKEY );
		$code_url = $o->getAuthorizeURL( WB_CALLBACK_URL );
		$this->assign('code_url',$code_url);

		$sip = Db::name('user')->field('ip')->where("ip='$ip'")->select();
		//dump($sip);die;
		if ($sip) {
				$yip = $sip[0]['ip'];
			//dump($yip);die;
			//获取被禁止的ip
			$aip = Db::name('user')->field('ip')->where('lock',1)->find();
			//dump($result3);die;
			$xip = $aip['ip'];
			//dump($lock1);die;
			//判断所登陆的ip是否为被禁止的ip
			if($yip == $xip) {
				$this->error('检测到你有违规行为被禁止登陆注册了！');
			} else {
				//微博登陆
				//$o = new SaeTOAuthV2( WB_AKEY , WB_SKEY );
				//$code_url = $o->getAuthorizeURL( WB_CALLBACK_URL );
				$this->assign('code_url',$code_url);
				return $this->fetch();
			}
		} else {
			
			return $this->fetch();
			
		}
		
		
	}

	public function weibolist()
	{
		$o = new SaeTClientV2( WB_AKEY , WB_SKEY ,session('token')['access_token']);
		$ms = $o->home_timeline();
		$uid_get = $o->get_uid();
		$uid = $uid_get['uid'];
		$user_message = $o->show_user_by_id($uid);//根据用户ID获取基本信息
		$this->assign([
				'ms'=>$ms,
				'user_message'=>$user_message
			]);
		return $this->fetch();
	}

	public function callback()
	{
		$o = new SaeTOAuthV2(WB_AKEY , WB_SKEY);
		$keys = array();
		$param = Request::instance()->param();
		$keys['code'] = $param['code'];
		$keys['redirect_uri'] = WB_CALLBACK_URL;
		$token = $o->getAccessToken( 'code', $keys );
		if($token) {
			session('token',$token);
			$js = <<<ABC
			<script type="text/javascript">
				alert('授权成功');
			</script>
ABC;
			echo $js;
			return $this->fetch();
		} else {
			return $this->error('授权失败','/index/user/login','','2');
		}
	}

	public function reg()
	{
		return $this->fetch();
	}
	public function duanxin()
	{
		return $this->fetch();
	}
	public function qq()
	{
		return $this->fetch();
	}
	public function wet()
	{
		return $this->fetch();
	}

	/*ajax判断*/
	public function ajax()
	{
		$name = input('post.username');
		//dump($name);die;
		
		$data = db('user')->where('username',$name)->select();
		if ($data) {
			//如果查询结果data不为空，表示此用户在数据库中已存在，返回值为1
			echo json_encode(['state'=>1]);
		} else {
			echo json_encode(['state'=>0]);
		}
	}

	/*短信验证开始*/
	public function sent_code()
	{
		$code = input('post.code');
		//dump($code);die;
		//$to = input('get.tel');
		//dump($to);die;
		//初始化必填
		$options['accountsid']='92dadd8549b5c4c86a408743677ce921';
		$options['token']='16236d3170e908c5079514f9b8648484';


		//初始化 $options必填
		$ucpass = new Ucpaas($options);

		//开发者账号信息查询默认为json或xml
		header("Content-Type:text/html;charset=utf-8");

		//短信验证码（模板短信）,默认以65个汉字（同65个英文）为一条（可容纳字数受您应用名称占用字符影响），超过长度短信平台将会自动分割为多条发送。分割后的多条短信将按照具体占用条数计费。
		//$code = input('post.code');
	
		//dump($code);
		$appId = "3ac0edcb3a18404482bbafdce869c32a";
		//$to = "18370841149";
		$to = input('get.tel');
		//dump($to);die;
		$templateId = "229682";
		$param = mt_rand(1000,9999);
		//存入COOKIE
		Cookie::set('name',$param,180);
		
		//$ucpass->templateSMS($appId,$to,$templateId,$param);
		echo '验证码已发送';
		$res = $ucpass->templateSMS($appId,$to,$templateId,$param);
		//Cookie::set('name',$res,180);
		//dump($res);die;
		//$arr = json_decode($res,true);
		//dump($arr);die;
		//Cookie::set('codes','$arr',180);
		//dump($param);die;
		//$code = input('post.code');
		//dump($code);die;
		if ($param) {
			echo json_encode(['state'=>1]);
			
		} else {
			echo json_encode(['state'=>0]);
			$this->error('验证失败!请重新获取验证码','index/user/reg');
		}

		//echo ($arr['resp']['respCode']);
		//echo '验证码已发送';
	}

	
	/*短信验证结束*/

	/*注册*/
	
    
	public function add()
	{
		include'../extend/em/sendMail.php';

		$data = input('post.');
		//dump($data);die;
		$name = $data['username'];
		$email = $data['email'];
		$request = Request::instance();
		$ip = $request->ip();
		//dump($ip);die;
		//$tel = $data['tel'];
		//$istel = Db::name('user')->field('tel')->select();
		$val = new UserValidate();
		//dump($val);die;
		if (!$val->check($data)) {
			$this->error($val->getError());
			exit;
		}
		$user = new UserModel($data);
		$ret = $user->allowField(true)->save();
		//dump($ret);die;
		
		//邮箱验证
		$re = Db::table('music_user')->order('uid DESC')->limit(0,1)->select();
		$uid = $re[0]['uid'];
		
        $title = "静听音乐";
        $content = <<<DOC
		<h1>静听网  进入网站记得听推荐歌曲</h1>
		<p>亲爱的 <font color="red">$name</font> 欢迎注册静听网，凯哥带你飞</p>
		<a href="http://www.ykxkun.cn/index/user/you?uid=$uid">点击验证激活邮箱www.ykxkun.cn</a>	
DOC;
		
		//dump($content);
        sendMail($email,$title,$content);
		//邮箱结束

		
		
		//$result3 = Db::name('user')->field('lock')->where("username='$name'")->find();
		//dump($result3);die;
		//$status = Db::name('user')->field('status')->where("username='$name'")->find();
		//$status = $status['status'];
		//dump($status);die;
		$code = input('post.code');
		//dump($code);die;
		$param = Cookie::get('name');
		//dump(Cookie::get('name'));die;
		
		if (!empty($param)) {
			if($code == $param){
				$result = Db::name('user')->field('ip')->where("username='$name'")->update(['ip' => $ip]);
				$this->success('恭喜你注册成功！获得积分100!请先激活邮箱','index/user/login');
			} else {
				$this->error('注册失败');
			}
		} else {
			$this->error('先去验证手机吧亲！！');
		}
	}

	//邮箱验证
	public function you()
	{
		
		$uid = $_GET['uid'];
		Db::table('music_user')->where('uid',$uid)->update(['status' => 1]);
		$this->success('邮箱验证成功立即登录吧','/index/user/login');
	}


	/*登陆*/
	public function check()
	{
		$data = input('post.');
		//dump($data);die;
		$username = $data['username'];
		$pwd = $data['pwd'];
		$code = $data['code'];

		
		$result = Db::table('music_user')->where("username = '$username'")->select();
		//dump($result);die;
		if ($result) {

			$name1 = $result[0]['username'];
			$pwd1 = $result[0]['pwd'];
			$status = $result[0]['status'];

			$uid1 = $result[0]['uid'];
			//dump($uid1);die;
			$undertype1 = $result[0]['undertype'];
			$count = $result[0]['counts'];
			$picture = $result[0]['picture'];
			//dump($undertype1);die;

			//判断是否为禁止Ip
			$request = Request::instance();
			$ip = $request->ip();
			//dump($ip);die;
			$result3 = Db::name('user')->field('lock')->where("username='$username'")->find();
			//dump($result3);die;
			if($result3['lock'] == 0) {
				if (captcha_check($code)) {
					if($pwd == $pwd1) {
						if($status == 1) {
							session('username',$username);
							session('undertype',$undertype1);
							session('uid',$uid1);
							session('picture',$picture);
							$this->success('恭喜登录成功','Index/index');
						} else {
							$this->error('您未激活邮箱，请先激活邮箱');
						}
					} else {
						$this->error('密码不正确');
						}
					} else {
						$this->error('验证码错误');
					}
			} else {
				$this->error('你被禁止登陆了！','index/index/index');
				exit;
			}

		} else {
			$this->error('用户名不存在');
		}

	}

	

	//找回密码
	public function finded()
	{
		return $this->fetch();
	}
	public function find()
	{
		//return '你是猪吗';die;
		$data = input('post.email');
		//dump($data);die;
		sendMail(array($data),'找回密码','真的好');
	}

	/*public function sendmail()
	{
		$request = Request::instance();
		$to = $request->param()['email'];
		$token = md5(1234);
		$mail = new sendEmail();
		$mail->setServer("smtp.mxhichina.com", "yk@ykxkun.cn", "Yankai2519775"); //设置smtp服务器
		$mail->setFrom("yk@ykxkun.cn"); //设置发件人
		$mail->setReceiver("$to"); //设置收件人，多个收件人，调用多次
		//$mail->setCc("XXXX"); //设置抄送，多个抄送，调用多次
		//$mail->setBcc("XXXXX"); //设置秘密抄送，多个秘密抄送，调用多次
		$mail->setMailInfo("激活链接", "<a href='{:url('index/user/find')}?tid=$token'>点击此链接继续完成激活</a>"); //设置邮件主题、内容
		$result = $mail->sendMail(); //发送
		//var_dump($result);
		if ($result) {
			return json_decode(1);
		} else {
			return json_decode(2);
		}
	}*/

	public function xiug()
 {
	 $n = new Level();
	$uid = Session::get('uid');
	$re = Db::table('music_user')->where('uid',$uid)->select();
	//dump($re);
	
	$this->assign('re',$re);
	
	return $this->fetch();
 }
 
 public function tou()
 { 
	$uid = Session::get('uid');
	$file = request()->file('file');
	$info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
	 
	if($info){
		$imge =  $info->getSaveName();
		$imge = "\uploads\\".$imge;
		if($imge){
		    Db::table('music_user')->where('uid',$uid)->update(['picture' => $imge]);
			$this->success('头像修改成功','index/user/xiug');
		}
		 }else{
		  echo $file->getError();  
	}
 }
 
 public function pass()
 {
	 //dump($_POST);
	 $uid = Session::get('uid');
	 $npass = $_POST['qpass'];
	 Db::table('music_user')->where('uid',$uid)->update(['pwd' => $npass]);
	 
	 $this->success('密码修改成功，正在退出','index/user/outlogin');
	 
 }

 
 public function aja()
 {
	 $pass = $_GET['pass'];
	 $uid = Session::get('uid');
	 $re = Db::table('music_user')->where('uid',$uid)->select();
	// dump($re);
	 if($re){
		 if($re[0]['pwd'] == $pass){
			 echo json_encode(['state' => 1],true);
			 
		 }else{
			  echo json_encode(['state' => 0],true);
			  
		 }
		 
	 }else{
		  echo json_encode(['state' => 0],true);
		  
	 }
	 
 }
 
 public function tou1()
 {
	 dump($_GET);
 }
 
 public function mi()
 {
 	$uid = Session::get('uid');
	$re = Db::table('music_user')->where('uid',$uid)->select();
	//dump($re);
	$this->assign('re',$re);
	return $this->fetch();
	 
 }
 
 public function zi()
 {
 	$uid = Session::get('uid');
	$re = Db::table('music_user')->where('uid',$uid)->select();
	//dump($re);
	$this->assign('re',$re);
	return $this->fetch();
 }
 
 public function xiugai()
 {
	 //dump($_POST);
	 $uid = Session::get('uid');
	 $data['tel'] = $_POST['dian'];
	 $data['star'] = $_POST['xing'];
	 $data['di'] = $_POST['ju'];
	 $data['words'] = $_POST['ge'];
	 Db::table('music_user')->where('uid',$uid)->update($data);
	 $this->success('修改成功','/index/user/zi');
	 
 }
 
 public function ping()
 {
	 //dump($_POST);
	 //dump($_GET);
	 $uid = Session::get("uid");
	 $re = Db::table('music_user')->where('uid',$uid)->select();
	 //dump($re);
	 
	 $content = $_POST['text'];
	 $songId = $_GET['id'];
	 $data['name'] = $re[0]['username'];
	$data['content'] = $content;
	$data['songId'] = $songId;
	$data['uid'] = $uid;
	$data['replayId'] = 0;
	$data['aid'] = 0;
	$data['singer'] = $_GET['songName'];
	$data['songName'] = $_GET['name'];
	
	Db::table('music_pinlun')->insert($data);
	$this->success('评论成功',"/index/index/play?id=$songId");
	}
	
	
	public function hui()
	{		
		$uid = Session::get('uid');
		$re = Db::table('music_user')->where('uid',$uid)->select();
		$data['name'] = $re[0]['username'];
		$data['uid'] = $uid;
		$data['content'] = $_POST['text'];
		$data['aid'] = $_POST['pid'];
		$data['songId'] = $_POST['songId'];
		$data['singer'] = $_POST['name'];
		$data['songName'] = $_POST['songName'];
		$data['replayId'] = 1;
		Db::table('music_pinlun')->insert($data);
		echo"<script>history.go(-1);</script>";  
    
	}


	/*退出登陆*/
	public function outlogin()
	{
		
		session(null);
		$this->success('成功退出，请稍后……','Index/index');
	}
}