<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>员工查询</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="MYMT ${site.description}" />
<meta name="keywords" content="MYMT ${site.keywords}" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<style type="text/css">
</style>
</head>
<body style="background: #ececec">
	<div class="jeemicro_mian">
		<div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>

				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div>
			</header>
		</div>
		<br />
		<br />
		<form:form id="inputForm" action="${ctx}/search" method="post"
			class="form-horizontal">

			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">手机号：</span> <input type="text"
					id="phone" name="phone" style="width: 100%;"
					class="am-form-field required">
			</div>

			<div class="am-margin-top">
				<input id="submitButton" class="am-btn am-btn-primary am-btn-block"
					style="width: 100%;" type="submit" value="查 询" />
			</div>
		</form:form>

		<div class="jeemicro_content jeemicro_content_list">
			<div class="jeemicro_article_like">
				<div class="jeemicro_content_main jeemicro_article_like_delete">
					<div data-am-widget="list_news"
						class="am-list-news am-list-news-default am-no-layout">
						<div class="am-list-news-bd">

							<table class="jeemicrotable" width="100%">
								<tr>
									<th style="text-align: center;">姓名</th>
									<th style="text-align: center;">手机号</th>
									<th style="text-align: center;">职务</th>
									<th style="text-align: center;">照片</th>
								</tr>
								<c:forEach items="${page}" var="article">
									<tr>
										<td style="text-align: center;">${article.username}</td>
										<td style="text-align: center;"><a
											href="tel:${fns:abbr(article.phone,96)}" class="">${fns:abbr(article.phone,96)}</a></td>
										<td style="text-align: center;">${fns:abbr(article.zhiwu,96)}</td>
										<td style="text-align: center;"><img
											src="${ctxGen}${article.picture}" width="160px"
											height="200px" class="jeemicro_list_one_img" alt="" /></td>
									</tr>
								</c:forEach>

							</table>
							<c:if test="${fn:length(page) eq '0'}">
								<a href="###">
									<button type="button" id="Button1"
										class="am-btn am-btn-danger am-btn-default am-u-sm-centered ">
										此电话非我公司正式员工电话，请谨防上当<br /> 您可拨打010-8888888进行咨询
									</button>
								</a>
							</c:if>
							<div class="jeemicro_article_footer_info">Copyright(c)2017
								By MYMT</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
</body>
</html>