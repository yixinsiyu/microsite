<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="MYMT ${site.description}" />
<meta name="keywords" content="MYMT ${site.keywords}" />
<link type="text/css" rel="stylesheet"
	href="${ctxStatic}/front/css/amazeui.min.css">
<link type="text/css" rel="stylesheet"
	href="${ctxStatic}/front/css/wap.css?2">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/style.css" />
<script type="text/javascript" src="${ctxStatic}/js/zepto_min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/touchslider.js"></script>
<!-- <script type="text/javascript">
    // 对浏览器的UserAgent进行正则匹配，不含有微信独有标识的则为其他浏览器
    var useragent = navigator.userAgent;
    if (useragent.match(/MicroMessenger/i) != 'MicroMessenger') {
        // 这里警告框会阻塞当前页面继续加载
        alert('已禁止本次访问：您必须使用微信内置浏览器访问本页面！');
        // 以下代码是用javascript强行关闭当前页面
        var opened = window.open('about:blank', '_self');
        opened.opener = null;
        opened.close();
    }
</script> -->
</head>
<body>
	<div data-am-widget="gotop" class="am-gotop am-gotop-fixed">
		<a href="#top" title=""> <img class="am-gotop-icon-custom"
			src="${ctxStatic}/front/img/goTop.png" />
		</a>
	</div>
	<div class="jeemicro_mian" id="top">
		<div data-am-widget="slider" class="am-slider am-slider-a1"
			data-am-slider='{"directionNav":false}'>
			<ul class="am-slides">
				<li><img src="${ctxStatic}/front/img/ajzt">
					<div class="jeemicro_slider_font">
						<span>安监专题</span>
					</div>
					<div class="jeemicro_slider_shadow"></div></li>
			</ul>
		</div>
      
		<div class="jeemicro_circle_nav">
			<ul class="jeemicro_circle_nav_list">
			   
				<li><a href="${ctx}/baoming${urlSuffix}" class="iconfont jeemicro_nav_baoming">&#xe612;</a><span>在线报名</span></li>
				
				<li><a href="${ctx}/register" class="iconfont jeemicro_nav_qidai ">&#xe6aa;</a><span>会员注册</span></li>
				<%-- <li><a href="${ctx}/list-10${urlSuffix}"
					class="iconfont jeemicro_nav_gongsijieshao ">&#xe602;</a><span>安全动态</span></li>
				<li><a href="${ctx}/list-8${urlSuffix}"
					class="iconfont jeemicro_nav_qiyezizhi ">&#xe9b0;</a><span>安全常识</span></li>
				<li><a href="${ctx}/list-3${urlSuffix}"
					class="iconfont jeemicro_nav_gongsixinwen ">&#xe643;</a><span>队伍建设</span></li>
				<li><a href="${ctx}/list-11${urlSuffix}"
					class="iconfont jeemicro_nav_lianxiwomen ">&#xe608;</a><span>法律法规</span></li> --%>
				<%-- <li><a href="${ctx}/list-7${urlSuffix}"
					class="iconfont jeemicro_nav_dianxingkehu ">&#xe600;</a><span>电子杂志</span></li>
				<li><a href="${ctx}/list-9${urlSuffix}"
					class="iconfont jeemicro_nav_shouhoufuwu ">&#xe6cc;</a><span>售后服务</span></li>
				<li><a href="${ctx}/list-12${urlSuffix}"
					class="iconfont jeemicro_nav_caiwuxinxi ">&#xe62c;</a><span>财务信息</span></li>
				<li><a href="${ctx}/list-6${urlSuffix}"
					class="iconfont jeemicro_nav_kehutongzhi ">&#xe67c;</a><span>客户通知</span></li>
				<li><a href="${ctx}/search${urlSuffix}"
					class="iconfont jeemicro_nav_yuangong ">&#xe605;</a><span>员工查询</span></li>
				<li><a href="${ctx}/guestbook${urlSuffix}"
					class="iconfont jeemicro_nav_message ">&#xe64d;</a><span>留言列表</span></li>
				<li><a href="${ctx}/list-13${urlSuffix}"
					class="iconfont jeemicro_nav_baoming">&#xe612;</a><span>在线报名</span></li>
				<li><a href="${ctx}/baoming${urlSuffix}" class="iconfont jeemicro_nav_baoming">&#xe612;</a><span>在线报名</span></li>
				<li><a
					href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx07673552a84e337f&redirect_uri=http://www.asyy.club/f/register&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect"
					class="iconfont jeemicro_nav_qidai ">&#xe6aa;</a><span>会员中心</span></li>
				<li><a href="${ctx}/register" class="iconfont jeemicro_nav_qidai ">&#xe6aa;</a><span>会员注册</span></li>
			</ul> --%>
		</div>
		
		<div class="jeemicro_article_dowload jeemicro_dowload_more_top_off">
			<div class="jeemicro_article_dowload_title">关于MYMT</div>
			<div class="jeemicro_article_dowload_content jeemicro_dowload_more_top_bg">
				<div class="jeemicro_article_dowload_triangle jeemicro_dowload_more_top_san"></div>
				<div class="jeemicro_article_dowload_ico">
					<img src="${ctxStatic}/front/img/footdon.png" alt="">
				</div>
				<div class="jeemicro_article_dowload_content_font">
					我们的目标：成为受人敬仰的软件服务提供商。 我们的价值观：帮助顾客成功，成就自我。</div>
				<div class="jeemicro_article_dowload_all">
					<a href="###" class="jeemicro_article_dowload_Az am-icon-apple">微信平台</a>
				</div>
			</div>
			<div class="jeemicro_article_footer_info">Copyright(c)2017 By MYMT</div>
		</div>
	</div>

	<script src="${ctxStatic}/front/js/jquery.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"
		type="text/javascript"></script>
	<script>
		$(function() {
			// 动态计算新闻列表文字样式
			auto_resize();
			$(window).resize(function() {
				auto_resize();
			});
			$('.am-list-thumb img').load(function() {
				auto_resize();
			});

			$('.am-list > li:last-child').css('border', 'none');
			function auto_resize() {
				$('.jeemicro_list_one_nr').height($('.jeemicro_list_one_img').height());

			}
		});
	</script>
</body>
</html>