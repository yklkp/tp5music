-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2018-04-15 10:58:45
-- 服务器版本： 10.0.30-MariaDB
-- PHP Version: 7.0.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tp5`
--

-- --------------------------------------------------------

--
-- 表的结构 `music_admin`
--

CREATE TABLE `music_admin` (
  `xid` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1为超级管理员，2为普通管理员',
  `role` varchar(32) NOT NULL,
  `cate` varchar(60) NOT NULL COMMENT '负责的板块',
  `admin_name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `miao` varchar(60) NOT NULL COMMENT '权限描述'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_admin`
--

INSERT INTO `music_admin` (`xid`, `user_id`, `type`, `role`, `cate`, `admin_name`, `password`, `miao`) VALUES
(1, 9, 1, '超级管理员', '全部', '严凯', '123456', '至高无上'),
(2, 8, 3, '普通管理员', '板块的管理和用户的管理', '大帅', '123456', '管理百姓和住房'),
(3, 10, 2, '普通管理员', '歌曲的管理和商品的管理', '肖坤', '123456', '我是管理百姓的生活方面的');

-- --------------------------------------------------------

--
-- 表的结构 `music_bolg`
--

CREATE TABLE `music_bolg` (
  `oid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` varchar(5000) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tags` varchar(32) DEFAULT NULL,
  `del` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_bolg`
--

INSERT INTO `music_bolg` (`oid`, `uid`, `content`, `author`, `title`, `addtime`, `tags`, `del`) VALUES
(1, 13, '1.定义常量define(\"CONSTANT\", \"Hello world.\");\r\n\r\n常量只能包含标量数据（boolean，integer，float 和 string）。\r\n调用常量时，只需要简单的用名称取得常量的值，而不能加“$”符号，如：echo CONSTANT；\r\n注: 常量和（全局）变量在不同的名字空间中。这意味着例如 TRUE 和 $TRUE 是不同的。\r\n2.普通变量$a = \"hello\";\r\n3.可变变量（使用两个美元符号（$））\r\n$$a = \"world\";\r\n两个变量都被定义了：\r\n$a 的内容是“hello”并且 $hello 的内容是“world”。\r\n因此，可以表述为：\r\necho \"$a ${$a}\";或者 echo \"$a $hello\";它们都会输出：hello world\r\n要将可变变量用于数组，必须解决一个模棱两可的问题。这就是当写下 $$a[1] 时，解析器需要知道是想要 $a[1] 作为一个变量呢，还是想要 $$a 作为一个变量并取出该变量中索引为 [1] 的值。解决此问题的语法是，对第一种情况用 ${$a[1]}，对第二种情况用 ${$a}[1]。\r\n4.静态变量\r\n在函数内部static $a = 0;\r\n注意：声明中用表达式的结果对其赋值会导致解析错误如static $a =3+3;（error）\r\n静态变量仅在局部函数域中存在（函数内部），函数执行完之后，变量值不会丢失,可用于递归调用\r\n5.全局变量\r\n在函数体内定义的global变量,函数体外可以使用,在函数体外定义的global变量不能在函数体内使用，在全局范围内访问变量可以用特殊的 PHP 自定义 $GLOBALS 数组：\r\n如：$GLOBALS[\"b\"] = $GLOBALS[\"a\"] + $GLOBALS[\"b\"];\r\n在一个函数域内用 global 语句导入的一个真正的全局变量实际上是建立了一个到全局变量的引用\r\nglobal $obj;\r\n注：对于变量的 static 和 global 定义是以 应用 的方式实现的\r\n6.给变量赋值：传地址赋值（简单引用）：\r\n$bar = &$foo; //加&符号到将要赋值的变量前\r\n改动新的变量将影响到原始变量，这种赋值操作更加快速\r\n注意：只有命名变量才可以传地址赋值\r\n注意：如果\r\n$bar = &$a;\r\n$bar = &$foo;\r\n改变$bar的值只能改变变量foo的值，而不改变a的值（引用改变了）\r\n7.PHP 超全局变量$GLOBALS ： 包含一个引用指向每个当前脚本的全局范围内有效的变量。该数组的键标为全局变量的 名称。从 PHP 3 开始存在 $GLOBALS 数组。\r\n$_SERVER ： 变量由 Web 服务器设定或者直接与当前脚本的执行环境相关联。类似于旧数组 $HTTP_SERVER_VARS 数组（依然有效，但反对使用）。\r\n$_GET ： 经由 HTTP GET 方法提交至脚本的变量。\r\n$_POST ： 经由 HTTP POST 方法提交至脚本的变量。\r\n$_COOKIE ： 经由 HTTP Cookies 方法提交至脚本的变量。\r\n$_FILES ： 经由 HTTP POST 文件上传而提交至脚本的变量。\r\n文件上传表单中要有 enctype=\"multipart/form-data\"\r\n$_ENV ： 执行环境提交至脚本的变量。\r\n$_REQUEST ：经由 GET，POST 和 COOKIE 机制提交至脚本的变量，因此该数组并不值得信任。所有包含在该数组中的变量的存在与否以及变量的顺序均按照 php.ini 中的 variables_order 配置指示来定义。该数组没有直接模拟 PHP 4.1.0 的早期版本。参见 import_request_variables()。\r\n注意： 自 PHP 4.3.0 起，$_FILES 中的文件信息不再存在于 $_REQUEST 中。\r\n$_SESSION ：当前注册给脚本会话的变量。\r\n如何禁用phpinfo():\r\nphp.ini中\r\ndisable_functions = phpinfo()\r\n重启web服务器。\r\nphp中的常量\r\n常量只能用define（常量名,常量值);\r\n常量只能包含标量数据（boolean，integer，float 和 string）。\r\n可以简单的通过指定其名字来取得常量的值，不要在常量前面加上 $ 符号。如果常量名是动态的，也可以用函数\r\nconstant() 来读取常量的值。用 get_defined_constants() 可以获得所有已定义的常量列表。\r\n注: 常量和（全局）变量在不同的名字空间中。这意味着例如 TRUE 和 $TRUE 是不同的。\r\n如果使用了一个未定义的常量，PHP 假定想要的是该常量本身的名字，如同用字符串调用它一样（CONSTANT 对应 \"CONSTANT\"）。此时将发出一个 E_NOTICE 级的错误。参见手册中为什么 $w3sky[bar] 是错误的（除非事先用 define() 将 bar 定义为一个常量）。如果只想检查是否定义了某常量，用 defined() 函数。\r\n常量和变量不同：\r\n* 常量前面没有美元符号（$）；\r\n* 常量只能用 define() 函数定义，而不能通过赋值语句；\r\n* 常量可以不用理会变量范围的规则而在任何地方定义和访问；\r\n* 常量一旦定义就不能被重新定义或者取消定义；\r\n* 常量的值只能是标量。\r\n定义常量\r\n<?PHP\r\ndefine(\"CONSTANT\", \"Hello world.\");\r\necho CONSTANT; // outputs \"Hello world.\"\r\necho Constant; // outputs \"Constant\" and issues a notice.\r\n?>', '坤哥', 'PHP之变量定义的方法总结——初学', '2017-11-10 07:08:54', 'php', 0),
(2, 13, '作为程序员你总要知道一些小技巧，才能写出更完美的程序，下面给大家分享一些小技巧。\r\n\r\n1、用单引号代替双引号来包含字符串，这样做会更快一些。因为PHP会在双引号包围的字符串中搜寻变量， 单引号则不会，注意：只有echo能这么做，它是一种可以把多个字符串当作参数的”函数”(译注：PHP手册中说echo是语言结构，不是真正的函数，故 把函数加上了双引号)。\r\n\r\n2、如果能将类的方法定义成static，就尽量定义成static，它的速度会提升将近4倍。\r\n\r\n3、$row[‘id’] 的速度是$row[id]的7倍。\r\n\r\n4、echo 比 print 快，并且使用echo的多重参数(译注：指用逗号而不是句点)代替字符串连接，比如echo $str1,$str2。\r\n\r\n5、在执行for循环之前确定最大循环数，不要每循环一次都计算最大值，最好运用foreach代替。\r\n\r\n6、注销那些不用的变量尤其是大数组，以便释放内存。\r\n\r\n7、尽量避免使用__get，__set，__autoload。\r\n\r\n8、require_once()代价昂贵。\r\n\r\n9、include文件时尽量使用绝对路径，因为它避免了PHP去include_path里查找文件的速度，解析操作系统路径所需的时间会更少。\r\n\r\n10、如果你想知道脚本开始执行(译注：即服务器端收到客户端请求)的时刻，使用\r\n\r\n$_SERVER[‘REQUEST_TIME’]\r\n\r\n要好于\r\n\r\ntime()\r\n\r\n11、函数代替正则表达式完成相同功能。\r\n\r\n12、str_replace函数比preg_replace函数快，但strtr函数的效率是str_replace函数的四倍。\r\n\r\n13、如果一个字符串替换函数，可接受数组或字符作为参数，并且参数长度不太长，那么可以考虑额外写一段替换代码，使得每次传递参数是一个字符，而不是只写一行代码接受数组作为查询和替换的参数。\r\n\r\n14、使用选择分支语句(译注：即switch case)好于使用多个if，else if语句。\r\n\r\n15、用@屏蔽错误消息的做法非常低效，极其低效。\r\n\r\n16、打开apache的mod_deflate模块，可以提高网页的浏览速度。\r\n\r\n17、数据库连接当使用完毕时应关掉，不要用长连接。\r\n\r\n18、错误消息代价昂贵。\r\n\r\n19、在方法中递增局部变量，速度是最快的。几乎与在函数中调用局部变量的速度相当。\r\n\r\n20、递增一个全局变量要比递增一个局部变量慢2倍。\r\n\r\n21、递增一个对象属性(如：$this->prop++)要比递增一个局部变量慢3倍。\r\n\r\n22、递增一个未预定义的局部变量要比递增一个预定义的局部变量慢9至10倍。\r\n\r\n23、仅定义一个局部变量而没在函数中调用它，同样会减慢速度(其程度相当于递增一个局部变量)。PHP大概会检查看是否存在全局变量。\r\n\r\n24、方法调用看来与类中定义的方法的数量无关，因为我(在测试方法之前和之后都)添加了10个方法，但性能上没有变化。\r\n\r\n25、派生类中的方法运行起来要快于在基类中定义的同样的方法。\r\n\r\n26、调用带有一个参数的空函数，其花费的时间相当于执行7至8次的局部变量递增操作。类似的方法调用所花费的时间接近于15次的局部变量递增操作。\r\n\r\n27、Apache解析一个PHP脚本的时间要比解析一个静态HTML页面慢2至10倍。尽量多用静态HTML页面，少用脚本。\r\n\r\n28、除非脚本可以缓存，否则每次调用时都会重新编译一次。引入一套PHP缓存机制通常可以提升25%至100%的性能，以免除编译开销。\r\n\r\n29、尽量做缓存，可使用memcached。memcached是一款高性能的内存对象缓存系统，可用来加速动态Web应用程序，减轻数据库负载。对运算码 (OP code)的缓存很有用，使得脚本不必为每个请求做重新编译。\r\n\r\n30、当操作字符串并需要检验其长度是否满足某种要求时，你想当然地会使用strlen()函数。此函数执行起来相当快，因为它不做任何计算， 只返回在zval 结构(C的内置数据结构，用于存储PHP变量)中存储的已知字符串长度。但是，由于strlen()是函数，多多少少会有些慢，因为函数调用会经过诸多步 骤，如字母小写化(译注：指函数名小写化，PHP不区分函数名大小写)、哈希查找，会跟随被调用的函数一起执行。在某些情况下，你可以使用isset() 技巧加速执行你的代码。\r\n\r\n(举例如下)\r\n\r\nif (strlen($foo) < 5) { echo “Foo is too short”$$ }\r\n\r\n(与下面的技巧做比较)\r\n\r\nif (!isset($foo{5})) { echo “Foo is too short”$$ }\r\n\r\n调用isset()恰巧比strlen()快，因为与后者不同的是，isset()作为一种语言结构，意味着它的执行不需要函数查找和字母小写化。也就是说，实际上在检验字符串长度的顶层代码中你没有花太多开销。\r\n\r\n31、当执行变量$i的递增或递减时，$i++会比++$i慢一些。这种差异是PHP特有的，并不适用于其他语言，所以请不要修改你的C或 Java代码并指望它们能立即变快，没用的。++$i更快是因为它只需要3条指令(opcodes)，$i++则需要4条指令。后置递增实际上会产生一个 临时变量，这个临时变量随后被递增。而前置递增直接在原值上递增。这是最优化处理的一种，正如Zend的PHP优化器所作的那样。牢记这个优化处理不失为 一个好主意，因为并不是所有的指令优化器都会做同样的优化处理，并且存在大量没有装配指令优化器的互联网服务提供商(ISPs)和服务器。\r\n\r\n32、并不是事必面向对象(OOP)，面向对象往往开销很大，每个方法和对象调用都会消耗很多内存。\r\n\r\n33、并非要用类实现所有的数据结构，数组也很有用。\r\n\r\n34、不要把方法细分得过多，仔细想想你真正打算重用的是哪些代码?\r\n\r\n35、当你需要时，你总能把代码分解成方法。\r\n\r\n36、尽量采用大量的PHP内置函数。\r\n\r\n37、如果在代码中存在大量耗时的函数，你可以考虑用C扩展的方式实现它们。\r\n\r\n38、评估检验(profile)你的代码。检验器会告诉你，代码的哪些部分消耗了多少时间。Xdebug调试器包含了检验程序，评估检验总体上可以显示出代码的瓶颈。\r\n\r\n39、mod_zip可作为Apache模块，用来即时压缩你的数据，并可让数据传输量降低80%。\r\n\r\n40、在可以用file_get_contents替代file、fopen、feof、fgets等系列方法的情况下，尽量用 file_get_contents，因为他的效率高得多!但是要注意file_get_contents在打开一个URL文件时候的PHP版本问题；\r\n\r\n41、尽量的少进行文件操作，虽然PHP的文件操作效率也不低的；\r\n\r\n42、优化Select SQL语句，在可能的情况下尽量少的进行Insert、Update操作(在update上，我被恶批过)；\r\n\r\n43、尽可能的使用PHP内部函数(但是我却为了找个PHP里面不存在的函数，浪费了本可以写出一个自定义函数的时间，经验问题啊!)；\r\n\r\n44、循环内部不要声明变量，尤其是大变量：对象(这好像不只是PHP里面要注意的问题吧?)；\r\n\r\n45、多维数组尽量不要循环嵌套赋值；\r\n\r\n46、在可以用PHP内部字符串操作函数的情况下，不要用正则表达式；\r\n\r\n47、foreach效率更高，尽量用foreach代替while和for循环；\r\n\r\n48、用单引号替代双引号引用字符串；\r\n\r\n49、”用i+=1代替i=i+1。符合c/c++的习惯，效率还高”；\r\n\r\n50、对global变量，应该用完就unset()掉。', '大帅', '50个php技巧帮你提高工作效率', '2017-11-10 07:08:54', 'php', 0),
(3, 13, '方法一：\r\n\r\n<?php\r\n\r\nfunction RandAbc($length=\"\"){//返回随机字符串\r\n\r\n$str=\"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\";\r\n\r\nreturn str_shuffle($str);\r\n\r\n}\r\n\r\n$filepath=\'index.php\';\r\n\r\n$path_parts= pathinfo($filepath);\r\n\r\n$filename=$path_parts[\"basename\"];\r\n\r\n$T_k1=RandAbc();//随机密匙1\r\n\r\n$T_k2=RandAbc();//随机密匙2\r\n\r\n$vstr=file_get_contents($filename);//要加密的文件\r\n\r\n$v1=base64_encode($vstr);\r\n\r\n$c=strtr($v1,$T_k1,$T_k2);//根据密匙替换对应字符。\r\n\r\n$c=$T_k1.$T_k2.$c;\r\n\r\n$q1=\"O00O0O\";\r\n\r\n$q2=\"O0O000\";\r\n\r\n$q3=\"O0OO00\";\r\n\r\n$q4=\"OO0O00\";\r\n\r\n$q5=\"OO0000\";\r\n\r\n$q6=\"O00OO0\";\r\n\r\n$s=\'$\'.$q6.\'=urldecode(\"%6E1%7A%62%2F%6D%615%5C%76%740%6928%2D%70%78%75%71%79%2A6%6C%72%6B%64%679%5F%65%68%63%73%77%6F4%2B%6637%6A\");$\'.$q1.\'=$\'.$q6.\'{3}.$\'.$q6.\'{6}.$\'.$q6.\'{33}.$\'.$q6.\'{30};$\'.$q3.\'=$\'.$q6.\'{33}.$\'.$q6.\'{10}.$\'.$q6.\'{24}.$\'.$q6.\'{10}.$\'.$q6.\'{24};$\'.$q4.\'=$\'.$q3.\'{0}.$\'.$q6.\'{18}.$\'.$q6.\'{3}.$\'.$q3.\'{0}.$\'.$q3.\'{1}.$\'.$q6.\'{24};$\'.$q5.\'=$\'.$q6.\'{7}.$\'.$q6.\'{13};$\'.$q1.\'.=$\'.$q6.\'{22}.$\'.$q6.\'{36}.$\'.$q6.\'{29}.$\'.$q6.\'{26}.$\'.$q6.\'{30}.$\'.$q6.\'{32}.$\'.$q6.\'{35}.$\'.$q6.\'{26}.$\'.$q6.\'{30};eval($\'.$q1.\'(\"\'.base64_encode(\'$\'.$q2.\'=\"\'.$c.\'\";eval(\\\'?>\\\'.$\'.$q1.\'($\'.$q3.\'($\'.$q4.\'($\'.$q2.\',$\'.$q5.\'*2),$\'.$q4.\'($\'.$q2.\',$\'.$q5.\',$\'.$q5.\'),$\'.$q4.\'($\'.$q2.\',0,$\'.$q5.\'))));\').\'\"));\';\r\n\r\n$s=\'<?\r\n\r\n\'.$s.\r\n\r\n\'\r\n\r\n?>\';\r\n\r\necho $s;\r\n\r\n//生成 加密后的PHP文件\r\n\r\n!is_dir(\'create/\') && mkdir(\'create/\');\r\n\r\n$fpp1 = fopen(\'create/\'.$filename,\'w\');\r\n\r\nfwrite($fpp1,$s) or die(\'写文件错误\');\r\n\r\necho \'加密成功！\';\r\n\r\n方法二：\r\n\r\n<?php\r\n\r\nfunction encode_file_contents($filename) {\r\n\r\n$type=strtolower(substr(strrchr($filename,\'.\'),1));\r\n\r\nif (\'php\' == $type && is_file($filename) && is_writable($filename)) { // 如果是PHP文件 并且可写 则进行压缩编码\r\n\r\n$contents = file_get_contents($filename); // 判断文件是否已经被编码处理\r\n\r\n$contents = php_strip_whitespace($filename);\r\n\r\n// 去除PHP头部和尾部标识\r\n\r\n$headerPos = strpos($contents,\'<?php\');\r\n\r\n$footerPos = strrpos($contents,\'?>\');\r\n\r\n$contents = substr($contents, $headerPos + 5, $footerPos - $headerPos);\r\n\r\n$encode = base64_encode(gzdeflate($contents)); // 开始编码\r\n\r\n$encode = \'<?php\'.\"\\n eval(gzinflate(base64_decode(\".\"\'\".$encode.\"\'\".\")));\\n\\n?>\";\r\n\r\nreturn file_put_contents($filename, $encode);\r\n\r\n}\r\n\r\nreturn false;\r\n\r\n}\r\n\r\n//调用函数\r\n\r\n$filename = \'dam.php\';\r\n\r\nencode_file_contents($filename);\r\n\r\necho \"OK,加密完成！\"\r\n\r\n?>\r\n\r\n以上就是php之实现源代码加密的方法的详细内容，更多请关注php中文网其它相关文章！', '凯哥', 'php之实现源代码加密的方法', '2017-11-10 07:08:54', 'js', 0),
(5, 12, '1.在可以用file_get_contents替代file、fopen、feof、fgets等系列方法的情况下，尽量用 file_get_contents，因为他的效率高得多!但是要注意file_get_contents在打开一个URL文件时候的PHP版本问题;\r\n\r\n2.尽量的少进行文件操作，虽然PHP的文件操作效率也不低的;\r\n\r\n3.优化Select SQL语句，在可能的情况下尽量少的进行Insert、Update操作(在update上，我被恶批过);\r\n\r\n4.尽可能的使用PHP内部函数(但是我却为了找个PHP里面不存在的函数，浪费了本可以写出一个自定义函数的时间，经验问题啊!);\r\n\r\n5.循环内部不要声明变量，尤其是大变量：对象(这好像不只是PHP里面要注意的问题吧?);\r\n\r\n6.多维数组尽量不要循环嵌套赋值;\r\n\r\n7.在可以用PHP内部字符串操作函数的情况下，不要用正则表达式;\r\n\r\n8.foreach效率更高，尽量用foreach代替while和for循环;\r\n\r\n9.用单引号替代双引号引用字符串;\r\n\r\n10.“用i =1代替i=i 1。符合c/c 的习惯，效率还高”;\r\n\r\n11.对global变量，应该用完就unset()掉\r\n\r\n12.在多重嵌套循环中，如有可能，应当将最长的循环放在内层，最短循环放在外层，这样就可以减少cpu跨切循环层的次数，从而优化程序性能。\r\n\r\n40个优化你的php代码的小提示\r\n\r\n1. 如果一个方法可静态化，就对它做静态声明。速率可提升至4倍。\r\n\r\n2. echo 比 print 快。\r\n\r\n3. 使用echo的多重参数（译注：指用逗号而不是句点）代替字符串连接。\r\n\r\n4. 在执行for循环之前确定最大循环数，不要每循环一次都计算最大值。\r\n\r\n5. 注销那些不用的变量尤其是大数组，以便释放内存。\r\n\r\n6. 尽量避免使用__get，__set，__autoload。\r\n\r\n7. require_once()代价昂贵。\r\n\r\n8. 在包含文件时使用完整路径，解析操作系统路径所需的时间会更少。\r\n\r\n9. 如果你想知道脚本开始执行（译注：即服务器端收到客户端请求）的时刻，使用$_SERVER[‘REQUEST_TIME\']要好于time()。\r\n\r\n10. 检查是否能用strncasecmp，strpbrk，stripos函数代替正则表达式完成相同功能。\r\n\r\n11. str_replace函数比preg_replace函数快，但strtr函数的效率是str_replace函数的四倍。\r\n\r\n12. 如果一个字符串替换函数，可接受数组或字符作为参数，并且参数长度不太长，那么可以考虑额外写一段替换代码，使得每次传递参数是一个字符，而不是只写一行代码接受数组作为查询和替换的参数。\r\n\r\n13. 使用选择分支语句（译注：即switch case）好于使用多个if，else if语句。\r\n\r\n14. 用@屏蔽错误消息的做法非常低效。\r\n\r\n15. 打开apache的mod_deflate模块。\r\n\r\n16. 数据库连接当使用完毕时应关掉。\r\n\r\n17. $row[‘id\']的效率是$row[id]的7倍。\r\n\r\n18. 错误消息代价昂贵。\r\n\r\n19. 尽量不要在for循环中使用函数，比如for ($x=0; $x < count($array); $x)每循环一次都会调用count()函数。\r\n\r\n20. 在方法中递增局部变量，速度是最快的。几乎与在函数中调用局部变量的速度相当。\r\n\r\n21. 递增一个全局变量要比递增一个局部变量慢2倍。\r\n\r\n22. 递增一个对象属性（如：$this->prop++）要比递增一个局部变量慢3倍。\r\n\r\n23. 递增一个未预定义的局部变量要比递增一个预定义的局部变量慢9至10倍。\r\n\r\n24. 仅定义一个局部变量而没在函数中调用它，同样会减慢速度（其程度相当于递增一个局部变量）。PHP大概会检查看是否存在全局变量。\r\n\r\n25. 方法调用看来与类中定义的方法的数量无关，因为我（在测试方法之前和之后都）添加了10个方法，但性能上没有变化。\r\n\r\n26. 派生类中的方法运行起来要快于在基类中定义的同样的方法。\r\n\r\n27. 调用带有一个参数的空函数，其花费的时间相当于执行7至8次的局部变量递增操作。类似的方法调用所花费的时间接近于15次的局部变量递增操作。\r\n\r\n28. 用单引号代替双引号来包含字符串，这样做会更快一些。因为PHP会在双引号包围的字符串中搜寻变量，单引号则不会。当然，只有当你不需要在字符串中包含变量时才可以这么做。\r\n\r\n29. 输出多个字符串时，用逗号代替句点来分隔字符串，速度更快。注意：只有echo能这么做，它是一种可以把多个字符串当作参数的“函数”（译注：PHP手册中说echo是语言结构，不是真正的函数，故把函数加上了双引号）。\r\n\r\n30. Apache解析一个PHP脚本的时间要比解析一个静态HTML页面慢2至10倍。尽量多用静态HTML页面，少用脚本。\r\n\r\n31. 除非脚本可以缓存，否则每次调用时都会重新编译一次。引入一套PHP缓存机制通常可以提升25%至100%的性能，以免除编译开销。\r\n\r\n32. 尽量做缓存，可使用memcached。memcached是一款高性能的内存对象缓存系统，可用来加速动态Web应用程序，减轻数据库负载。对运算码(OP code)的缓存很有用，使得脚本不必为每个请求做重新编译。\r\n\r\n33. 当操作字符串并需要检验其长度是否满足某种要求时，你想当然地会使用strlen()函数。此函数执行起来相当快，因为它不做任何计算，只返回在zval结构（C的内置数据结构，用于存储PHP变量）中存储的已知字符串长度。但是，由于strlen()是函数，多多少少会有些慢，因为函数调用会经过诸多步骤，如字母小写化（译注：指函数名小写化，PHP不区分函数名大小写）、哈希查找，会跟随被调用的函数一起执行。在某些情况下，你可以使用isset()技巧加速执行你的代码。\r\nEx.（举例如下）\r\nif (strlen($foo) < 5) { echo “Foo is too short”; }\r\nvs.（与下面的技巧做比较）\r\nif (!isset($foo{5})) { echo “Foo is too short”; }\r\n调用isset()恰巧比strlen()快，因为与后者不同的是，isset()作为一种语言结构，意味着它的执行不需要函数查找和字母小写化。也就是说，实际上在检验字符串长度的顶层代码中你没有花太多开销。\r\n\r\n34. 当执行变量$i的递增或递减时，$i++会比++$i慢一些。这种差异是PHP特有的，并不适用于其他语言，所以请不要修改你的C或Java代码并指望它们能立即变快，没用的。++$i更快是因为它只需要3条指令(opcodes)，$i++则需要4条指令。后置递增实际上会产生一个临时变量，这个临时变量随后被递增。而前置递增直接在原值上递增。这是最优化处理的一种，正如Zend的PHP优化器所作的那样。牢记这个优化处理不失为一个好主意，因为并不是所有的指令优化器都会做同样的优化处理，并且存在大量没有装配指令优化器的互联网服务提供商（ISPs）和服务器。\r\n\r\n35. 并不是事必面向对象(OOP)，面向对象往往开销很大，每个方法和对象调用都会消耗很多内存。\r\n\r\n36. 并非要用类实现所有的数据结构，数组也很有用。\r\n\r\n37. 不要把方法细分得过多，仔细想想你真正打算重用的是哪些代码？\r\n\r\n38. 当你需要时，你总能把代码分解成方法。\r\n\r\n39. 尽量采用大量的PHP内置函数。\r\n\r\n40. 如果在代码中存在大量耗时的函数，你可以考虑用C扩展的方式实现它们。\r\n\r\n41. 评估检验(profile)你的代码。检验器会告诉你，代码的哪些部分消耗了多少时间。Xdebug调试器包含了检验程序，评估检验总体上可以显示出代码的瓶颈。\r\n\r\n42. mod_zip可作为Apache模块，用来即时压缩你的数据，并可让数据传输量降低80%。', '凯哥', '54个提高PHP程序运行效率的方法', '2017-12-19 03:53:01', 'css', 1);

-- --------------------------------------------------------

--
-- 表的结构 `music_category`
--

CREATE TABLE `music_category` (
  `qid` int(11) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '大板块名字',
  `image` varchar(70) NOT NULL,
  `orderby` int(11) NOT NULL,
  `del` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_category`
--

INSERT INTO `music_category` (`qid`, `name`, `image`, `orderby`, `del`) VALUES
(47, '日韩', 'uploads\\20171117/4a39296cb2af6b87d5266af1f1b909fd.jpg', 7, 1),
(46, 'w', 'uploads\\20171115/2ef575cdf501184452e7ddf2e3d16d60.jpg', 6, 1),
(45, '欧美大牌', 'uploads\\20171115/078bec5e52fc215d6443980289ffddeb.jpg', 5, 1),
(41, '粤语经典', 'uploads\\20171113/0c223919ccd329f61bee00d734629116.jpg', 13, 0),
(42, '华语流行', 'uploads\\20171113/7151f4a47cb47922f7825e325d840963.jpg', 14, 0),
(43, '欧美经典', 'uploads\\20171113/4100f9c52d0e7269e4fea8b6499f98ea.jpg', 15, 0),
(44, '影视金曲', 'uploads\\20171113/4297dad356913386f7bd9cd093647b7c.jpg', 16, 0);

-- --------------------------------------------------------

--
-- 表的结构 `music_category_right`
--

CREATE TABLE `music_category_right` (
  `qid` int(32) NOT NULL,
  `name` varchar(60) NOT NULL,
  `del` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_category_right`
--

INSERT INTO `music_category_right` (`qid`, `name`, `del`) VALUES
(1, '亚洲热曲', 1),
(2, '粤语劲曲', 1),
(3, '热门单曲', 0),
(4, '最新单曲', 0);

-- --------------------------------------------------------

--
-- 表的结构 `music_category_right_song`
--

CREATE TABLE `music_category_right_song` (
  `vid` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `del` int(2) NOT NULL DEFAULT '0',
  `mid` int(11) NOT NULL,
  `singer` varchar(32) NOT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tou` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_category_right_song`
--

INSERT INTO `music_category_right_song` (`vid`, `name`, `del`, `mid`, `singer`, `addtime`, `tou`) VALUES
(16, '追光者', 0, 4, '岑宁儿 ', '2017-11-15 12:52:24', 'uploads\\20171115/24c2af07486461977b8e83ef20f7aafb.jpg'),
(15, '默', 0, 4, '周杰伦', '2017-11-15 01:48:54', 'uploads\\20171115/ea5b56e54a14d2dfb00c3712c73a6603.jpg'),
(13, '一生所爱', 0, 3, '卢冠廷', '2017-11-15 12:57:31', 'uploads\\20171115/01f01d6131d4e045f6a23c5fc291e71e.jpg'),
(12, '静下来', 0, 3, '赵雷', '2017-11-13 03:26:39', 'uploads\\20171113/c6c28398db4d64060fc41045b4dddbfe.jpg'),
(11, '我们不一样', 0, 3, '大壮', '2017-11-13 03:24:13', 'uploads\\20171113/8494c1bad562ec98976c94680a457841.jpg'),
(14, '云烟成雨', 0, 4, '房东的猫', '2017-11-13 03:41:55', 'uploads\\20171113/b84279e85fa679471dc2a9270de70e2e.jpg'),
(9, '暧昧', 0, 4, '薛之谦', '2017-11-16 07:11:13', 'uploads\\20171116/63c60c2b062bffb245c7030e9f08a318.jpg'),
(17, ' 后来', 0, 4, '刘若英', '2017-11-15 12:53:46', 'uploads\\20171115/758778f4d457cf96cd199319137f7014.jpg'),
(18, ' 追梦赤子心', 0, 3, '鹿晗 ', '2017-11-15 12:54:33', 'uploads\\20171115/1b675890d66bba17684bf21f62b1f8b6.jpg'),
(19, ' 安和桥', 0, 3, '宋冬野 ', '2017-11-15 12:55:11', 'uploads\\20171115/35c9accd308998a21200143748dcddde.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `music_category_song`
--

CREATE TABLE `music_category_song` (
  `vid` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `mid` int(11) NOT NULL COMMENT '对应板块的qid',
  `singer` varchar(32) NOT NULL,
  `tou` varchar(70) NOT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order` int(11) NOT NULL DEFAULT '0',
  `del` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_category_song`
--

INSERT INTO `music_category_song` (`vid`, `name`, `mid`, `singer`, `tou`, `addtime`, `order`, `del`) VALUES
(80, '偏偏喜欢你', 41, '陈百强', 'uploads\\20171113/cbb5c01f61931857be871c4871e3f6b6.jpg', '2017-11-15 01:41:30', 1, 0),
(81, '千千阙歌', 41, '张国荣', 'uploads\\20171113/f417693ac3218a107f0f8248fa191a96.jpg', '2017-11-13 01:52:57', 2, 0),
(82, '演员', 42, '薛之谦', 'uploads\\20171113/48dbe0de6787a4cc16904518fdfe49f9.jpg', '2017-11-13 03:28:00', 1, 0),
(83, '冰雨', 42, '刘德华', 'uploads\\20171113/cf72a54cc266f6e58e5afec1ae923788.jpg', '2017-11-13 02:47:42', 2, 0),
(84, 'Beat it', 43, 'MJ', 'uploads\\20171113/846a0f69126f51c733343738605469b2.jpg', '2017-11-13 02:50:14', 1, 0),
(85, 'more than i can say', 43, 'Bobby vee', 'uploads\\20171113/edb2334055fe6849161170f145a84e54.jpg', '2017-11-13 03:00:34', 2, 0),
(87, 'you are not alone', 45, 'mj', 'uploads\\20171115/84394c4fee96749d98f4755dde74a397.jpg', '2017-11-15 09:12:11', 1, 1),
(88, '遥远的她', 41, '张学友', 'uploads\\20171115/b51e79843b51b65c799e04ae17e27b3f.jpg', '2017-11-15 11:27:36', 3, 0),
(89, '街灯', 41, '王杰', 'uploads\\20171115/75a3170380dd3c4e84974746cfc98d09.jpg', '2017-11-15 11:28:38', 4, 0),
(90, '浪子心声', 41, '许冠杰', 'uploads\\20171115/80a8223e9b52877d27fa0aea741b4684.jpg', '2017-11-15 11:29:56', 5, 0),
(91, '成都', 42, '赵雷', 'uploads\\20171115/fdff76e843637bd3aca5c0d186e84dde.jpeg', '2017-11-15 12:40:55', 3, 0),
(92, '半壶纱', 42, '刘珂矣 ', 'uploads\\20171115/14b84edfd5806e07e34a18a7f0868cd0.jpg', '2017-11-15 12:41:49', 4, 0),
(93, '下完这场雨', 42, '后弦', 'uploads\\20171115/1708dc1da30dd86c8391afa39ee77ff0.jpg', '2017-11-15 12:42:56', 5, 0),
(94, 'Something Just Like This', 43, 'The Chainsmokers', 'uploads\\20171115/354bf4e0b09170d7417ca219cdafd5a2.jpg', '2017-11-15 12:43:56', 3, 0),
(95, 'There for You', 43, 'Martin Garrix', 'uploads\\20171115/fb80d876b0479f95ea4cfa591c808a76.jpg', '2017-11-15 12:44:43', 4, 0),
(96, ' Victory', 43, 'Two Steps From Hell ', 'uploads\\20171115/9f49f4d3a6abb105d85e450acb2b9f33.jpg', '2017-11-15 12:45:27', 5, 0),
(97, '无敌', 44, '邓超', 'uploads\\20171115/bbeb36b74daa3b191fc91289e01304e4.jpg', '2017-11-15 12:47:42', 1, 0),
(98, '夏洛特烦恼', 44, '金志文', 'uploads\\20171115/484e001c5606cce250338f958f07f77e.jpg', '2017-11-15 12:48:38', 2, 0),
(99, '后来', 44, '刘若英', 'uploads\\20171116/03e9f23a356766383bc18661dcd48fce.jpg', '2017-11-16 07:12:45', 3, 0),
(100, ' 红颜旧', 44, '刘涛', 'uploads\\20171115/552762302bd2e63864b6e3bf5ebf82e4.jpg', '2017-11-15 12:50:08', 4, 0),
(101, ' 满月', 44, '陈思思', 'uploads\\20171115/d679881f77aa9e908ada05653ec28026.jpg', '2017-11-17 03:00:54', 5, 0);

-- --------------------------------------------------------

--
-- 表的结构 `music_class`
--

CREATE TABLE `music_class` (
  `cid` int(11) NOT NULL,
  `A` int(11) NOT NULL COMMENT 'ssvip',
  `B` int(11) NOT NULL COMMENT 'svip',
  `C` int(11) NOT NULL COMMENT 'vip'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_ding`
--

CREATE TABLE `music_ding` (
  `sid` int(11) NOT NULL,
  `consignee` varchar(40) NOT NULL,
  `province` int(11) NOT NULL,
  `city` int(11) NOT NULL,
  `district` int(11) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `zipcode` int(11) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `tag_name` varchar(50) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `ddan` varchar(60) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_ding`
--

INSERT INTO `music_ding` (`sid`, `consignee`, `province`, `city`, `district`, `address`, `zipcode`, `tel`, `tag_name`, `uid`, `ddan`) VALUES
(1, '马云', 2, 23, 87, '天安门层楼', 123456, '1234567890', '家', 0, '2017111479241'),
(2, '严凯', 10, 108, 1140, '千锋帝国大厦2号', 201900, '12345678901', '公司', 0, '2017111479241'),
(7, '严凯', 10, 108, 1140, '宝山区吴淞路千锋帝国大厦5楼205', 201900, '12345678901', '办公室', 12, '2017111479241'),
(8, '严凯', 10, 108, 1140, '宝山区吴淞路千锋帝国大厦5楼205', 201900, '12345678901', '办公室', 12, '2017111479241'),
(18, '刘德华', 7, 78, 883, '和兴盛2号', 121400, '11111111111', '家庭', 13, '2017111479241'),
(17, '严凯', 3, 37, 396, '河东狮区20号', 300171, '19023438422', '家庭', 13, '2017111485998'),
(19, '严凯', 10, 108, 1140, '上海市宝山区吴淞路20号', 201900, '18306042847', '学校', 10, '2017111407166'),
(20, 'dasdsasadsaa', 2, 36, 377, '飒飒飒飒啊飒飒2号', 111111, '11111111111', '22', 141, '2017111657533'),
(21, 'sdsaddsaddsadsa', 2, 36, 377, '但是房贷首付多少撒号', 100111, '11111111111', '家', 144, '2017111702982');

-- --------------------------------------------------------

--
-- 表的结构 `music_gedan`
--

CREATE TABLE `music_gedan` (
  `aid` int(11) NOT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `class` varchar(100) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_gedan`
--

INSERT INTO `music_gedan` (`aid`, `addtime`, `class`, `uid`) VALUES
(1, '2017-11-06 16:00:00', '我的收藏', 0),
(2, '2017-11-14 16:00:00', '明天', 0),
(46, '2017-11-10 09:17:05', '千锋', 13),
(37, '2017-11-10 08:57:30', '安和桥', 13),
(28, '2017-11-10 03:40:31', '哈哈哈', 12),
(53, '2017-11-10 11:40:39', '酷我音乐', 13),
(58, '2017-11-10 12:42:12', '严凯你个锤子', 9),
(57, '2017-11-10 12:42:01', '音乐盒', 9),
(60, '2017-11-16 09:53:46', '我的歌单', 141),
(61, '2017-11-16 09:55:38', '理论', 141),
(62, '2017-11-16 11:06:59', '许巍', 141),
(63, '2017-11-16 11:33:44', 'liudehua ', 141),
(66, '2017-12-19 03:44:05', 'ffff', 10);

-- --------------------------------------------------------

--
-- 表的结构 `music_geshou`
--

CREATE TABLE `music_geshou` (
  `oid` int(11) NOT NULL,
  `author` varchar(50) DEFAULT NULL,
  `stat` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_geshou`
--

INSERT INTO `music_geshou` (`oid`, `author`, `stat`) VALUES
(1, '阿杜', NULL),
(2, '安来宁', NULL),
(3, '艾尔肯', NULL),
(4, '阿鲲', NULL),
(5, 'Assen捷', NULL),
(6, '爱乐团王超', NULL),
(7, '安琥', NULL),
(8, '阿木', NULL),
(9, '阿宝', NULL),
(10, '艾索', NULL),
(11, '阿不都拉', NULL),
(12, '阿力木江·托合提', NULL),
(13, '艾宝良', NULL),
(14, '阿牛', NULL),
(15, '艾斯卡尔', NULL),
(16, '阿信', NULL),
(17, '阿力普', NULL),
(18, 'AlimjanTursun', NULL),
(19, 'Anti-General', NULL),
(20, '阿炳', NULL),
(21, 'AP满人', NULL),
(22, '安东阳', NULL),
(23, 'Ablikim Zikrulla izbaRis', NULL),
(24, '阿来', NULL),
(25, '阿穆隆', NULL),
(26, '阿尔法', NULL),
(27, '阿伦', NULL),
(28, 'A-Lin', NULL),
(29, '阿肆', NULL),
(30, '阿桑', NULL),
(31, '阿兰', NULL),
(32, 'Aki阿杰', NULL),
(33, '阿悄', NULL),
(34, '安又琪', NULL),
(35, 'AGA', NULL),
(36, '安九', NULL),
(37, '艾怡良', NULL),
(38, '阿鲁阿卓', NULL),
(39, 'Angelababy', NULL),
(40, '爱戴', NULL),
(41, 'aniDa', NULL),
(42, '阿轮', NULL),
(43, '安以轩', NULL),
(44, '阿筎那', NULL),
(45, '阿细', NULL),
(46, '艾梦萌', NULL),
(47, '阿丽玛', NULL),
(48, '不才', NULL),
(49, '本兮', NULL),
(50, '白百何', NULL),
(51, '本多RuRu', NULL),
(52, '拜尔娜', NULL),
(53, '白云', NULL),
(54, '白冰', NULL),
(55, '白若溪', NULL),
(56, '冰淇', NULL),
(57, '毕夏', NULL),
(58, '白安', NULL),
(59, '柏安妮', NULL),
(60, '贝贝', NULL),
(61, '巴奈', NULL),
(62, '比莉', NULL),
(63, '边巴德吉', NULL),
(64, '白光', NULL),
(65, '白雪', NULL),
(66, '白婧', NULL),
(67, '白晓', NULL),
(68, 'BING', NULL),
(69, '碧娜', NULL),
(70, '巴哈尔古丽', NULL),
(71, '巴桑', NULL),
(72, '冰弦', NULL),
(73, '白雪', NULL),
(74, '巴雅尔其其格', NULL),
(75, '包娜娜', NULL),
(76, '白虹', NULL),
(77, 'Bilal Enwer', NULL),
(78, '毕书尽', NULL),
(79, '拜合提亚bahtiyar aziz', NULL),
(80, '拜合提亚尔塔依尔', NULL),
(81, '白水', NULL),
(82, '鲍比达', NULL),
(83, 'Beatsound', NULL),
(84, '白举纲', NULL),
(85, '斑辣个马', NULL),
(86, '布仁巴雅尔', NULL),
(87, '白羽', NULL),
(88, 'BRAVEE', NULL),
(89, '陈奕迅', NULL),
(90, '陈小春', NULL),
(91, '陈百强', NULL),
(92, '陈冠希', NULL),
(93, '陈势安', NULL),
(94, '陈柏宇', NULL),
(95, '陈鸿宇', NULL),
(96, '侧田', NULL),
(97, '崔健', NULL),
(98, '蔡旻佑', NULL),
(99, '陈楚生', NULL),
(100, '陈学冬', NULL),
(101, '曹轩宾', NULL),
(102, '成龙', NULL),
(103, '陈坤', NULL),
(104, '曾志豪', NULL),
(105, '曾一鸣', NULL),
(106, '曾志伟', NULL),
(107, '蔡国权', NULL),
(108, '陈奂仁', NULL),
(109, '陈星', NULL),
(110, '蔡健雅', NULL),
(111, '陈粒', NULL),
(112, '蔡依林', NULL),
(113, '陈绮贞', NULL),
(114, '陈洁仪', NULL),
(115, '陈慧娴', NULL),
(116, '曹方', NULL),
(117, '蔡琴', NULL),
(118, '程璧', NULL),
(119, '陈慧琳', NULL),
(120, '陈珊妮', NULL),
(121, '蔡淳佳', NULL),
(122, '蔡卓妍', NULL),
(123, 'CRITTY', NULL),
(124, '陈瑞', NULL),
(125, '陈苑淇', NULL),
(126, '崔子格', NULL),
(127, '陈僖仪', NULL),
(128, '陈思思', NULL),
(129, '凑诗', NULL),
(130, '陈妍希', NULL),
(131, '戴荃', NULL),
(132, '迪克牛仔', NULL),
(133, '刀郎', NULL),
(134, '窦唯', NULL),
(135, '蛋堡', NULL),
(136, '大冰', NULL),
(137, '邓超', NULL),
(138, '冬子', NULL),
(139, '东篱', NULL),
(140, '多亮', NULL),
(141, '大鹏', NULL),
(142, '东来东往', NULL),
(143, '大张伟', NULL),
(144, '东南', NULL),
(145, '东山少爷', NULL),
(146, '单小源', NULL),
(147, '邓丽君', NULL),
(148, '戴佩妮', NULL),
(149, '邓丽欣', NULL),
(150, '杜雯媞', NULL),
(151, '董贞', NULL),
(152, '丁当', NULL),
(153, '窦靖童', NULL),
(154, '戴爱玲', NULL),
(155, '邓福如', NULL),
(156, '黛青塔娜', NULL),
(157, '丁薇', NULL),
(158, 'DJ小星星', NULL),
(159, '邓颖芝', NULL),
(160, '二珂', NULL),
(161, 'elephant DEE', NULL),
(162, 'EYLICS', NULL),
(163, 'Evin.柒', NULL),
(164, '鄂尔佳明', NULL),
(165, '贰鱼', NULL),
(166, '二直', NULL),
(167, '尔玛依娜', NULL),
(168, '尔玛阿依', NULL),
(169, '二米', NULL),
(170, '贰佰', NULL),
(171, 'eliaqsopa', NULL),
(172, '哦漏', NULL),
(173, 'EDIQ', NULL),
(174, '伊力哈尔·阿卜杜热合曼', NULL),
(175, 'ETIRAZ', NULL),
(176, 'E.SO', NULL),
(177, 'EDMarco', NULL),
(178, 'EdJean', NULL),
(179, '方大同', NULL),
(180, '费玉清', NULL),
(181, '方力申', NULL),
(182, '范逸臣', NULL),
(183, '樊凡', NULL),
(184, '冯佳界', NULL),
(185, '房祖名', NULL),
(186, '方泂镔', NULL),
(187, '费翔', NULL),
(188, '范玮琪', NULL),
(189, '范晓萱', NULL),
(190, '冯曦妤', NULL),
(191, '傅佩嘉', NULL),
(192, '凤飞飞', NULL),
(193, '樊竹青', NULL),
(194, '绯村柯北', NULL),
(195, '方糖泡泡', NULL),
(196, '付娜', NULL),
(197, '傅颖', NULL),
(198, '范冰冰', NULL),
(199, '范文芳', NULL),
(200, 'G.E.M.邓紫棋', NULL),
(201, '郭静', NULL),
(202, '郭采洁', NULL),
(203, '高胜美', NULL),
(204, '关心妍', NULL),
(205, '关淑怡', NULL),
(206, '高姗', NULL),
(207, '龚玥', NULL),
(208, '桂雨濛', NULL),
(209, '关诗敏', NULL),
(210, '官恩娜', NULL),
(211, '格子兮', NULL),
(212, '郭美美', NULL),
(213, '顾莉雅', NULL),
(214, '古巨基', NULL),
(215, '光良', NULL),
(216, '高进', NULL),
(217, '郭德纲', NULL),
(218, '郭富城', NULL),
(219, '郭顶', NULL),
(220, '高安', NULL),
(221, '关喆', NULL),
(222, '关正杰', NULL),
(223, '宫傲', NULL),
(224, '葛平', NULL),
(225, '回音哥', NULL),
(226, '胡彦斌Tiger Hu', NULL),
(227, '河图', NULL),
(228, '华晨宇', NULL),
(229, '胡夏', NULL),
(230, '胡歌', NULL),
(231, '后弦', NULL),
(232, '胡伟立', NULL),
(233, '黄渤', NULL),
(234, '郝云', NULL),
(235, '黄义达', NULL),
(236, '花粥', NULL),
(237, 'HITA', NULL),
(238, '黄龄', NULL),
(239, '黄小琥', NULL),
(240, '韩红', NULL),
(241, '何洁', NULL),
(242, '韩宝仪', NULL),
(243, '胡蓓蔚', NULL),
(244, '何曼婷', NULL),
(245, '何璐', NULL),
(246, '韩雪', NULL),
(247, '黄雅莉', NULL),
(248, '黄淑惠', NULL),
(249, 'IRiS七叶', NULL),
(250, 'Iris安', NULL),
(251, 'iMoon', NULL),
(252, 'InfiniteMusic', NULL),
(253, 'Iceloki', NULL),
(254, 'imeatART', NULL),
(255, 'iCsuo', NULL),
(256, 'iiiis', NULL),
(257, 'ilham丁丁', NULL),
(258, '金志文', NULL),
(259, '蒋明', NULL),
(260, 'Jason Chen', NULL),
(261, '靳松', NULL),
(262, '姜育恒', NULL),
(263, '蒋蒋', NULL),
(264, '蒋勋', NULL),
(265, '金贵晟', NULL),
(266, '简弘亦', NULL),
(267, '姜玉阳', NULL),
(268, '贾乃亮', NULL),
(269, '蒋大为', NULL),
(270, '井柏然', NULL),
(271, '金玟岐', NULL),
(272, '金莎', NULL),
(273, '降央卓玛', NULL),
(274, '金海心', NULL),
(275, '江美琪', NULL),
(276, 'Jam', NULL),
(277, '吉克隽逸', NULL),
(278, '金池', NULL),
(279, '江语晨', NULL),
(280, '江映蓉', NULL),
(281, '蒋雅文', NULL),
(282, '邝美云', NULL),
(283, '侃侃', NULL),
(284, '可歆', NULL),
(285, '柯以敏', NULL),
(286, '可晴', NULL),
(287, '括号君', NULL),
(288, 'Karey天天', NULL),
(289, 'K娃', NULL),
(290, '孔莹', NULL),
(291, '孔宪孜 Kylee', NULL),
(292, 'KBShinya', NULL),
(293, '柯有伦', NULL),
(294, '克尔曼', NULL),
(295, 'KenT', NULL),
(296, '康康', NULL),
(297, '柯震东', NULL),
(298, '柯受良', NULL),
(299, '柯以敏', NULL),
(300, '卡修Rui', NULL),
(301, '括号君', NULL),
(302, 'Karey天天', NULL),
(303, 'K娃', NULL),
(304, '刘瑞琦', NULL),
(305, '刘思涵', NULL),
(306, '梁静茹', NULL),
(307, '林忆莲', NULL),
(308, '洛天依', NULL),
(309, '李宇春', NULL),
(310, '刘若英', NULL),
(311, '刘惜君', NULL),
(312, '梁咏琪', NULL),
(313, '卢巧音', NULL),
(314, '刘涛', NULL),
(315, '李佳薇', NULL),
(316, '梁心颐', NULL),
(317, '李霄云', NULL),
(318, '李玟', NULL),
(319, '林俊杰', NULL),
(320, '李荣浩', NULL),
(321, '李志', NULL),
(322, '李健', NULL),
(323, '李克勤', NULL),
(324, '刘德华', NULL),
(325, '老狼', NULL),
(326, '李宗盛', NULL),
(327, '林宥嘉', NULL),
(328, '罗志祥', NULL),
(329, '李易峰', NULL),
(330, '李玖哲', NULL),
(331, '马頔', NULL),
(332, '麦浚龙', NULL),
(333, 'MC Hotdog', NULL),
(334, '慕寒', NULL),
(335, '马条', NULL),
(336, 'M-PHOTOS', NULL),
(337, '麦振鸿', NULL),
(338, '莫西子诗', NULL),
(339, '毛宁', NULL),
(340, '马天宇', NULL),
(341, '马旭东', NULL),
(342, '满文军', NULL),
(343, '莫文蔚', NULL),
(344, '梅艳芳', NULL),
(345, '毛阿敏', NULL),
(346, '孟庭苇', NULL),
(347, '马丽', NULL),
(348, '末小皮', NULL),
(349, '门丽', NULL),
(350, '梦洛伊', NULL),
(351, '麦家瑜', NULL),
(352, '梦璟SAYA', NULL),
(353, '莫艳琳', NULL),
(354, '那英', NULL),
(355, '南妮', NULL),
(356, '宁静', NULL),
(357, '娜仁齐齐格', NULL),
(358, '鸟爷ToriSama', NULL),
(359, '倪纯', NULL),
(360, '倪睿思', NULL),
(361, '娜日', NULL),
(362, '倪安东', NULL),
(363, '宁夏', NULL),
(364, '宁桓宇', NULL),
(365, '南城二哥', NULL),
(366, '南风', NULL),
(367, '泥鳅Niko', NULL),
(368, '南宫嘉骏', NULL),
(369, '南风ZJN', NULL),
(370, '暖场小粽子', NULL),
(371, '宁林', NULL),
(372, '欧得洋', NULL),
(373, '欧阳靖', NULL),
(374, '欧豪', NULL),
(375, '欧翠峰', NULL),
(376, '欧汉声', NULL),
(377, 'ONE_Official', NULL),
(378, 'Okna Tsahan Zam', NULL),
(379, '欧阳青', NULL),
(380, 'Olivia Ong', NULL),
(381, '欧阳娜娜', NULL),
(382, '欧阳菲菲', NULL),
(383, '欧阳雪', NULL),
(384, '欧倩怡', NULL),
(385, 'Odding', NULL),
(386, '欧阳玲玲', NULL),
(387, 'Orulico', NULL),
(388, '黄秋颖', NULL),
(389, '彭佳慧', NULL),
(390, '彭羚', NULL),
(391, '彭丽媛', NULL),
(392, '潘辰', NULL),
(393, '潘美辰', NULL),
(394, '潘越云', NULL),
(395, '潘虹樾', NULL),
(396, '彭芳', NULL),
(397, '彭家丽', NULL),
(398, '彭丽丽', NULL),
(399, '彭青', NULL),
(400, '朴树', NULL),
(401, '潘玮柏', NULL),
(402, 'Pianoboy', NULL),
(403, '品冠', NULL),
(404, '庞龙', NULL),
(405, '彭坦', NULL),
(406, '彭于晏', NULL),
(407, '潘裕文', NULL),
(408, '帕尔哈提', NULL),
(409, '齐秦', NULL),
(410, '祁隆', NULL),
(411, '齐晨', NULL),
(412, '秦昊', NULL),
(413, '乔任梁', NULL),
(414, '区瑞强', NULL),
(415, '奇然', NULL),
(416, '邱永传', NULL),
(417, '乔洋', NULL),
(418, '曲婉婷', NULL),
(419, '祈Inory', NULL),
(420, '戚薇', NULL),
(421, '齐豫', NULL),
(422, '曲锦楠', NULL),
(423, '齐栾', NULL),
(424, '裘海正', NULL),
(425, '千百惠', NULL),
(426, '乔维怡', NULL),
(427, '容祖儿', NULL),
(428, '任然', NULL),
(429, '任月丽', NULL),
(430, '任静', NULL),
(431, 'Ramila_Rozimamat', NULL),
(432, '芮恩', NULL),
(433, 'Rita黄汐源', NULL),
(434, '任洁玲', NULL),
(435, '任妙音', NULL),
(436, '瑞雪', NULL),
(437, '任贤齐', NULL),
(438, 'Riyat.Yusup（热亚提.玉苏甫）', NULL),
(439, '容中尔甲', NULL),
(440, '饶天亮', NULL),
(441, '阮经天', NULL),
(442, '润土', NULL),
(443, 'Ricky Ho', NULL),
(444, '任重', NULL),
(445, '宋冬野', NULL),
(446, '石进', NULL),
(447, '孙楠', NULL),
(448, '孙子涵', NULL),
(449, '苏永康', NULL),
(450, '胜屿', NULL),
(451, '沙宝亮', NULL),
(452, 'smile_小千', NULL),
(453, 'Senpai', NULL),
(454, '苏阳', NULL),
(455, '苏醒', NULL),
(456, '孙燕姿', NULL),
(457, 'Sunshine', NULL),
(458, '孙露', NULL),
(459, '邵夷贝', NULL),
(460, '尚雯婕', NULL),
(461, '少司命', NULL),
(462, '三无MarBlue', NULL),
(463, '苏芮', NULL),
(464, '顺子', NULL),
(465, '孙俪', NULL),
(466, '宋祖英', NULL),
(467, '谭维维', NULL),
(468, '田馥甄', NULL),
(469, '陶晶莹', NULL),
(470, '谭艳', NULL),
(471, 'Tacke竹桑', NULL),
(472, '汤旭', NULL),
(473, '田震', NULL),
(474, '童丽', NULL),
(475, '陶喆', NULL),
(476, '谭咏麟', NULL),
(477, 'Tank', NULL),
(478, '童安格', NULL),
(479, '邰正宵', NULL),
(480, '屠洪刚', NULL),
(481, '佟大为', NULL),
(482, '腾格尔', NULL),
(483, 'UmuD Eziz', NULL),
(484, 'UNDERAQUE', NULL),
(485, 'Uncle Martin', NULL),
(486, 'Uncle Hu', NULL),
(487, 'UP', NULL),
(488, 'Ulysses', NULL),
(489, 'Urmim', NULL),
(490, 'VaVa', NULL),
(491, 'VIVI', NULL),
(492, 'VEDA', NULL),
(493, 'Virginia Glück', NULL),
(494, 'Von Lee', NULL),
(495, 'Veegee', NULL),
(496, 'V.K克', NULL),
(497, 'VISUDY', NULL),
(498, 'VESK GREEN', NULL),
(499, 'Vous Records', NULL),
(500, 'Vanhci', NULL),
(501, 'verahuuu', NULL),
(502, 'VISIN', NULL),
(503, '王力宏', NULL),
(504, '汪峰', NULL),
(505, '王杰', NULL),
(506, '吴亦凡', NULL),
(507, '伍佰', NULL),
(508, '汪苏泷', NULL),
(509, '万晓利', NULL),
(510, '魏晨', NULL),
(511, '五色石南叶', NULL),
(512, '吴克群', NULL),
(513, '王菲', NULL),
(514, '王心凌', NULL),
(515, '王若琳', NULL),
(516, '卫兰', NULL),
(517, '吴雨霏', NULL),
(518, '温岚', NULL),
(519, '吴若希', NULL),
(520, '魏新雨', NULL),
(521, '王菀之', NULL),
(522, '魏如萱', NULL),
(523, '王筝', NULL),
(524, '吴金黛', NULL),
(525, '谢安琪', NULL),
(526, '萧亚轩', NULL),
(527, '薛凯琪', NULL),
(528, '许茹芸', NULL),
(529, '徐佳莹', NULL),
(530, '弦子', NULL),
(531, '许飞', NULL),
(532, '许慧欣', NULL),
(533, '辛晓琪', NULL),
(534, '谢春花', NULL),
(535, '薛之谦', NULL),
(536, '许巍', NULL),
(537, '许嵩', NULL),
(538, '萧敬腾', NULL),
(539, '谢霆锋', NULL),
(540, '小曲儿', NULL),
(541, '许志安', NULL),
(542, '夏天Alex', NULL),
(543, '许冠杰', NULL),
(544, '徐良', NULL),
(545, '杨宗纬', NULL),
(546, '尧十三', NULL),
(547, '庾澄庆', NULL),
(548, '音频怪物', NULL),
(549, '游鸿明', NULL),
(550, '岳云鹏', NULL),
(551, '杨坤', NULL),
(552, '杨瑞代', NULL),
(553, '约瑟翰庞麦郎', NULL),
(554, '俞灏明', NULL),
(555, '宇桐非', NULL),
(556, '杨千嬅', NULL),
(557, '银临', NULL),
(558, '杨丞琳', NULL),
(559, '燕池', NULL),
(560, '云の泣', NULL),
(561, '郁可唯', NULL),
(562, '姚贝娜', NULL),
(563, '叶蒨文', NULL),
(564, '严艺丹', NULL),
(565, '泳儿', NULL),
(566, '云菲菲', NULL),
(567, '张靓颖', NULL),
(568, '张惠妹', NULL),
(569, '张悬', NULL),
(570, '庄心妍', NULL),
(571, '张韶涵', NULL),
(572, '张碧晨', NULL),
(573, '周笔畅', NULL),
(574, '赵薇', NULL),
(575, '郑秀文', NULL),
(576, '张芸京', NULL),
(577, '郑融', NULL),
(578, '曾轶可', NULL),
(579, '赵丽颖', NULL),
(580, '张含韵', NULL),
(581, '章子怡', NULL),
(582, '张可儿', NULL),
(583, '张婧', NULL),
(584, '周杰伦', NULL),
(585, '张学友', NULL),
(586, '赵雷', NULL),
(587, '张国荣', NULL),
(588, '张敬轩', NULL),
(589, '张杰', NULL),
(590, '周传雄', NULL),
(591, '张信哲', NULL),
(592, '张宇', NULL),
(593, '周柏豪', NULL),
(594, '赵照', NULL),
(595, '郑中基', NULL),
(596, '周华健', NULL),
(597, '郑伊健', NULL),
(598, '张赫宣', NULL),
(599, '郑钧', NULL),
(600, '张震岳', NULL),
(601, '张智霖', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `music_hotsiner`
--

CREATE TABLE `music_hotsiner` (
  `hid` int(11) NOT NULL,
  `author` varchar(50) NOT NULL,
  `tu` varchar(70) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `zi` char(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_hotsiner`
--

INSERT INTO `music_hotsiner` (`hid`, `author`, `tu`, `gid`, `zi`) VALUES
(2, '周杰伦', '/images/ge/zhou.jpg', NULL, ''),
(3, '陈奕迅', '/images/ge/chen.jpg', NULL, ''),
(4, '李荣浩', '/images/ge/li.jpg', NULL, ''),
(5, '那英', '/images/ge/na.jpg', NULL, ''),
(6, '王菲', '/images/ge/wang.jpg', NULL, ''),
(7, '薛之谦', '/images/ge/xue.jpg', NULL, ''),
(8, '张学友', '/images/ge/zhang.jpg', NULL, ''),
(9, 'Maroon 5', '/images/ge/Maroon 5.jpg', NULL, ''),
(10, '林俊杰', NULL, NULL, ''),
(11, '杨宗纬', NULL, NULL, ''),
(12, '许巍', NULL, NULL, ''),
(13, '赵雷', NULL, NULL, ''),
(14, '李志', NULL, NULL, ''),
(15, '王力宏', NULL, NULL, ''),
(16, '宋冬野', NULL, NULL, ''),
(17, '朴树', NULL, NULL, ''),
(18, '李健', NULL, NULL, ''),
(19, '陈小春', NULL, NULL, ''),
(20, 'G.E.M.邓紫棋', NULL, NULL, ''),
(21, '蔡健雅', NULL, NULL, ''),
(22, '陈粒', NULL, NULL, ''),
(23, '孙燕姿', NULL, NULL, ''),
(24, '金玟岐', NULL, NULL, ''),
(25, '莫文蔚', NULL, NULL, ''),
(26, '谢安琪', NULL, NULL, ''),
(27, '杨千嬅', NULL, NULL, ''),
(28, '张靓颖', NULL, NULL, ''),
(29, '张惠妹', NULL, NULL, ''),
(30, '容祖儿', NULL, NULL, ''),
(31, '蔡依林', NULL, NULL, ''),
(32, '刘瑞琦', NULL, NULL, ''),
(33, '刘思涵', NULL, NULL, ''),
(34, 'A-Lin', NULL, NULL, ''),
(35, '梁静茹', NULL, NULL, ''),
(36, 'Sunshine', NULL, NULL, ''),
(37, '陈绮贞', NULL, NULL, ''),
(38, '谭维维', NULL, NULL, ''),
(39, '张悬', NULL, NULL, ''),
(40, '范玮琪', NULL, NULL, ''),
(41, '萧亚轩', NULL, NULL, ''),
(42, '马頔', NULL, NULL, ''),
(43, '张国荣', NULL, NULL, ''),
(44, '萧敬腾', NULL, NULL, ''),
(45, '张敬轩', NULL, NULL, ''),
(46, '古巨基', NULL, NULL, ''),
(47, '周传雄', NULL, NULL, ''),
(48, '张信哲', NULL, NULL, ''),
(49, '陶喆', NULL, NULL, ''),
(50, '方大同', NULL, NULL, ''),
(51, '汪峰', NULL, NULL, ''),
(52, '石进', NULL, NULL, ''),
(53, '张宇', NULL, NULL, ''),
(54, '李宗盛', NULL, NULL, ''),
(55, '金志文', NULL, NULL, ''),
(56, '林宥嘉', NULL, NULL, ''),
(57, '周华健', NULL, NULL, ''),
(58, '温岚', NULL, NULL, ''),
(59, '周笔畅', NULL, NULL, ''),
(60, '王心凌', NULL, NULL, ''),
(61, '田馥甄', NULL, NULL, ''),
(62, '陈慧娴', NULL, NULL, ''),
(63, '张芸京', NULL, NULL, ''),
(64, '黄小琥', NULL, NULL, ''),
(65, '严艺丹', NULL, NULL, ''),
(66, '吴雨霏', NULL, NULL, ''),
(67, '张韶涵', NULL, NULL, ''),
(68, '庄心妍', NULL, NULL, ''),
(69, '卢巧音', NULL, NULL, ''),
(70, '曾轶可', NULL, NULL, ''),
(71, '不才', NULL, NULL, ''),
(72, '李霄云', NULL, NULL, ''),
(73, '何洁', NULL, NULL, ''),
(74, '郑融', NULL, NULL, ''),
(75, '许飞', NULL, NULL, ''),
(76, '严艺丹', NULL, NULL, ''),
(77, '陈珊妮', NULL, NULL, ''),
(78, '姚贝娜', NULL, NULL, ''),
(79, '张震岳', NULL, NULL, ''),
(80, '迪克牛仔', NULL, NULL, ''),
(81, '林海', NULL, NULL, ''),
(82, '郑伊健', NULL, NULL, ''),
(83, '李易峰', NULL, NULL, ''),
(84, '谢霆锋', NULL, NULL, '');

-- --------------------------------------------------------

--
-- 表的结构 `music_link`
--

CREATE TABLE `music_link` (
  `lid` int(11) NOT NULL,
  `webt` varchar(32) NOT NULL COMMENT '网站'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_mail`
--

CREATE TABLE `music_mail` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_mv`
--

CREATE TABLE `music_mv` (
  `mid` int(11) NOT NULL,
  `cont` varchar(32) NOT NULL COMMENT 'mv内容'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_person`
--

CREATE TABLE `music_person` (
  `id` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `pwd` varchar(32) NOT NULL,
  `tel` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_person`
--

INSERT INTO `music_person` (`id`, `username`, `pwd`, `tel`) VALUES
(1, '肖坤锤子1122', '111111', 2147483647);

-- --------------------------------------------------------

--
-- 表的结构 `music_pinlun`
--

CREATE TABLE `music_pinlun` (
  `pid` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `content` text NOT NULL,
  `singer` varchar(32) DEFAULT NULL,
  `songName` varchar(32) NOT NULL,
  `replayId` int(11) DEFAULT NULL COMMENT '0为主评论，1为回复',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uid` int(11) NOT NULL,
  `songId` int(32) NOT NULL COMMENT '等于歌曲id',
  `aid` int(11) DEFAULT NULL COMMENT '值等于在哪个人下面的评论',
  `istop` int(2) NOT NULL DEFAULT '0',
  `replay` int(32) NOT NULL DEFAULT '0' COMMENT '回复数量',
  `del` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_pinlun`
--

INSERT INTO `music_pinlun` (`pid`, `name`, `content`, `singer`, `songName`, `replayId`, `addtime`, `uid`, `songId`, `aid`, `istop`, `replay`, `del`) VALUES
(1, '严凯', '这首歌我小时候最喜欢听', '周杰伦', '稻香', 0, '2017-11-15 03:22:09', 9, 0, 0, 0, 63, 1),
(2, '肖坤', '这歌声很熟悉，让我想起了过去的很多东西', '陈奕迅', '淘汰', 0, '2017-11-15 03:22:06', 10, 0, 0, 0, 12, 1),
(3, '大帅', '我感动天感动地怎么他妈的感动不了你？？', '陈奕迅', '淘汰', 1, '2017-11-15 03:22:50', 8, 0, 2, 0, 12, 1),
(4, '猪八戒', '就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢就这样被你淘汰，我能说什么呢', '陈奕迅', '淘汰', 1, '2017-11-15 03:22:50', 24, 0, 2, 0, 0, 1),
(23, '严凯', '哦是吗', '园游会', '周杰伦', 1, '2017-11-16 14:01:53', 9, 186008, 22, 0, 0, 0),
(22, '严凯', '哎呦不错哦~', '周杰伦', '园游会', 0, '2017-11-16 14:00:52', 9, 186008, 0, 0, 0, 0),
(21, '严凯', '有一种爱叫做放手', '那英', '默', 0, '2017-11-15 03:53:49', 9, 31473269, 0, 0, 0, 0),
(9, '肖坤', '刘德华', '那英', '三生三世十里桃花', 0, '2017-11-15 03:22:50', 10, 492834287, 0, 0, 0, 1),
(10, '肖坤', '偶看', '三生三世十里桃花', '那英', 1, '2017-11-15 03:46:43', 10, 492834287, 9, 0, 0, 0),
(20, '严凯', '默默无闻', '那英', '默', 0, '2017-11-15 03:56:03', 9, 31473269, 0, 0, 0, 0),
(15, '严凯', '哦是吗', '默', '那英', 1, '2017-11-15 03:48:31', 9, 31473269, 13, 0, 0, 0),
(16, '严凯', '难道不是吗', '那英', '默', 0, '2017-11-15 03:22:50', 9, 31473269, 0, 0, 0, 1),
(17, '严凯', '东京热不热', '封茗囧菌', '东京不太热', 0, '2017-11-15 03:22:50', 9, 34723470, 0, 0, 0, 1),
(18, '严凯', '好像不太热', '东京不太热', '封茗囧菌', 1, '2017-11-15 03:48:35', 9, 34723470, 17, 1, 0, 0),
(19, '严凯', '不热还穿那么少是为什么', '东京不太热', '封茗囧菌', 1, '2017-11-15 03:47:51', 9, 34723470, 17, 0, 0, 0),
(24, '肖坤', 'womenbuyiyang', '大壮', '我们不一样', 0, '2017-11-17 02:16:21', 10, 482395261, 0, 0, 0, 0),
(25, '肖坤', '哦 ，是吗', '我们不一样', '大壮', 1, '2017-11-17 02:16:33', 10, 482395261, 24, 0, 0, 0),
(26, '肖坤', '是的', '我们不一样', '大壮', 1, '2017-11-17 02:16:41', 10, 482395261, 24, 0, 0, 0),
(27, '肖坤', '哦', '我们不一样', '大壮', 1, '2017-11-17 02:16:46', 10, 482395261, 24, 0, 0, 0),
(28, '肖坤', 'hello', '大壮', '我们不一样', 0, '2017-11-17 02:16:54', 10, 482395261, 0, 0, 0, 0),
(29, '肖坤', '刘德华', '大壮', '我们不一样', 0, '2017-11-17 02:17:04', 10, 482395261, 0, 0, 0, 0),
(30, '肖坤', '大撒旦撒撒打算大撒旦撒旦', '大壮', '我们不一样', 0, '2017-11-17 02:17:30', 10, 482395261, 0, 0, 0, 0),
(31, '肖坤', 'liudehua ', '陈奕迅', '最佳损友', 0, '2017-11-17 02:21:43', 10, 65800, 0, 0, 0, 0),
(32, '肖坤', '范德萨发的地方的', '周华健', '让我欢喜让我忧', 0, '2017-12-19 03:43:39', 10, 5255635, 0, 0, 0, 0),
(33, '肖坤', '阿尔大的萨达', '宋冬野', '平淡日子里的刺', 0, '2018-01-04 12:13:59', 10, 27808295, 0, 0, 0, 0),
(34, '肖坤', '急急急', '平淡日子里的刺', '宋冬野', 1, '2018-01-04 12:14:15', 10, 27808295, 33, 0, 0, 0),
(35, '肖坤', '你好', '平淡日子里的刺', '宋冬野', 1, '2018-01-04 12:14:27', 10, 27808295, 33, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `music_shop`
--

CREATE TABLE `music_shop` (
  `hid` int(11) NOT NULL,
  `shop_name` varchar(32) NOT NULL COMMENT '商品名字',
  `shop_counts` text NOT NULL COMMENT '商品总数',
  `image` varchar(200) DEFAULT NULL,
  `pig` varchar(40) NOT NULL DEFAULT '￥2288' COMMENT '商品价格',
  `color` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_shop`
--

INSERT INTO `music_shop` (`hid`, `shop_name`, `shop_counts`, `image`, `pig`, `color`) VALUES
(1, 'red', '100', '/images/tu/d2.png', '￥2288', '红色'),
(2, 'silvery', '100', '/images/tu/d1.png', '￥2288', '银色'),
(3, 'black ', '100', '/images/tu/hei.png', '￥2288', '黑色'),
(4, 'white', '100', '/images/tu/bai.png', '￥2288', '白色'),
(5, 'gary ', '100', '/images/tu/d55.png', '￥2288', '灰色');

-- --------------------------------------------------------

--
-- 表的结构 `music_shou`
--

CREATE TABLE `music_shou` (
  `id` int(11) NOT NULL,
  `songId` int(32) DEFAULT NULL COMMENT '路径',
  `author` char(50) DEFAULT NULL COMMENT '对应歌曲id',
  `addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '收藏时间',
  `uid` int(11) DEFAULT NULL,
  `aid` int(11) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_shou`
--

INSERT INTO `music_shou` (`id`, `songId`, `author`, `addtime`, `uid`, `aid`) VALUES
(238, 515796410, NULL, '2017-11-10 12:19:46', 12, 1),
(237, 28850212, NULL, '2017-11-10 12:19:47', 12, 1),
(236, 421423806, NULL, '2017-11-10 12:19:47', 12, 1),
(235, 189602, NULL, '2017-11-10 12:19:47', 12, 1),
(234, 509723943, NULL, '2017-11-10 12:19:47', 10, 1),
(233, 33166086, NULL, '2017-11-10 12:19:47', 10, 1),
(247, 25714321, NULL, '2018-01-04 12:07:11', 10, 66),
(231, 37095292, NULL, '2017-11-10 12:19:47', 13, 1),
(222, 485960228, NULL, '2017-11-10 12:19:47', 10, 1),
(221, 285095, NULL, '2018-01-04 12:07:17', 10, 66),
(220, 407450223, NULL, '2017-11-10 12:19:47', 10, 1),
(219, 506092654, NULL, '2017-12-19 03:44:13', 10, 66),
(218, 110359, NULL, '2017-11-10 12:19:47', 12, 1),
(230, 516224506, NULL, '2017-11-10 12:19:47', 13, 1),
(229, 29710981, NULL, '2017-11-10 12:19:47', 13, 1),
(227, 65533, NULL, '2017-11-10 12:19:47', 13, 1),
(241, 415792881, NULL, '2017-11-10 12:19:47', 9, 1),
(242, 29818120, NULL, '2017-11-10 12:42:32', 9, 58),
(243, 65533, NULL, '2017-11-10 12:42:22', 9, 57),
(245, 65528, NULL, '2017-11-10 12:42:17', 9, 58),
(246, 482395261, NULL, '2017-11-14 02:40:39', 10, 1),
(248, 65538, NULL, '2017-11-16 11:33:59', 141, 60),
(249, 28481103, NULL, '2017-11-16 10:00:20', 9, 1),
(250, 28481103, NULL, '2017-11-16 10:38:05', 143, 1),
(251, 186008, NULL, '2017-11-16 10:38:54', 143, 1),
(252, 167975, NULL, '2017-11-16 11:06:04', 141, 1),
(255, 280266, NULL, '2017-11-17 02:44:35', 144, 1),
(256, 518077040, NULL, '2017-11-17 02:51:11', 10, 1),
(258, 5255635, NULL, '2017-12-19 03:43:46', 10, 1),
(260, 27808295, NULL, '2018-01-04 12:14:56', 10, 1);

-- --------------------------------------------------------

--
-- 表的结构 `music_singer`
--

CREATE TABLE `music_singer` (
  `gid` int(11) NOT NULL,
  `singer_name` varchar(32) NOT NULL,
  `singer_msg` text NOT NULL,
  `singer_tou` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_songs`
--

CREATE TABLE `music_songs` (
  `id` int(11) NOT NULL,
  `song_name` varchar(32) NOT NULL,
  `song_msg` text NOT NULL,
  `sid` int(11) NOT NULL COMMENT '等于用户uid'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `music_user`
--

CREATE TABLE `music_user` (
  `uid` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `pwd` varchar(32) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '短信和邮箱验证，0为默认，1为通过',
  `undertype` int(1) NOT NULL DEFAULT '0' COMMENT '普通0，管理员为1',
  `role` varchar(32) DEFAULT NULL,
  `del` int(2) NOT NULL DEFAULT '0',
  `tel` varchar(32) DEFAULT NULL,
  `regtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email` varchar(32) DEFAULT NULL,
  `counts` int(32) NOT NULL DEFAULT '100',
  `picture` varchar(300) DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `lock` int(2) NOT NULL DEFAULT '0',
  `words` text,
  `star` text,
  `down` int(32) NOT NULL DEFAULT '0',
  `tou` varchar(100) DEFAULT NULL,
  `sessid` int(32) DEFAULT NULL,
  `di` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_user`
--

INSERT INTO `music_user` (`uid`, `username`, `pwd`, `status`, `undertype`, `role`, `del`, `tel`, `regtime`, `email`, `counts`, `picture`, `ip`, `lock`, `words`, `star`, `down`, `tou`, `sessid`, `di`) VALUES
(8, '大帅', '123456', 1, 3, '普通管理员', 0, '2147483647', '2017-11-16 07:32:08', '111111234@qq.com', 100, '', '128.0.0.1', 0, '', '', 0, '', 0, NULL),
(9, '严凯', '123456', 1, 1, '超级管理员', 0, '17889560345', '2017-11-16 07:32:24', '3198556251@qq.com', 1000, '\\uploads\\20171115/549fc35cd85cdcdc141c135d23c995a9.jpg', '128.0.0.1', 0, '你我山前没相见，山后别相逢', '金牛', 0, 'uploads\\20171106\\42913ce883eabd59f714650cd8241ea8.jpg', 0, '上海'),
(114, '刘德华', '12345678', 1, 0, NULL, 1, '17621143421', '2017-12-21 03:21:52', '1210@we.com', 0, '', '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(10, '肖坤', '123456', 1, 2, '普通管理员', 0, '12345678909', '2017-11-17 02:10:37', '111111234@qq.com', 600, '\\uploads\\20171117/f2ab691d6ec693cff1cac0c9b830f570.jpg', '128.0.0.1', 0, '', '', 0, '', 0, NULL),
(22, '王宝强', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-07 02:59:29', '3198556251@qq.com', 200, '', '128.0.0.1', 0, '', '', 0, '', 0, NULL),
(23, '马蓉', '123456', 0, 0, NULL, 0, '121313654', '2017-11-07 02:59:40', '11111@qq.com', 100, '', '127.0.0.1', 0, '', '', 0, '', 0, NULL),
(24, '猪八戒', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-06 12:51:07', '3198556251@qq.com', 103, '', '103.12.13.15', 0, '', '', 0, 'uploads\\20171106\\cf0c1c5b0fb3437bee7095a0e05df1ae.jpg', 0, NULL),
(25, '孙悟空', '123456', 0, 0, NULL, 0, '153469875', '2017-11-06 12:52:04', '3198556251@qq.com', 300, '', '103.13.62.134', 0, '', '', 0, 'uploads\\20171106\\e1d9d93b90076adb204168197a9d8390.jpg', 0, NULL),
(27, '沙和尚', '123456', 0, 0, NULL, 0, '156987642', '2017-11-09 13:21:47', '3198556251@qq.com', 10365, '', '103.32.32.63', 0, '', '', 0, 'uploads\\20171106\\727177d6999940fccd344ee1d1e4e121.jpg', 0, NULL),
(29, '唐长老', '123456', 0, 0, NULL, 0, '156987563', '2017-11-09 13:22:39', '3198556251@qq.com', 123, '', '102.03.02.33', 0, '', '', 0, 'uploads\\20171106\\062b574ae1273c96b51400d075b52c2e.gif', 0, NULL),
(49, 'woshi', '12345', 1, 0, NULL, 0, '126548', '2017-11-26 01:58:43', 'ykk0214@163.com', 236, '', '10.23.23', 0, '', '', 0, 'uploads\\20171106\\3d46069e48554e14b28dd48559553f92.jpg', 0, NULL),
(50, 'woshi', '12345', 0, 0, NULL, 0, '126548', '2017-11-09 13:22:39', 'ykk0214@163.com', 236, '', '10.23.23', 0, '', '', 0, 'uploads\\20171106\\3bbe2553e85174b9bd2d81c1fd4c06e6.jpg', 0, NULL),
(51, 'wowowo', '123456', 0, 0, NULL, 0, '159863', '2017-11-09 13:22:39', 'ykk0214@163.com', 236, '', '203.321', 0, '', '', 0, 'uploads\\20171106\\62bd3f51937a8db63f854339a8bfda27.jpg', 0, NULL),
(52, 'aa', 'aa', 0, 0, NULL, 0, 'aa', '2017-11-09 13:22:39', 'ykk0214@163.com', 43, '', '10.02.326', 0, '', '', 0, 'uploads\\20171106\\9feb76a99979d212c2c4c512cf7185d6.jpg', 0, NULL),
(84, '窝给你', '123456', 0, 0, NULL, 0, '158963654', '2017-11-09 13:22:39', 'ykk0214@163.com', 123, '', '10.203.02.12', 0, '', '', 0, 'uploads\\20171106\\42913ce883eabd59f714650cd8241ea8.jpg', 0, NULL),
(85, '真成功', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-11 09:00:45', '33333@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(86, '肖大坤', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-11 09:03:45', '33333@qq.com', 0, '', '0.0.0.0', 0, NULL, NULL, 0, NULL, NULL, NULL),
(87, '肖肖坤', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-11 09:04:30', '33333@qq.com', 0, '', '0.0.0.0', 0, NULL, NULL, 0, NULL, NULL, NULL),
(88, '1111', '123456', 0, 0, NULL, 0, '12365478963', '2017-11-11 09:07:54', '33333@qq.com', 0, '', '0.0.0.0', 0, NULL, NULL, 0, NULL, NULL, NULL),
(136, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(135, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(121, '你很拽吗', '123456', 0, 0, NULL, 0, '', '2017-11-15 07:01:39', '111111234@qq.com', 0, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(93, '大求求', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-11 09:39:53', '33333@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(94, '123321', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 05:09:06', '33@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(95, '3666', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 05:47:22', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(96, '123654', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 05:49:34', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(97, '123654', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:08:58', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(98, '123654', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:09:41', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(99, '3939', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:10:46', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(100, '3939', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:11:31', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(101, '3939', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:12:07', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(102, '3939', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:12:28', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(103, '36987', '123456', 0, 0, NULL, 0, '18370841149', '2017-11-12 06:13:01', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(104, '36987', '123456', 0, 0, NULL, 1, '18370841149', '2017-11-13 03:58:16', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(105, '36987', '123456', 0, 0, NULL, 1, '18370841149', '2017-11-13 03:58:16', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(106, '36987', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(107, '36987', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(108, '456987', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(109, '456987', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(110, '456987', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(111, '98745', '123456', 0, 0, NULL, 1, '15570125494', '2017-12-21 03:21:52', '336@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(112, '大咪咪', '123456', 0, 0, NULL, 1, '15570125494', '2017-12-21 03:21:52', '33333@qq.com', 0, '', '0.0.0.0', 0, NULL, NULL, 0, NULL, NULL, NULL),
(113, '大幂幂', '123456', 0, 0, NULL, 1, '15570125494', '2017-12-21 03:21:52', '33333@qq.com', 0, '', NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(118, 'nihao', '123456', 0, 0, NULL, 0, '', '2017-11-15 08:42:47', '12121@11.com', 0, '', '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(116, '王八蛋', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:52', '33333@qq.com', 0, '', '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(117, 'nihao ', '123456', 0, 0, NULL, 0, '', '2017-11-15 08:42:50', '1210450122@qq.com', 0, '', '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(119, '刘德华', '11111111', 0, 0, NULL, 0, '', '2017-11-15 06:20:07', '123456@11.com', 0, '', '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(120, '刘德华', '11111111', 0, 0, NULL, 0, '', '2017-11-15 06:20:33', '1210450122@qq.com', 0, '', '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(124, '我就不', '123456', 0, 0, NULL, 0, '', '2017-11-15 07:26:54', '111111234@qq.com', 0, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL),
(125, 'yankai', '111111', 0, 0, NULL, 1, '', '2017-11-15 08:03:38', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(126, 'yankai', '111111', 0, 0, NULL, 1, '111111111111', '2017-11-15 08:03:38', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(127, 'yankai', '11111111111', 0, 0, NULL, 0, '17621143421', '2017-11-15 07:29:16', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(128, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(129, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(130, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(131, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(132, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(133, 'aohan ', '123456', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(134, 'aohan ', '111111', 0, 0, NULL, 1, '17621143421', '2017-11-15 08:03:31', '1210450122@qq.com', 0, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(137, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(138, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(139, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(140, '小凯凯', '123456', 0, 0, NULL, 1, '18370841149', '2017-12-21 03:21:35', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(141, '肖坤坤', '1111111111', 1, 0, NULL, 1, '18370841149', '2017-11-17 03:04:03', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(142, '中国人', '123456', 1, 0, NULL, 1, '17621143421', '2017-11-17 03:04:03', 'm17621143421@163.com', 100, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(143, 'yykk', '123456', 1, 0, NULL, 1, '18370841149', '2017-11-17 03:04:03', 'ykk0214@163.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(148, '我是肖坤的爹', 'xcp12345', 0, 0, NULL, 0, '15952036127', '2018-03-22 17:36:42', '941376514@qq.com', 100, NULL, '49.77.240.33', 0, NULL, NULL, 0, NULL, NULL, NULL),
(145, 'chuanchuan', '1234567', 0, 0, NULL, 0, '15879008817', '2017-11-17 09:25:31', 'yc960120@qq.com', 100, NULL, '211.95.6.66', 0, NULL, NULL, 0, NULL, NULL, NULL),
(146, 'asd1', 'xcp123456', 0, 0, NULL, 0, '17621774448', '2017-12-19 03:47:21', '941376514@qq.com', 100, NULL, '58.247.72.250', 0, NULL, NULL, 0, NULL, NULL, NULL),
(147, '葱葱啊', '123456', 1, 0, NULL, 0, '18370841149', '2017-12-21 03:16:01', '3198556251@qq.com', 100, '\\uploads\\20171221/430ee055260cb61081f8f7ebf31f63ae.jpg', '42.199.53.79', 0, NULL, NULL, 0, NULL, NULL, NULL),
(149, 'kyle', '123456', 1, 0, NULL, 0, '18370841149', '2018-03-30 11:04:02', '3198556251@qq.com', 100, NULL, '113.65.14.12', 0, NULL, NULL, 0, NULL, NULL, NULL),
(150, '嘉俊123', '123456', 1, 0, NULL, 0, '18826227981', '2018-03-30 11:03:58', '853348419@qq.com', 100, NULL, '113.65.14.12', 0, NULL, NULL, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `music_xiang`
--

CREATE TABLE `music_xiang` (
  `xid` int(11) NOT NULL,
  `addressState` int(11) NOT NULL COMMENT '收货地址',
  `pay_id` varchar(50) NOT NULL COMMENT '支付方式',
  `shipment_id` varchar(50) NOT NULL COMMENT '免配送',
  `best_time` varchar(50) DEFAULT NULL COMMENT '配送时间1周一到周日2周一到周五3周六到周日',
  `invoice` varchar(50) DEFAULT NULL COMMENT '电子发票',
  `invoice_type` varchar(50) DEFAULT NULL COMMENT '个人、单位发票1个人2单位',
  `invoice_title` varchar(50) DEFAULT NULL COMMENT '单位名称',
  `couponsType` varchar(50) DEFAULT NULL,
  `couponsValue` varchar(50) DEFAULT NULL,
  `liuyan` varchar(100) DEFAULT NULL,
  `hid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `ddan` varchar(50) NOT NULL COMMENT '订单号',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dizhi` varchar(23) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `music_xiang`
--

INSERT INTO `music_xiang` (`xid`, `addressState`, `pay_id`, `shipment_id`, `best_time`, `invoice`, `invoice_type`, `invoice_title`, `couponsType`, `couponsValue`, `liuyan`, `hid`, `uid`, `ddan`, `addtime`, `dizhi`) VALUES
(5, 0, 'jpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111314298', '2017-11-13 12:21:59', ''),
(6, 0, 'jpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111314298', '2017-11-13 12:25:15', ''),
(7, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111377701', '2017-11-13 12:32:38', ''),
(8, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111377701', '2017-11-13 12:33:05', ''),
(9, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111342587', '2017-11-13 12:33:22', ''),
(10, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111342587', '2017-11-13 12:35:49', ''),
(11, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111313603', '2017-11-13 13:14:49', ''),
(12, 0, 'zpy', 'pei', '2', '4', '4', '', '', '', '', 2, 12, '', '2017-11-13 13:36:08', ''),
(13, 0, 'zpy', 'pei', '2', '4', '4', '', '', '', 'hello ', 2, 12, '2017111302993', '2017-11-13 13:41:20', ''),
(14, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 12, '2017111339393', '2017-11-13 13:52:46', ''),
(15, 0, 'zpy', 'pei', '1', '1', '1', '', '', '', '', 2, 12, '2017111383953', '2017-11-13 13:55:49', ''),
(22, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 1, 13, '2017111444208', '2017-11-14 01:58:42', '18'),
(25, 1, 'zpy', 'pei', '1', '4', '4', '', '', '', '', 2, 144, '2017111702982', '2017-11-17 02:33:48', '21'),
(24, 1, 'zpy', 'pei', '1', '4', '4', '', '', '', '大撒旦撒撒撒', 1, 141, '2017111657533', '2017-11-16 11:35:18', '20'),
(26, 0, 'zpy', 'pei', '1', '4', '4', '', '', '', '创新宣传宣传 ', 2, 10, '2017111729904', '2017-11-17 02:54:45', '19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `music_admin`
--
ALTER TABLE `music_admin`
  ADD PRIMARY KEY (`xid`);

--
-- Indexes for table `music_bolg`
--
ALTER TABLE `music_bolg`
  ADD PRIMARY KEY (`oid`),
  ADD KEY `oid` (`oid`);

--
-- Indexes for table `music_category`
--
ALTER TABLE `music_category`
  ADD PRIMARY KEY (`qid`);

--
-- Indexes for table `music_category_right`
--
ALTER TABLE `music_category_right`
  ADD PRIMARY KEY (`qid`);

--
-- Indexes for table `music_category_right_song`
--
ALTER TABLE `music_category_right_song`
  ADD PRIMARY KEY (`vid`);

--
-- Indexes for table `music_category_song`
--
ALTER TABLE `music_category_song`
  ADD PRIMARY KEY (`vid`);

--
-- Indexes for table `music_class`
--
ALTER TABLE `music_class`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `music_ding`
--
ALTER TABLE `music_ding`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `music_gedan`
--
ALTER TABLE `music_gedan`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `aid` (`aid`);

--
-- Indexes for table `music_geshou`
--
ALTER TABLE `music_geshou`
  ADD PRIMARY KEY (`oid`),
  ADD KEY `oid` (`oid`);

--
-- Indexes for table `music_hotsiner`
--
ALTER TABLE `music_hotsiner`
  ADD PRIMARY KEY (`hid`),
  ADD KEY `hid` (`hid`);

--
-- Indexes for table `music_link`
--
ALTER TABLE `music_link`
  ADD PRIMARY KEY (`lid`);

--
-- Indexes for table `music_mail`
--
ALTER TABLE `music_mail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `music_mv`
--
ALTER TABLE `music_mv`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `music_person`
--
ALTER TABLE `music_person`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `music_pinlun`
--
ALTER TABLE `music_pinlun`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `music_shop`
--
ALTER TABLE `music_shop`
  ADD PRIMARY KEY (`hid`),
  ADD KEY `hid` (`hid`);

--
-- Indexes for table `music_shou`
--
ALTER TABLE `music_shou`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `music_singer`
--
ALTER TABLE `music_singer`
  ADD PRIMARY KEY (`gid`);

--
-- Indexes for table `music_user`
--
ALTER TABLE `music_user`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `music_xiang`
--
ALTER TABLE `music_xiang`
  ADD PRIMARY KEY (`xid`),
  ADD KEY `xid` (`xid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `music_admin`
--
ALTER TABLE `music_admin`
  MODIFY `xid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `music_bolg`
--
ALTER TABLE `music_bolg`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- 使用表AUTO_INCREMENT `music_category`
--
ALTER TABLE `music_category`
  MODIFY `qid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- 使用表AUTO_INCREMENT `music_category_right`
--
ALTER TABLE `music_category_right`
  MODIFY `qid` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `music_category_right_song`
--
ALTER TABLE `music_category_right_song`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- 使用表AUTO_INCREMENT `music_category_song`
--
ALTER TABLE `music_category_song`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
--
-- 使用表AUTO_INCREMENT `music_class`
--
ALTER TABLE `music_class`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `music_ding`
--
ALTER TABLE `music_ding`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- 使用表AUTO_INCREMENT `music_gedan`
--
ALTER TABLE `music_gedan`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
--
-- 使用表AUTO_INCREMENT `music_geshou`
--
ALTER TABLE `music_geshou`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=602;
--
-- 使用表AUTO_INCREMENT `music_hotsiner`
--
ALTER TABLE `music_hotsiner`
  MODIFY `hid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- 使用表AUTO_INCREMENT `music_link`
--
ALTER TABLE `music_link`
  MODIFY `lid` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `music_mail`
--
ALTER TABLE `music_mail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `music_mv`
--
ALTER TABLE `music_mv`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `music_person`
--
ALTER TABLE `music_person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `music_pinlun`
--
ALTER TABLE `music_pinlun`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- 使用表AUTO_INCREMENT `music_shop`
--
ALTER TABLE `music_shop`
  MODIFY `hid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `music_shou`
--
ALTER TABLE `music_shou`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;
--
-- 使用表AUTO_INCREMENT `music_singer`
--
ALTER TABLE `music_singer`
  MODIFY `gid` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `music_user`
--
ALTER TABLE `music_user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;
--
-- 使用表AUTO_INCREMENT `music_xiang`
--
ALTER TABLE `music_xiang`
  MODIFY `xid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
