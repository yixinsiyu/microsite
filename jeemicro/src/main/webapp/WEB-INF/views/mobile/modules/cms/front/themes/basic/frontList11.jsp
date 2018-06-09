<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${category.description}" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta name="keywords" content="${category.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<script>
  $(function() {
   $('#doc-my-tabs').find('a').on('open.tabs.amui', function(e) {
      if(e.target.pathname.indexOf("[data-tab-panel-0]")>0){
               window.location.href="http://www.xbwls.com/jeemicro/f/list-10.html";
       }else if(e.target.pathname.indexOf("[data-tab-panel-1]")>0){
           window.location.href="http://www.xbwls.com/jeemicro/f/list-3.html";
       }else if(e.target.pathname.indexOf("[data-tab-panel-2]")>0){
           window.location.href="http://www.xbwls.com/jeemicro/f/list-12.html";
       }else{
           window.location.href="http://www.xbwls.com/jeemicro/f/list-8.html";
       }
   
  
})
  })
</script>
</head>
<body style="background: #ececec">
<img src="${ctxStatic}/images/430a49c111-64e5-40f8-9362-182dc30a2723.jpg" alt="..." class="am-radius">
  <div data-am-widget="tabs" class="am-tabs am-tabs-default" id="doc-my-tabs">
     <ul class="am-tabs-nav am-cf">
	  <li class=""><a href="[data-tab-panel-0]">安全动态</a></li>
	  <li class=""><a href="[data-tab-panel-1]">安全常识</a></li>
	  <li class="am-active"><a href="[data-tab-panel-2]">队伍建设</a></li>
	  <li class=""><a href="[data-tab-panel-3]">法律法规</a></li>
   </ul>
   </div>
	<div class="jeemicro_mian">
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
												<div class="jeemicro_list_one_info_r"></div>
											</div>
											<div class="am-u-sm-4 am-list-thumb">
												<a href="${article.url}" class=""> <img
													src="${article.imageSrc}" class="jeemicro_list_one_img" alt="" />
												</a>
											</div>
											<div class=" am-u-sm-8 am-list-main jeemicro_list_one_nr">
												<h3 class="am-list-item-hd jeemicro_list_one_bt">
													<a href="${article.url}" style="color:${article.color}" class="">${fns:abbr(article.title,96)}</a>
												</h3>
												<div class="am-list-item-text jeemicro_list_one_text">${fns:abbr(article.description,96)}</div>
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
	</script>
</body>
</html>