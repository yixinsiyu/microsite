<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员管理</title>
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
		<li class="active"><a href="${ctx}/cms/cmsHuiyuan/">会员列表</a></li>
		<shiro:hasPermission name="cms:cmsHuiyuan:edit"><li><a href="${ctx}/cms/cmsHuiyuan/form">会员添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsHuiyuan" action="${ctx}/cms/cmsHuiyuan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>手机号：</label>
				<form:input path="mobile" htmlEscape="false" maxlength="192" class="input-medium"/>
			</li>
			<li><label>姓名：</label>
				<form:input path="username" htmlEscape="false" maxlength="300" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>手机号</th>
				<th>姓名</th>
				<th>创建时间</th>
				<th>微信id</th>
				<th>会员卡号</th>
				<th>等级</th>
				<th>工作单位</th>
				<th>推荐人</th>
				<th>性别</th>
				<th>生日</th>
				<th>使用产品</th>
				<th>备注</th>
				<shiro:hasPermission name="cms:cmsHuiyuan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsHuiyuan">
			<tr>
				<td><a href="${ctx}/cms/cmsHuiyuan/form?id=${cmsHuiyuan.id}">
					${cmsHuiyuan.mobile}
				</a></td>
				<td>
					${cmsHuiyuan.username}
				</td>
				<td>
					<fmt:formatDate value="${cmsHuiyuan.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cmsHuiyuan.openid}
				</td>
				<td>
					${cmsHuiyuan.cardnum}
				</td>
				<td>
					${fns:getDictLabel(cmsHuiyuan.dengji, 'huiyuan_type', '')}
				</td>
				<td>
					${cmsHuiyuan.gzdw}
				</td>
				<td>
					${fns:getDictLabel(cmsHuiyuan.tjr, 'huiyuan_tjr', '')}
				</td>
				<td>
					${fns:getDictLabel(cmsHuiyuan.sex, 'sex', '')}
				</td>
				<td>
					<fmt:formatDate value="${cmsHuiyuan.shengri}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(cmsHuiyuan.sycp, 'huiyuan_chanpin', '')}
				</td>
				<td>
					${cmsHuiyuan.remarks}
				</td>
				<shiro:hasPermission name="cms:cmsHuiyuan:edit"><td>
    				<a href="${ctx}/cms/cmsHuiyuan/form?id=${cmsHuiyuan.id}">修改</a>
					<a href="${ctx}/cms/cmsHuiyuan/delete?id=${cmsHuiyuan.id}" onclick="return confirmx('确认要删除该会员吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>