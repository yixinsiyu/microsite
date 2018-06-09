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
		// 身份证号码验证
	    jQuery.validator.addMethod("cardnum", function(value, element) { 
	      //var idCard = /^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/;   
	      return this.optional(element) || isIdCardNo(value);    
	    }, "请输入正确的身份证号码。"); 

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
	
	function validate() {  
	    var pwd1 = document.getElementById("password").value;  
	    var pwd2 = document.getElementById("password1").value;  
	    if(pwd1 == pwd2) {  
	        document.getElementById("tishi").innerHTML="<font color='gray'>输入正确</font>";  
	/*         $("#tishi").hide(1500); */  
	        document.getElementById("submit").disabled = false;  
	    }  
	    else {  
	      document.getElementById("tishi").innerHTML="<font color='red'>两次密码不相同</font>";  
	      document.getElementById("submit").disabled = true;  
	    }  
	}  
</script>
</head>

<body>
	<div class="jeemicro_mian">
		<!-- <div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>
				<div class="jeemicro_news_list_tag_name">注册</div>
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div>
			</header>
		</div> -->
		<img src="${ctxStatic}/front/img/huiyuancard.jpg" class="am-img-responsive" alt=""/>
		<br />
		
		<form:form id="inputForm" action="${ctx}/register" method="post"
			class="form-horizontal">
			

			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">孩子姓名：</span> <input type="text"
					id="username" name="username" placeholder="拟入学儿童姓名,双胞胎名字后加2"style="width: 100%;"
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">孩子身份证号：</span> <input type="text"
					id="cardnum" name="cardnum" minlength="15" maxlength="18" placeholder="必须准确，为登陆账号,15-18位" style="width: 100%;"
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">居住村居：</span> 
				<select id="sycp" name="sycp" data-am-selected="{btnStyle: 'primary'}" class="required" style="width: 100%;">
					
						<c:forEach items="${fns:getDictList('sycp_type')}" var="type">
							<option value="${type.value}">${type.label}</option>
						</c:forEach>
					</select>
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">详细地址：</span> <input type="textarea"
					id="gzdw" name="gzdw" placeholder="举例：后厂村路69号或友谊家园2区3号楼1单元501" style="width: 100%;"
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">房东姓名：</span> <input type="text"
					id="tjr" name="tjr" placeholder="定要填写产权人，不是代理人姓名,如产权人为多人的此为指定代理产权人" style="width: 100%;"
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">房东电话：</span> <input type="text"
					id="mobile" name="mobile" placeholder="务必准确" style="width: 100%;"
					class="am-form-field required phone">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">第一监护人姓名：</span> <input type="text"
					id="dengji" name="dengji" placeholder="孩子法定监护人" style="width: 100%;"
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">第一监护人电话：</span> <input type="text"
					id="openid" name="openid" placeholder="务必准确" style="width: 100%;"
					class="am-form-field  required phone">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">第二监护人电话：</span> <input type="text"
					id="remarks" name="remarks" placeholder="务必准确" style="width: 100%;"
					class="am-form-field">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">密码：</span> <input type="password" length="6"
					id="password" name="password" placeholder="请输入密码,只能是数字"  style="width: 100%;" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "
					class="am-form-field required">
			</div>
			<div class="am-margin-top am-input-group">
				<span class="am-input-group-label">密码确认：</span> <input type="password"
					id="password1" name="password1" placeholder="请再次输入密码" onkeyup="validate()" style="width: 100%;"
					class="am-form-field required">
					<span id="tishi"></span> 
			</div>
			

			<div class="am-margin-top">
				<input id="submitButton" class="am-btn am-btn-primary am-btn-block"
					style="width: 100%;" type="submit" value="提 交" />
			</div>
			<div id="messageBox" class="alert alert-error" style="display: none">输入有误，请先更正。</div>
		</form:form>

		<div class="jeemicro_article_footer_info">西北旺镇教课文卫体办公室</div>
	</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
	<link
		href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css"
		type="text/css" rel="stylesheet" />
	<script
		src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js"
		type="text/javascript"></script>
	<script
		src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js"
		type="text/javascript"></script>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							<c:if test="${not empty message}">alert("${message}");
							</c:if>
							$("#inputForm")
									.validate(
											{
												rules : {
													validateCode : {
														remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
													}
												},
												messages : {
													content : {
														required : "请填写报名内容"
													},
													validateCode : {
														remote : "验证码不正确"
													}
												},
												errorContainer : "#messageBox",
												errorPlacement : function(
														error, element) {
													if (element.is(":checkbox")
															|| element
																	.is(":radio")
															|| element
																	.parent()
																	.is(
																			".input-append")) {
														error.appendTo(element
																.parent()
																.parent());
													} else {
														error
																.insertAfter(element);
													}
												}
											});
							$("#main_nav li").each(
									function() {
										$(this)
												.toggleClass(
														"active",
														$(this).text().indexOf(
																'公共报名') >= 0);
									});
						});
		function page(n, s) {
			location = "${ctx}/baoming?pageNo=" + n + "&pageSize=" + s;
			;
		}
	</script>
</body>
</html>