<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>注册信息</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">

	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<header data-am-widget="header" class="am-header am-header-default">
	  <div class="am-header-left am-header-nav">
	    <a href="${ctx}" class="">
	      <span class="am-header-nav-title">首页</span>
	      <i class="am-header-icon am-icon-home"></i>
	    </a>
	  </div>
	  <h1 class="am-header-title"></h1>
	  <div class="am-header-right am-header-nav">
	    <a href="${ctx}" class="">
	      <span class="am-header-nav-title">菜单</span>
	      <i class="am-header-icon am-icon-bars"></i>
	    </a>
	  </div>
</header>
<div class="jeemicro_mian">
	<form:form id="inputForm" modelAttribute="cmsHuiyuan" action="${ctx}/cms/cmsHuiyuan/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">房东电话：</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="192" class="input-xlarge" readonly="true"  />
			</div>
			<%-- <select id="type" name="type" data-am-selected="{btnStyle: 'primary'}" class="required" style="width: 100%;">
							<option value="">请选择</option>
							<c:forEach items="${cmshuiyuan2}" var="type">
								<option value="${type.mobile}">${type.username}</option>
							</c:forEach> 
			</select> --%>
		</div>
		<div class="control-group">
			<label class="control-label">孩子姓名：</label>
			<div class="controls">
				<form:input path="username" htmlEscape="false" maxlength="300" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">孩子身份证号：</label>
			<div class="controls">
				<form:input path="cardnum" htmlEscape="false" maxlength="300" readonly="true"  class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第一监护人姓名：</label>
			<div class="controls">
				<form:input path="dengji" htmlEscape="false" maxlength="300"  class="input-xlarge required" />
<%-- 					<form:options items="${fns:getDictList('huiyuan_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
 --%>				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第一监护人电话：</label>
			<div class="controls">
				<form:input path="openid" htmlEscape="false" maxlength="300" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详细地址：</label>
			<div class="controls">
				<form:input path="gzdw" htmlEscape="false" maxlength="300" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">房东姓名：</label>
			<div class="controls">
				<form:input path="tjr" class="input-xlarge required" htmlEscape="false" maxlength="300"/>
					<%-- <form:options items="${fns:getDictList('huiyuan_tjr')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select> --%>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">居住村居：</label>
			<div class="controls">
				<form:select path="sycp" class="input-xlarge">
					<form:options items="${fns:getDictList('sycp_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第二监护人电话：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="765" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="修改"/>
		</div>
	</form:form>
</div>
<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
</body>
</html>