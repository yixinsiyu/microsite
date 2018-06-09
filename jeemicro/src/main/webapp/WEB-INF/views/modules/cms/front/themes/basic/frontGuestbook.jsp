<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>留言列表</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="MYMT ${site.description}" />
<meta name="keywords" content="MYMT ${site.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
</head>

<body style="background: #ececec">
	<div class="jeemicro_mian">
		<div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>
				<div class="jeemicro_news_list_tag_name">留言列表</div>
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div>
			</header>
		</div>
		<br/><br/>
		<form:form id="inputForm" action="${ctx}/guestbook" method="post" class="form-horizontal" >
			
			<div class="am-margin-top am-input-group">
			  <span class="am-input-group-label">姓名：</span>
			  <input type="text" id="name" name="name" style="width: 100%;" class="am-form-field required" >
			</div>
			<div class="am-margin-top am-input-group">
			  <span class="am-input-group-label">邮箱：</span>
			  <input type="text" id="email" name="email" style="width: 100%;" class="am-form-field required email">
			</div>
			<div class="am-margin-top am-input-group">
			  <span class="am-input-group-label">电话：</span>
			  <input type="text" id="phone" name="phone" style="width: 100%;" class="am-form-field required phone">
			</div>
			<div class="am-margin-top am-input-group">
			  <span class="am-input-group-label">单位：</span>
			  <input type="text" id="workunit" name="workunit" style="width: 100%;" class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">分类：</span>
					<select id="type" name="type" data-am-selected="{btnStyle: 'primary'}" class="required" style="width: 100%;">
						<option value="">请选择</option>
						<c:forEach items="${fns:getDictList('cms_guestbook')}" var="type">
							<option value="${type.value}">${type.label}</option>
						</c:forEach>
					</select>
			</div>
			<div class="am-margin-top am-input-group">
			  	<span class="am-input-group-label">内容：</span>
			 	<textarea name="content" rows="4" maxlength="200" id="content" class="required" style="width:100%;"></textarea>
			</div>
			
			<div class="am-margin-top">
				<input id="submitButton" class="am-btn am-btn-primary am-btn-block" style="width:100%;" type="submit" value="提 交" />
			</div>
			<div id="messageBox" class="alert alert-error" style="display: none">输入有误，请先更正。</div>
		</form:form>
		<div class="jeemicro_content jeemicro_content_list jeemicro_hd">
			<div class="jeemicro_article_like">
				<div class="jeemicro_content_main jeemicro_article_like_delete">
					<div data-am-widget="list_news"
						class="am-list-news am-list-news-default am-no-layout">
						<div class="am-list-news-bd">
							<ul class="am-list">
								<!--缩略图在标题右边-->
								<c:forEach items="${page.list}" var="guestbook">
									<li
										class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right jeemicro_hd_list">
										<a href="###" class="jeemicro_hd_block">
											<div class="jeemicro_hd_block_title">
												姓名: ${guestbook.name} &nbsp;时间：
												<fmt:formatDate value="${guestbook.createDate}"
													pattern="yyyy-MM-dd" />
											</div>
											<div class="jeemicro_hd_block_map">
												<i class="iconfont">&#xe6aa;</i>内容：${guestbook.content}
											</div>
											<div class="jeemicro_hd_block_tag">
												<span class="hd_tag_jh">回复:</span><br/>回复人：${guestbook.reUser.name}
												时间：
												<fmt:formatDate value="${guestbook.reDate}"
													pattern="yyyy-MM-dd" />
											</div>
											<div class="jeemicro_hd_block_tag">回复内容：${guestbook.reContent}</div>
									</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="jeemicro_article_footer_info">Copyright(c)2017 By MYMT</div>
		</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
	<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			<c:if test="${not empty message}">alert("${message}");</c:if>
			$("#inputForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					content: {required: "请填写留言内容"},
					validateCode: {remote: "验证码不正确"}
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			$("#main_nav li").each(function(){
				$(this).toggleClass("active", $(this).text().indexOf('公共留言')>=0);
			});
		});
		function page(n,s){
			location="${ctx}/guestbook?pageNo="+n+"&pageSize="+s;;
		}
		
	</script>
</body>
</html>