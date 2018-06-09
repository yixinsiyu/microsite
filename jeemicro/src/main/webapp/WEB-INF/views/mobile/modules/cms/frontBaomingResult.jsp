<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>在线报名</title>

<meta name="decorator" content="default"/>

	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="format-detection" content="telephone=no" />
	<meta name="renderer" content="webkit">
<meta name="description" content="ZMRID ${site.description}" />
<meta name="keywords" content="ZMRID ${site.keywords}" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">

<script type="text/javascript">
 function confirm1(time){
	
	/* if(time==3){
		alert("您已取消3次，无法再次取消");
		return false;
	} */
	var a1=3-time;
	//alert(a1);
	var msg ="您已取消"+time+"次,剩余"+a1+",确定取消预约?"
	 if(confirm("确定取消预约?")){
		 　　//点击确定后操作
		  
		　$('#delFlag').val('1');
		    document.getElementById("inputForm").submit();
		}else{
		return false;
		}
 }
</script>

</head>

<body>
<header data-am-widget="header" class="am-header am-header-default">
	  <div class="am-header-left am-header-nav">
	    <a href="../../" class="">
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
	<form:form id="inputForm" modelAttribute="baoming" action="${ctx}/cms/baoming/cancle" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="delFlag"/>
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
		            <td>顺序号:</td>
		            <td><c:out value="${baoming.huodong}"/>号</td>
		        </tr>
		         <tr>
		            <td>孩子姓名:</td>
		            <td><c:out value="${username}"/></td>
		        </tr>
		        <tr>
		            <td>孩子身份证号:</td>
		            <td><c:out value="${cardNum}"/></td>
		        </tr>
		        <tr>
		            <td>报名日期:</td>
		            <td><fmt:formatDate value="${baoming.createDate}" pattern="yyyy-MM-dd"/></td>
		        </tr>
		        <tr>
		            <td>预计时间:</td>
		            <td><c:out value="${baoming.content}"/></td>
		           
		        </tr>
		         <c:if test="${not empty baoming.content}">
		         <tr>
		            <td>状态:</td>
		           <c:if test="${baoming.delFlag eq '2'}"> <td>已预约</td></c:if>
		                <c:if test="${baoming.delFlag eq '1'}"><td><p style="color:red;font-size:20px;">注意：已取消预约</td></c:if>
		        </tr> 
		        </c:if>
		      </tbody>
		</table>
		
		
		 <c:if test="${not empty baoming.content}">
		 <div class="form-actions"><c:if test="${baoming.delFlag eq '2'}">
			<input id="btnSubmit" class="btn btn-inverse" type="button" value="取消预约" onclick="return confirm1('<c:out value="${baoming.reContent}"/>');"/>&nbsp;</c:if>
		</div>
		</c:if>
	</form:form>
	<p style="color:red;">注意事项:</p>
	<p style="color:red;">1.审核日开始前1天不得取消，</p>
	<p style="color:red;">2.此为五证联审排号专用</p>
	<p style="color:red;">3.工作时间是上午9：00到12:00.下午是1:30到5:00</p>
	<p style="color:red;">42.请带五证原件及复印件一套，及房东本人，按照预约的时间到丰润东路，西北旺镇社保所院内参加审核，
	                                                                          过号的按门卫要求延后参加审核。无故爽约的请联系门卫，在网上预约号全部安排完后，择期现场排队入内</p> 
	<sys:message content="${message}" />

</body>

	
</html>