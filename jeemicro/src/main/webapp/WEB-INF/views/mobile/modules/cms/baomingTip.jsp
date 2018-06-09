<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>会员注册</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="MYMT ${site.description}" />
<meta name="keywords" content="MYMT ${site.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<script type="text/javascript">
	$(document).ready(function() {
		//var flag = false;
		$("#send").click(function() {
			var mobile = document.getElementById("mobile").value;
			if (mobile == '') {
				alert("请输入手机号！");
				return false;
			}
			time(this);
			$("#send").attr("disabled", true);
			$.ajax({
				type : "POST",
				url : "${ctx}/../f/register/send",
				data : $("#inputForm").serialize(),
				success : function(msg) {
				}
			});
		});
	});
</script>
<script type="text/javascript">
	var wait = 60;
	function time(o) {
		if (wait == 0) {
			o.removeAttribute("disabled");
			o.value = "免费获取验证码";
			wait = 60;
		} else {
			o.setAttribute("disabled", true);
			o.value = "重新发送(" + wait + ")";
			wait--;
			setTimeout(function() {
				time(o)
			}, 1000)
		}
	}
</script>
</head>

<body>
<div class="am-panel am-panel-default">
 <header data-am-widget="header" class="am-header am-header-default">
	  <div class="am-header-left am-header-nav">
	    <a href="http://www.xbwls.com/jeemicro/a" class="">
	      <span class="am-header-nav-title">首页</span>
	      <i class="am-header-icon am-icon-home"></i>
	    </a>
	  </div>
	  <h1 class="am-header-title"></h1>
	 
</header>
  <div class="am-panel-hd">注册注意事项</div>
  <div class="am-panel-bd">
    <ul>
      <li>孩子姓名 ：  拟入学儿童姓名（如果是双胞胎只预约一个号即可2个人用一个号同时参加审核,请在名字后加个数字2如张雪2）
      </li>
      <li>孩子身份证号：（请务必填写准确，否则无法办理入学手续）</li>
      <li>详细地址：示例：冷泉西北街244号或友谊家园2区3单元201</li>
      <li>房东姓名：一定要填写产权人，不是代理人姓名</li>
      <li>房东电话：有手机不要填座机</li>
      <li>第一监护人姓名：必须是法定监护人之一</li>
      <li>第二监护人电话2：单亲家庭这里填写数字01234567890</li>
      <!-- <li>预约后可以撤销但是需要在审核当天前48小时，超时不能取消，爽约不能再次预约</li> -->
      <li>请家长按照预约的时间地点带齐五证原件及复印件与房东一起到审核现场参加联审。审核日早9点前48小时前可以撤销预约。已经预约不按时参加审核的不能再次预约。迟到的家长请在门卫处报道，服从门卫安排延时或延期参加审核。有问题联系QQ2207122695及QQ群206026111或电话82403933、50916767-6726
      </li>
    </ul>
  </div>
</div>

</body>
</html>