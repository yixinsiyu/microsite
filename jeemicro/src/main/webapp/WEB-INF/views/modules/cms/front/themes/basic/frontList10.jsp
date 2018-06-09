<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>${category.name}</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="${category.description}" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta name="keywords" content="${category.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<link rel="stylesheet" href="${ctxStatic}/loadmore/css/loadmore.css">
<script src="${ctxStatic}/loadmore/js/tj.js"></script>
<script src="${ctxStatic}/loadmore/js/zepto.min.js"></script>
<script>
  $(function() {
  
  })
  
  $(function(){
  
   $('#doc-my-tabs').find('a').on('open.tabs.amui', function(e) {
      if(e.target.pathname.indexOf("[data-tab-panel-0]")>0){
               window.location.href="http://www.xbwls.com/jeemicro/f/list-10.html";
       }else if(e.target.pathname.indexOf("[data-tab-panel-1]")>0){
           window.location.href="http://www.xbwls.com/jeemicro/f/list-3.html";
       }else if(e.target.pathname.indexOf("[data-tab-panel-2]")>0){
           window.location.href="http://www.xbwls.com/jeemicro/f/list-12.html";
       }else{
           window.location.href="http://www.xbwls.com/jeemicro/f/list-8.html";
       }
   
  
});

	/*初始化*/
	var counter = 0; /*计数器*/
	var pageStart = 0; /*offset*/
	var pageSize = 10; /*size*/
	
	/*首次加载*/
	getData(pageStart, 80);
	
	/*监听加载更多*/
	$(document).on('click', '.js-load-more', function(){
		counter ++;
		pageStart = counter * pageSize;
		
		getData(pageStart, pageSize);
	});
    
	
	function getData(pageNo,size){
	    var categoryId='10';
		$.ajax({
			type: 'POST',
			url: 'getData'+ '?' + pageNo + '/' + size+ '/'+categoryId, //这里offset,size无作用，仅方便调试
			dataType: 'json',
			 data:{  
                "pageNo":pageNo,  
        		"pageSize":size,
        		"categoryId":categoryId 
            },  
			success: function(reponse){
              //  alert(reponse);
				var data = reponse;//.list;
				var sum =${count};//reponse.length;
				//var sum = reponse.list.length;
				
				//alert(sum);

				var result = '';
				
				/************业务逻辑块：实现拼接html内容并append到页面*****************/
				
				//console.log(offset , size, sum);
				
				/*如果剩下的记录数不够分页，就让分页数取剩下的记录数
				* 例如分页数是5，只剩2条，则只取2条
				*
				* 实际MySQL查询时不写这个不会有问题
				*/
				if(sum - pageNo < size ){
					size = sum - pageNo;
				}
				
				/*使用for循环模拟SQL里的limit(offset,size)*/
				/* for(var i=pageNo; i< (pageNo+size); i++){
					result +='<div class="weui_media_box weui_media_text">'+
							'<a href="'+ data[i].url +'" target="_blank"><h4 class="weui_media_title">'+ data[i].title +'</h4></a>'+
							'<p class="weui_media_desc">'+ data[i].image +'</p>'+
						'</div>';
				} */
				
				for(var i=0; i< (0+size); i++){
					result +='<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left"><div class="am-u-sm-4 am-list-thumb">'+
							'<a href="'+ data[i].url +'" class=""><img src="'+ data[i].imageSrc +'"  alt="" /></a></div>'+
							'<div class=" am-u-sm-8 am-list-main"><h3 class="am-list-item-hd">'+
							'<a href="'+ data[i].url +'" style="color:'+data[i].color+'" class="">'+
							data[i].title +'</a>'+
						'</h3>'+
					'<div class="am-list-item-text">'+data[i].description+'...</div>'+
					'</div></li>';
					//alert(result);
				}

				/* $('.js-blog-list').append(result); */
				$('.am-list').append(result);
				
				
				/*******************************************/
	
				/*隐藏more*/
				if ( (pageNo + size) >= sum){
					$(".js-load-more").hide();
				}else{
					$(".js-load-more").show();
				}
			},
			error: function(xhr, type){
				alert('数据错误，请联系管理员');
			}
		});
	}
});
</script>
</head>
<body style="background: #ffffff">
<input type="hidden"  id="count" value=${count}>
    <img src="${ctxStatic}/images/430a49c111-64e5-40f8-9362-182dc30a2723.jpg" alt="..." class="am-radius">
    <div data-am-widget="tabs" class="am-tabs am-tabs-default" id="doc-my-tabs">
     <ul class="am-tabs-nav am-cf">
	  <li class="am-active"><a href="[data-tab-panel-0]">安全动态</a></li>
	  <li class=""><a href="[data-tab-panel-1]">安全常识</a></li>
	  <li class=""><a href="[data-tab-panel-2]">队伍建设</a></li>
	  <li class=""><a href="[data-tab-panel-3]">法律法规</a></li>
   </ul>
   </div>
	<div data-am-widget="list_news" class="am-list-news am-list-news-default" >
  <div class="am-list-news-bd">
  <ul class="am-list">
     <!--缩略图在标题左边-->
	<%--  <c:if test="${category.module eq 'article'}">
			<c:forEach items="${page.list}" var="article">
				<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left">
					<div class="am-u-sm-4 am-list-thumb">
						<a href="${article.url}" class=""> 
						  <img src="${article.imageSrc}"  alt="" />
						</a>
					</div>
					<div class=" am-u-sm-8 am-list-main">
						<h3 class="am-list-item-hd">
							<a href="${article.url}" style="color:${article.color}" class="">${fns:abbr(article.title,30)}</a>
						</h3>
					<div class="am-list-item-text">${fns:abbr(article.description,68)}...</div>
					</div>
				</li>
		 </c:forEach>
	  </c:if> --%>
    </ul>
  </div>
</div>
	<div class="content">
    <div class="weui_panel weui_panel_access">
        <div class="weui_panel_bd js-blog-list">
           
        </div>
    </div>
	
	<!--加载更多按钮-->
	<div class="js-load-more">加载更多</div>
	
</div>
<script src="${ctxStatic}/front/js/jquery.min.js"></script>
<script src="${ctxStatic}/front/js/amazeui.min.js"></script>

</body>
</html>