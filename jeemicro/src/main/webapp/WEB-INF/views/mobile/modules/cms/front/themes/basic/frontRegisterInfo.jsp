<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>会员中心</title>
<meta name="decorator" content="cms_default_${site.theme}" />
<meta name="description" content="MYMT ${site.description}" />
<meta name="keywords" content="MYMT ${site.keywords}" />
<link rel="stylesheet" href="${ctxStatic}/front/css/amazeui.min.css">
<link rel="stylesheet" href="${ctxStatic}/front/css/wap.css">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<script type="text/javascript">
	$(document).ready(function() {
		//var flag = false;
		$("#send").click(function() {
			var mobile = document.getElementById("mobile").value;
			if (mobile == '') {
				alert("请输入手机号！");
				return false;
			}
			time(this);

			$("#send").attr("disabled", true);
			$.ajax({
				type : "POST",
				url : "${ctx}/../f/register/send",
				data : $("#inputForm").serialize(),
				success : function(msg) {
					/* setTimeout(function(){
					        $("#send").removeAttr("disabled").val('点击重发').css("cursor","pointer");
					    }, 60000);   */
				}
			});
		});
	});
</script>
</head>

<body style="background:#ececec">
  <div class="jeemicro_mian" >
   
		<div class="jeemicro_head">
			<header data-am-widget="header"
				class="am-header am-header-default jeemicro_head_block">
				<div class="am-header-left am-header-nav ">
					<a href="../f" class="iconfont jeemicro_head_jt_ico">&#xe601;</a>
				</div>
				<div class="jeemicro_news_list_tag_name">会员中心</div>
				<div class="am-header-right am-header-nav">
					<a href="../f" class="iconfont jeemicro_head_gd_ico">&#xe634;</a>
				</div>
			</header>
		</div>
		
    <div class="jeemicro_content jeemicro_content_list">
      <div class="jeemicro_grzx">

          <div class="jeemicro_grzx_nr">
              <div class="jeemicro_grzx_ico">
                  <img src="${ctxStatic}/front/img/huiyuan.png" alt="">
              </div>
              <c:forEach items="${cmshuiyuan2}" var="huiyuan">
	              <div class="jeemicro_grzx_name">姓&nbsp;&nbsp;名：${huiyuan.username}</div>
	              <div class="jeemicro_grzx_map">手机号：${huiyuan.mobile}</div>
	              <div class="jeemicro_grzx_num_font">会员卡号：${huiyuan.cardnum}</div>
				  <div class="jeemicro_grzx_num">
		                <span>${fns:getDictLabel(huiyuan.sex, 'sex', '无')}<i>性别</i></span>
		               	<span><fmt:formatDate value="${huiyuan.createDate}" pattern="yyyy-MM-dd" /><i>加入时间</i></span>
		                <span>${fns:getDictLabel(huiyuan.dengji, 'huiyuan_type', '无')}<i>等级</i></span><br/><br/>
		                <hr data-am-widget="divider" style="" class="am-divider am-divider-dashed" />
		                <span>${fns:getDictLabel(huiyuan.tjr, 'huiyuan_tjr', '无')}<i>推荐人</i></span>
		               	<span><fmt:formatDate value="${huiyuan.shengri}" pattern="yyyy-MM-dd" /><i>生日</i></span>
		                <span>${huiyuan.gzdw}<i>工作单位</i></span>
              	   </div>
			</c:forEach>
          </div>
</div></div>

		<div class="jeemicro_article_footer_info">Copyright(c)2017 By
			MYMT</div>
	</div>
	</div>
	<script src="${ctxStatic}/front/js/jquery.min.js"></script>
	<script src="${ctxStatic}/front/js/amazeui.min.js"></script>
	<link
		href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css"
		type="text/css" rel="stylesheet" />
	<script
		src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js"
		type="text/javascript"></script>
	<script
		src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js"
		type="text/javascript"></script>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							<c:if test="${not empty message}">alert("${message}");
							</c:if>
							$("#inputForm")
									.validate(
											{
												rules : {
													validateCode : {
														remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
													}
												},
												messages : {
													content : {
														required : "请填写报名内容"
													},
													validateCode : {
														remote : "验证码不正确"
													}
												},
												errorContainer : "#messageBox",
												errorPlacement : function(
														error, element) {
													if (element.is(":checkbox")
															|| element
																	.is(":radio")
															|| element
																	.parent()
																	.is(
																			".input-append")) {
														error.appendTo(element
																.parent()
																.parent());
													} else {
														error
																.insertAfter(element);
													}
												}
											});
							$("#main_nav li").each(
									function() {
										$(this)
												.toggleClass(
														"active",
														$(this).text().indexOf(
																'公共报名') >= 0);
									});
						});
		function page(n, s) {
			location = "${ctx}/baoming?pageNo=" + n + "&pageSize=" + s;
			;
		}
	</script>
</body>
</html>