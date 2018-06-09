<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>在线报名</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="ZMRID ${site.description}" />
<meta name="keywords" content="ZMRID ${site.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<!-- <script type="text/javascript">
	$(document).ready(function() {
		//alert(getQueryString("allmoney"));
		if(getQueryString("articleTitle")!=null && getQueryString("articleTitle")!=''){
			var unicode = BASE64.decoder(getQueryString("articleTitle"))
			var str = '';  
			for(var i = 0 , len =  unicode.length ; i < len ;++i){  
			      str += String.fromCharCode(unicode[i]);  
			}  
			$("#huodong").val(str);
		};
	});
	function getQueryString(name) { 
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
		var r = window.location.search.substr(1).match(reg); 
		if (r != null) return unescape(r[2]); return null; 
	};
</script> -->
</head>

<body style="background: #ececec">
	<div class="jeemicro_mian">
		<div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>
				<div class="jeemicro_news_list_tag_name">报名列表</div>
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div>
			</header>
		</div>
		<br/><br/><br/>
		<form:form id="inputForm" action="${ctx}/baoming" method="post" class="form-horizontal" >
			
			<div class="am-margin-top am-input-group">
			  <span class="am-input-group-label">姓名：</span>
			  <input type="text" id="name" name="name" style="width: 100%;" class="am-form-field required" >
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
				<span class="am-input-group-label">活动：</span>
				<input type="text" id="huodong" name="huodong" style="width: 100%;" class="am-form-field required">
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
		
			<div class="jeemicro_article_footer_info">Copyright(c)2017 By MYMT</div>
		</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/jbase64.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
	<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			if(getQueryString("articleTitle")!=null && getQueryString("articleTitle")!=''){
				var unicode = BASE64.decoder(getQueryString("articleTitle"))
				var str = '';  
				for(var i = 0 , len =  unicode.length ; i < len ;++i){  
				      str += String.fromCharCode(unicode[i]);  
				}  
				$("#huodong").val(str);
			};
			
			<c:if test="${not empty message}">alert("${message}");</c:if>
			$("#inputForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					content: {required: "请填写报名内容"},
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
				$(this).toggleClass("active", $(this).text().indexOf('公共报名')>=0);
			});
		});
		function page(n,s){
			location="${ctx}/baoming?pageNo="+n+"&pageSize="+s;;
		}
		
		function getQueryString(name) { 
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
			var r = window.location.search.substr(1).match(reg); 
			if (r != null) return unescape(r[2]); return null; 
		};
	</script>
</body>
</html>