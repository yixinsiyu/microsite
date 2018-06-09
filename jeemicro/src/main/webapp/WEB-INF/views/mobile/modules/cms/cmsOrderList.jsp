<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>余票管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
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
		<li class="active"><a href="${ctx}/cms/cmsOrder/">余票列表</a></li>
		<shiro:hasPermission name="cms:cmsOrder:edit"><li><a href="${ctx}/cms/cmsOrder/form">余票添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsOrder" action="${ctx}/cms/cmsOrder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>时间：</label>
				<input name="orderTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cmsOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>时间</th>
				<th>上午</th>
				<th>下午</th>
				<th>全天</th>
				<shiro:hasPermission name="cms:cmsOrder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsOrder">
			<tr>
				<td><a href="${ctx}/cms/cmsOrder/form?id=${cmsOrder.id}">
					<fmt:formatDate value="${cmsOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${cmsOrder.orderMp}
				</td>
				<td>
					${cmsOrder.orderAp}
				</td>
				<td>
					${cmsOrder.orderTotal}
				</td>
				<shiro:hasPermission name="cms:cmsOrder:edit"><td>
    				<a href="${ctx}/cms/cmsOrder/form?id=${cmsOrder.orderTime}">修改</a>
					<a href="${ctx}/cms/cmsOrder/delete?id=${cmsOrder.orderTime}" onclick="return confirmx('确认要删除该余票吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>