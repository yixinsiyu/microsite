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
<script type="text/javascript">
 function confirm1(flg,time){
	
	 if(confirm("请确认预约日期")){
		 　　//点击确定后操作
		  document.getElementById("flg").value=flg;
		  document.getElementById("time").value=time;
		// document.getElementById("inputForm").action="${ctx}/cms/baoming/addTwo?flg="+flg+"&time="+time;
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
	<sys:message content="${message}" />
	<!-- 容器布局 -->

		<div>
		 <!--  <div><p style="color:red;">系统现在为测试阶段一切数据在正式报名前都将清空，但仍然需要大家认真填报，</p>
		  <p style="color:red;"></progress>如发现系统问题，及时联系QQ群206026111  群管</p></div> -->
		  <form id="inputForm" action="${ctx}/cms/baoming/addTwo">
		   <input type="hidden" id="flg" name="flg">
		    <input type="hidden" id="time" name="time">
		  </form>
		  <table class="am-table am-table-radius ">
		     <thead>
		       <tr><td colspan="10">北京市海淀区西北旺镇人民政府教科文卫体办公室</td><tr>
		       <hr/>
		       <tr class="am-primary">
		          <th>排班</th>
		       	<c:forEach items="${data}" var="order" varStatus="vs">  
		          <th><fmt:formatDate value="${order.orderTime}" pattern="MM-dd"/></th>
		        </c:forEach>
		       </tr>
		     </thead>
		     <tbody>
		       <tr class="am-warning">
		        <td>上午</td>
		        <c:forEach items="${data}" var="order" varStatus="vs">  
<%-- 		         <td><a href="${ctx}/cms/baoming/addTwo?flg=mp&time=<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>">${order.orderMp}</a></td>
 --%>		         <td><a href="javascript:void(0);" onclick="return confirm1('mp','<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>')">${order.orderMp}</a></td>
		        </c:forEach>
               </tr>
               <tr class="am-warning">
                 <td>下午</td>
                  <c:forEach items="${data}" var="order" varStatus="vs">  
<%-- 		         <td><a href="${ctx}/cms/baoming/addTwo?flg=ap&time=<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>">${order.orderAp}</a></td>
 --%>		          <td><a href="javascript:void(0);" onclick="return confirm1('ap','<fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/>')">${order.orderAp}</a></td>
		          </c:forEach>
               </tr>		     
		     </tbody>
		  </table>
		</div>
</body>
</html>