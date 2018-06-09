<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
 String data =(String) request.getAttribute("data");
  System.out.println("ye----------"+data);
%>
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

<link rel="stylesheet" href="${ctxStatic}/bmcss/calendar-pro.css" />

</head>

<body>
	<form:form id="inputForm" action="${ctx}/cms/baoming/add" method="post" class="form-horizontal" >
	 <input type="hidden" id="orderDate" name="orderDate">
	</form:form>
	<sys:message content="${message}" />
	<!-- 容器布局 -->
	
		<div class="calendar-box demo-box"></div>
		
		<button onclick="getActive()">预约</button>
	<script src="${ctxStatic}/js/jquery-2.1.4.min.js"></script>
	<script src="${ctxStatic}/js/calendar-pro.js"></script>
	<script>

		$('.calendar-box').calendar({
			ele : '.demo-box', //依附
			title : '选择预约时间',
//			beginDate : '2017-10-07',
//			endDate : '2017-12-04',
         
			//data=data;
			data:<%=data %>//getData()//[{date:'2017-10-07',data:'107'}]//
			/* data : [
				{date:'2017-10-07',data:'107'},
				{date:'2017-10-08',data:'108'},
				{date:'2017-10-09',data:'109'},
				{date:'2017-10-10',data:'110'},
				{date:'2017-10-11',data:'111'},
				{date:'2017-10-12',data:'112'},
				{date:'2017-10-13',data:'113'},
//				{date:'2017-10-14',data:'114'},
				{date:'2017-10-15',data:'115'},
				{date:'2017-10-16',data:'116'},
				{date:'2017-10-17',data:'117'},
				{date:'2017-10-18',data:'118'},
				{date:'2017-10-19',data:'119'},
				{date:'2017-10-20',data:'120'},
				{date:'2017-10-21',data:'121'},
				{date:'2017-10-22',data:'122'},
				{date:'2017-10-23',data:'123'},
				{date:'2017-10-24',data:'124'},
				{date:'2017-10-25',data:'125'},
				{date:'2017-10-26',data:'126'},
				{date:'2017-10-27',data:'127'},
				{date:'2017-10-28',data:'128'},
				{date:'2017-10-29',data:'129'},
//				{date:'2017-10-30',data:'130'},
				{date:'2017-10-31',data:'131'},
				{date:'2017-11-01',data:'101'},
				{date:'2017-11-02',data:'102'},
				{date:'2017-11-03',data:'103'},
				{date:'2017-11-04',data:'104'},
				{date:'2017-11-05',data:'105'},
				{date:'2017-11-06',data:'106'},
				{date:'2017-11-07',data:'107'},
				{date:'2017-11-08',data:'108'},
				{date:'2017-11-09',data:'109'},
				{date:'2017-11-10',data:'110'},
				{date:'2017-11-11',data:'111'},
//				{date:'2017-11-12',data:'112'},
				{date:'2017-11-13',data:'113'},
				{date:'2017-11-14',data:'114'},
				{date:'2017-11-15',data:'115'},
				{date:'2017-11-16',data:'116'},
				{date:'2017-11-17',data:'117'},
				{date:'2017-11-18',data:'118'},
				{date:'2017-11-19',data:'119'},
				{date:'2017-11-20',data:'120'},
				{date:'2017-11-21',data:'121'},
				{date:'2017-11-22',data:'122'},
				{date:'2017-11-23',data:'123'},
				{date:'2017-11-24',data:'124'},
//				{date:'2017-11-25',data:'125'},
				{date:'2017-11-26',data:'126'},
				{date:'2017-11-27',data:'127'},
				{date:'2017-11-28',data:'128'},
				{date:'2017-11-29',data:'129'},
				{date:'2017-11-30',data:'130'},
				{date:'2017-12-01',data:'121'},
				{date:'2017-12-02',data:'122'},
				{date:'2017-12-03',data:'123'},
				{date:'2017-12-04',data:'124'},
			] */
		});
		/* function getActive(){
			var data = $('.calendar-box').calendarGetActive();
			var date=data.date;
			var num =data.money;
			console.log(data);
			console.log(data.date);
		$.ajax({
			type: 'POST',
			url: '../f/baoming/bmSaveData', //这里offset,size无作用，仅方便调试
			dataType: 'json',
			 data:{  
                "date":date,
                "num" :num
            },  
			success: function(reponse){
               alert(reponse);
				
			},
			error: function(xhr, type){
				alert('数据错误，请联系管理员');
			}
		});
	} */
	
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