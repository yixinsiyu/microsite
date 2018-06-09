<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>在线报名</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#reContent").focus();
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/baoming/">报名列表</a></li>
		<li class="active"><a href="${ctx}/cms/baoming/form?id=${baoming.id}">报名<shiro:hasPermission name="cms:baoming:edit">${baoming.delFlag eq '2'?'审核':'查看'}</shiro:hasPermission><shiro:lacksPermission name="cms:baoming:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="baoming" action="${ctx}/cms/baoming/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="delFlag"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<c:out value="${baoming.name}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<c:out value="${baoming.phone}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单位:</label>
			<div class="controls">
				<c:out value="${baoming.workunit}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目:</label>
			<div class="controls">
				<span style="font-weight:bold;"><c:out value="${baoming.huodong}"/></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">IP:</label>
			<div class="controls">
				<c:out value="${baoming.ip}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报名时间:</label>
			<div class="controls">
				<fmt:formatDate value="${baoming.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报名内容:</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge" disabled="true"/>
			</div>
		</div>
		<c:if test="${not empty baoming.reUser}">
			<div class="control-group">
				<label class="control-label">回复人:</label>
				<div class="controls">
					<c:out value="${baoming.reUser.name}"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">回复时间:</label>
				<div class="controls">
					<fmt:formatDate value="${baoming.reDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">回复内容:</label>
			<div class="controls">
				<form:textarea path="reContent" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="form-actions"><c:if test="${baoming.delFlag eq '2'}">
			<shiro:hasPermission name="cms:baoming:edit"><input id="btnSubmit" class="btn btn-success" type="submit" value="通 过" onclick="$('#delFlag').val('0')"/>&nbsp;
			<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#delFlag').val('1')"/>&nbsp;</shiro:hasPermission></c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>