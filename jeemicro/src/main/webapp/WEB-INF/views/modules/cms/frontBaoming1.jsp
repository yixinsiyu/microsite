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
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">

</head>

<body>
	<form:form id="inputForm" action="${ctx}/cms/baoming/addTwo" method="post" class="form-horizontal" >
	 <input type="hidden" id="orderDate" name="orderDate">
	</form:form>
	<sys:message content="${message}" />
	<!-- 容器布局 -->
	

		<div>
		
		  <table class="am-table am-table-radius am-table-striped ">
		     <thead>
		       <tr class="am-primary">
		          <th>排班</th>
		       	<c:forEach items="${data}" var="order" varStatus="vs">  
		          <th><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/></th>
		        </c:forEach>
		       </tr>
		     </thead>
		     <tbody>
		       <tr class="am-warning">
		        <td>上午</td>
		        <c:forEach items="${data}" var="order" varStatus="vs">  
		         <td><a href="${ctx}/cms/baoming/addTwo?flg=mp&time=<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>">${order.orderMp}</a></td>
		        </c:forEach>
               </tr>
               <tr class="am-warning">
                 <td>下午</td>
                  <c:forEach items="${data}" var="order" varStatus="vs">  
		         <td><a href="${ctx}/cms/baoming/addTwo?flg=ap&time=<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>">${order.orderAp}</a></td>
		          </c:forEach>
               </tr>		     
		     </tbody>
		  </table>
		</div>
		

	<script src="${ctxStatic}/js/jquery-2.1.4.min.js"></script>
	<script src="${ctxStatic}/js/calendar-pro.js"></script>
	<script>

	
	 function getActive(){
	        var data = $('.calendar-box').calendarGetActive();
	     
			var date=data.date;
			var num =data.money;
			console.log(data);
			console.log(data.date);
	  document.getElementById("orderDate").value=date;
	  document.getElementById("inputForm").submit();
	 }
	</script>
	
</body>

	
</html>