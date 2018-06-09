<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>政务信息 </title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${category.description}" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta name="keywords" content="${category.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<!--  --><!-- <script type="text/javascript">
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
<body style="background: #ffffff">
  <table class="am-table">
    <tbody>
	    <c:if test="${category.module eq 'article'}">
					<c:forEach items="${page.list}" var="article">
		   		     <tr>
						<td><a href="${article.url}" style="color:${article.color}" class="">${fns:abbr(article.title,96)}</a></td>
					</tr>
					</c:forEach>
				</c:if>
    </tbody>
</table>

	<%-- <div class="jeemicro_mian">
		<div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<!-- <div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>
                
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div> -->
				<h1 class="am-header-title">
		          <a href="#title-link" class="">
		           ${category.name}
		          </a>
		      </h1>
			</header>
		</div>


		<div class="jeemicro_content jeemicro_content_list">
			<div class="jeemicro_article_like">
				<div class="jeemicro_content_main jeemicro_article_like_delete">
					<div data-am-widget="list_news"
						class="am-list-news am-list-news-default am-no-layout">
						<div class="am-list-news-bd">
							<ul class="am-list">
								<!--缩略图在标题右边-->

								<c:if test="${category.module eq 'article'}">
									<c:forEach items="${page.list}" var="article">
										<li
											class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right jeemicro_list_one_block">
											<div class="jeemicro_list_one_info">
												<div class="jeemicro_list_one_info_l"></div>
												<div class="jeemicro_list_one_info_r">
												 <div class="jeemicro_list_tag jeemicro_list_tag_xxs">${category.name}</div>
												</div>
											</div>
											
											<div class=" am-u-sm-8 am-list-main jeemicro_list_one_nr">
												<h3 class="am-list-item-hd jeemicro_list_one_bt">
													<a href="${article.url}" style="color:${article.color}" class="">${fns:abbr(article.title,96)}</a>
												</h3>
												<div class="am-list-item-text jeemicro_list_one_text">${fns:abbr(article.description,96)}</div>
											</div>
											<div class="am-u-sm-4 am-list-thumb">
												<a href="${article.url}" class=""> <img
													src="${article.imageSrc}" class="jeemicro_list_one_img" alt="" />
												</a>
											</div>
										</li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
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
	</script> --%>
</body>
</html>