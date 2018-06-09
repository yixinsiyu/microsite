<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>撤销票管理</title>
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
		<li class="active"><a href="${ctx}/cms/cmsCancleOrder/">撤销票列表</a></li>
		<shiro:hasPermission name="cms:cmsCancleOrder:edit"><li><a href="${ctx}/cms/cmsCancleOrder/form">撤销票添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsCancleOrder" action="${ctx}/cms/cmsCancleOrder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>取消时间：</label>
				<input name="orderTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cmsCancleOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>上午取消数：</label>
				<form:input path="orderMp" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>下午取消数：</label>
				<form:input path="orderAp" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>取消时间</th>
				<th>上午取消数</th>
				<th>下午取消数</th>
				<shiro:hasPermission name="cms:cmsCancleOrder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsCancleOrder">
			<tr>
				<td><a href="${ctx}/cms/cmsCancleOrder/form?id=${cmsCancleOrder.id}">
					<fmt:formatDate value="${cmsCancleOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${cmsCancleOrder.orderMp}
				</td>
				<td>
					${cmsCancleOrder.orderAp}
				</td>
				<shiro:hasPermission name="cms:cmsCancleOrder:edit"><td>
    				<a href="${ctx}/cms/cmsCancleOrder/form?id=${cmsCancleOrder.id}">修改</a>
					<a href="${ctx}/cms/cmsCancleOrder/delete?id=${cmsCancleOrder.id}" onclick="return confirmx('确认要删除该撤销票吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>