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
	<form:form id="inputForm" modelAttribute="cmsHuiyuan" action="${ctx}/cms/cmsHuiyuan/save" method="post" class="am-form">
		<sys:message content="${message}"/>		
		<table class="am-table am-table-striped am-table-hover">
		    <thead>
	        <tr>
	            <th></th>
	            <th></th>
	        </tr>
		    </thead>
		    <tbody>
		        <tr>
		            <td>房东电话:</td>
		             <td><c:out value="${cmsHuiyuan.mobile}"/></td>
		        </tr>
		        <tr>
		            <td>孩子姓名：</td>
		             <td><c:out value="${cmsHuiyuan.username}"/></td>
		        </tr>
		        <tr>
		            <td>孩子身份证号：</td>
		             <td><c:out value="${cmsHuiyuan.cardnum}"/></td>
		        </tr>
		         <tr>
		            <td>第一监护人姓名：</td>
		             <td><c:out value="${cmsHuiyuan.dengji}"/></td>
		        </tr>
		         <tr>
		            <td>第一监护人电话：</td>
		             <td><c:out value="${cmsHuiyuan.openid}"/></td>
		        </tr>
		        <tr>
		            <td>第二监护人电话：</td>
		             <td><c:out value="${cmsHuiyuan.remarks}"/></td>
		        </tr>
		        <tr>
		            <td>详细地址：</td>
		             <td><c:out value="${cmsHuiyuan.gzdw}"/></td>
		        </tr>
		        <tr>
		            <td>房东姓名：</td>
		             <td><c:out value="${cmsHuiyuan.tjr}"/></td>
		        </tr>
		         <tr>
		            <td>居住村居：</td>
		             <td>
				${fns:getDictLabel(cmsHuiyuan.sycp,'sycp_type','')}
				</td>
		        </tr>
	        </tbody>
	     </table>     
		
		<%-- <div class="control-group">
			<label class="control-label">居住村居：</label>
			<div class="controls">
				<form:select path="sycp" class="input-xlarge">
					<form:options items="${fns:getDictLabel('huiyuan_chanpin')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="765" class="input-xxlarge "/>
			</div>
		</div> --%>
		<%-- <div class="form-actions">
			<shiro:hasPermission name="cms:cmsHuiyuan:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div> --%>
	</form:form>
</body>
</html>