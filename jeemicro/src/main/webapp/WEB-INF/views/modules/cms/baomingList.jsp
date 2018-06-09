<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>报名管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/baoming/">报名列表</a></li>
		<%--
		<shiro:hasPermission name="cms:baoming:edit"><li><a href="${ctx}/cms/baoming/form?id=${baoming.id}">报名添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="baoming" action="${ctx}/cms/baoming/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<label>内容 ：</label>
		<form:input path="content" htmlEscape="false" maxlength="50"
			class="input-small" />
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit"
			value="查询" />&nbsp;&nbsp;
		<label>状态：</label>
		<form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag"
			items="${fns:getDictList('cms_del_flag')}" itemLabel="label"
			itemValue="value" htmlEscape="false" />
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>报名内容</th>
				<th>项目</th>
				<th>报名人</th>
				<th>电话</th>
				<th>报名时间</th>
				<th>回复人</th>
				<th>回复内容</th>
				<th>回复时间</th>
				<shiro:hasPermission name="cms:baoming:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="baoming">
				<tr>
					<td><a href="${ctx}/cms/baoming/form?id=${baoming.id}">${fns:abbr(baoming.content,40)}</a></td>
					<td>${baoming.huodong}</td>
					<td>${baoming.name}</td>
					<td>${baoming.phone}</td>
					<td><fmt:formatDate value="${baoming.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${baoming.reUser.name}</td>
					<td>${fns:abbr(baoming.reContent,40)}</td>
					<td><fmt:formatDate value="${baoming.reDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<shiro:hasPermission name="cms:baoming:edit">
						<td><c:if test="${baoming.delFlag ne '2'}">
								<a
									href="${ctx}/cms/baoming/delete?id=${baoming.id}${baoming.delFlag ne 0?'&isRe=true':''}"
									onclick="return confirmx('确认要${baoming.delFlag ne 0?'恢复审核':'删除'}该报名吗？', this.href)">${baoming.delFlag ne 0?'恢复审核':'删除'}</a>
							</c:if> <c:if test="${baoming.delFlag eq '2'}">
								<a href="${ctx}/cms/baoming/form?id=${baoming.id}">审核</a>
							</c:if></td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>