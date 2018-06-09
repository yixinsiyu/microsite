<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${article.title}- ${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description"
	content="${article.description} ${category.description}" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta name="keywords" content="${article.keywords} ${category.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<!-- <link rel="stylesheet" type="text/css" href="../css/main.css" /> -->
<link rel="stylesheet" type="text/css" href="${ctxStatic}/style.css" />
<script type="text/javascript" src="${ctxStatic}/js/zepto_min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/touchslider.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				if ("${category.allowComment}" == "1"
						&& "${article.articleData.allowComment}" == "1") {
					$("#comment").show();
					page(1);
				}
			});
	function page(n, s) {
		$.get("${ctx}/comment", {
			theme : '${site.theme}',
			'category.id' : '${category.id}',
			contentId : '${article.id}',
			title : '${article.title}',
			pageNo : n,
			pageSize : s,
			date : new Date().getTime()
		}, function(data) {
			$("#comment").html(data);
		});
	}
</script>
</head>
<body style="background: #ececec">
	<div class="jeemicro_mian">
		<!-- <div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="javascript:;" class="iconfont jeemicro_head_jt_ico" onclick="window.history.go(-1);">&#xe601;</a>
				</div>
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico" >&#xe634;</a>
				</div>
			</header>
		</div> -->

		<div class="jeemicro_content">
			<div class="jeemicro_content_block">
				<article data-am-widget="paragraph"
					class="am-paragraph am-paragraph-default jeemicro_content_article"
					data-am-paragraph="{ tableScrollable: true, pureview: true }">
					<h1 class="jeemicro_article_title">${article.title}</h1>
					<div class="jeemicro_article_user_time">
						发表于：
						<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd" />
					</div>
					<c:if test="${not empty article.description}">
						<div>摘要：${article.description}</div>
					</c:if>
					<div>${article.articleData.content}</div>
				</article>
				<ul class="like_share_block">
					<li><a class="link_share_button" href="###"><i
							class="iconfont share_ico_wx">&#xe83e;</i>阅读数：${article.hits}</a></li>
				</ul>
				<%-- <div class="jeemicro_article_dowload">
					<div class="jeemicro_article_dowload_title">关于ZMRID</div>
					<div class="jeemicro_article_dowload_content">
						<div class="jeemicro_article_dowload_triangle"></div>
						<div class="jeemicro_article_dowload_ico">
							<img src="${ctxStatic}/front/img/footdon.png" alt="">
						</div>
						<div class="jeemicro_article_dowload_content_font">
							我们的目标：成为受人敬仰的管理软件服务提供商。 我们的价值观：帮助客户成功，成就自我。</div>
						<div class="jeemicro_article_dowload_all">
							<a href="###" class="jeemicro_article_dowload_Az am-icon-apple">微信平台</a>
						</div>
					</div>
				</div> --%>
			</div>


			<!-- <div class="jeemicro_article_footer_info">Copyright(c)2017 By
				ZMRID</div> -->
		</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
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
			$('.jeemicro_article_like li:last-child').css('border', 'none');
			function auto_resize() {
				$('.jeemicro_list_one_nr').height($('.jeemicro_list_one_img').height());
				// alert($('.jeemicro_list_one_nr').height());
			}
			$('.jeemicro_article_user')
					.on(
							'click',
							function() {
								if ($('.jeemicro_article_user_info_tab').hasClass(
										'jeemicro_article_user_info_tab_show')) {
									$('.jeemicro_article_user_info_tab')
											.removeClass(
													'jeemicro_article_user_info_tab_show')
											.addClass(
													'jeemicro_article_user_info_tab_cloes');
								} else {
									$('.jeemicro_article_user_info_tab')
											.removeClass(
													'jeemicro_article_user_info_tab_cloes')
											.addClass(
													'jeemicro_article_user_info_tab_show');
								}
							});

			$('.jeemicro_head_gd_ico').on('click', function() {
				$('.jeemicro_more_list').addClass('jeemicro_more_list_show');
			});
			$('.jeemicro_more_close').on('click', function() {
				$('.jeemicro_more_list').removeClass('jeemicro_more_list_show');
			});
		});
	</script>
</body>
</body>
</html>