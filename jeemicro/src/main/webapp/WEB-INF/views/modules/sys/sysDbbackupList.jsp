<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据库备份管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysDbbackup/">数据库备份列表</a></li>
		<shiro:hasPermission name="sys:sysDbbackup:edit"><li><a href="${ctx}/sys/sysDbbackup/form">数据库备份添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysDbbackup" action="${ctx}/sys/sysDbbackup/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>数据库名称</th>
				<th>文件名称</th>
				<th>文件地址</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="sys:sysDbbackup:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysDbbackup">
			<tr>
				<td><a href="${ctx}/sys/sysDbbackup/form?id=${sysDbbackup.id}">
					${fns:getDictLabel(sysDbbackup.dbName, 'sys_dbname', '')}
				</a></td>
				<td>
					${sysDbbackup.fileName}
				</td>
				<td>
					${sysDbbackup.filePath}
				</td>
				<td>
					${sysDbbackup.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysDbbackup.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysDbbackup.remarks}
				</td>
				<shiro:hasPermission name="sys:sysDbbackup:edit"><td>
    				<a href="${ctx}/sys/sysDbbackup/form?id=${sysDbbackup.id}">修改</a>
    				<a href="${ctx}/db/ServletDownload?filename=${sysDbbackup.fileName}">下载</a>
    				<a href="${ctx}/sys/sysDbbackup/hy?id=${sysDbbackup.id}">还原</a>
					<a href="${ctx}/sys/sysDbbackup/delete?id=${sysDbbackup.id}" onclick="return confirmx('确认要删除该数据库备份吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>