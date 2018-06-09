/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web.front;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jeemicro.weixin.common.config.Global;
import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.utils.HttpsGetUtil;
import com.jeemicro.weixin.common.utils.UUID16Utils;
import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.entity.Site;
import com.jeemicro.weixin.modules.cms.service.CmsHuiyuanService;
import com.jeemicro.weixin.modules.cms.utils.CmsUtils;
import com.jeemicro.weixin.modules.sys.utils.UserUtils;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

import net.sf.json.JSONObject;

/**
 * 报名Controller
 * 
 * @author zmrid
 * @version 2017-07-15
 */
@Controller
@RequestMapping(value = "${frontPath}/register")
public class FrontRegisterController extends BaseController {

	@Autowired
	private CmsHuiyuanService registerService;
	public String json = "";
	public String openid = "";				//会员注册的openid

	/**
	 * 会员注册
	 *//*
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String register(@RequestParam(required = false, defaultValue = "1") Integer pageNo,
			@RequestParam(required = false, defaultValue = "30") Integer pageSize, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		//获取微信用户openid
		String get_access_token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?" + "appid=" + Global.APPID
				+ "&secret=" + Global.APPSECRET + "&code=CODE&grant_type=authorization_code";

		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		response.setCharacterEncoding("UTF-8");
		String code = request.getParameter("code");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		try {
			get_access_token_url = get_access_token_url.replace("CODE", code);
			json = HttpsGetUtil.doHttpsGetJson(get_access_token_url);
		} catch (Exception e) {
			out.println("请在微信客户端打开");
		}
		Gson gson = new Gson();
		Map<String, String> retMap = gson.fromJson(json, new TypeToken<Map<String, String>>() {
		}.getType());
		// System.out.println("uid:" + retMap.get("uid") + ", " + "region:" +
		// retMap.get("region") + ", " + "order:" + retMap.get("order"));
	//	openid = retMap.get("openid");
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);

		Page<CmsHuiyuan> page = new Page<CmsHuiyuan>(pageNo, pageSize);
		CmsHuiyuan register = new CmsHuiyuan();
		register.setDelFlag(CmsHuiyuan.DEL_FLAG_NORMAL);
		page = registerService.findPage(page, register);
		model.addAttribute("page", page);
		List<CmsHuiyuan> cmshuiyuan = registerService.findList(new CmsHuiyuan());
		List<String> openidStr = new ArrayList<String>();
		for (CmsHuiyuan s : cmshuiyuan) {
			openidStr.add(s.getOpenid());
		}
		//在微信客户端执行刷新操作
		if(openid==null || openid.equals("")){
			return "redirect:" + "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx07673552a84e337f&redirect_uri=http://www.asyy.club/f/register&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		}else{
			if (openidStr.contains(openid)) {
				List<CmsHuiyuan> cmshuiyuan2 = registerService.findListByOpenid(openid);
				model.addAttribute("cmshuiyuan2", cmshuiyuan2);
				return "modules/cms/front/themes/" + site.getTheme() + "/frontRegisterInfo";
			} else {
				return "modules/cms/front/themes/" + site.getTheme() + "/frontRegister";
			}
		}
	}
*/
	
	/**
	 * 会员注册
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String register(@RequestParam(required = false, defaultValue = "1") Integer pageNo,
			@RequestParam(required = false, defaultValue = "30") Integer pageSize, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		
		response.setCharacterEncoding("UTF-8");
		
		
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);

		return "modules/cms/front/themes/" + site.getTheme() + "/frontRegister";
	}
	/**
	 * 会员注册保存
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	public String registerSave(CmsHuiyuan register, String validateCode, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes,Model model) {
		register.setCreateDate(new Date());
		register.setDelFlag(CmsHuiyuan.DEL_FLAG_NORMAL);
		//register.setOpenid(openid);
		//register.setCardnum(UUID16Utils.getOrderIdByUUId());
		//register.setDengji("1");
		//校验发送手机验证码，测试系统不开放
		/*
		 * if(register.getYzm().equals(request.getSession().getAttribute(
		 * "messageCode"))) { registerService.save(register);
		 * addMessage(redirectAttributes, "注册成功，谢谢！");
		 * 
		 * }else{ addMessage(redirectAttributes, "验证码不正确，请确认！"); }
		 */
		//registerService.save(register);
		//UserUtils.getCache(key)
		CmsHuiyuan cs =registerService.getByCertNum(register.getCardnum());
		if(cs!=null){
			addMessage(redirectAttributes, "此证件号已注册过,请直接登陆！");
			
			return "redirect:"+Global.getFrontPath()+"/register";
			
		}
		CmsHuiyuan cs1 =registerService.getByMobile(register.getMobile());
		if(cs1!=null){
			addMessage(redirectAttributes, "此手机号已注册过,请直接登陆！账号："+cs1.getCardnum());
			
			return "redirect:"+Global.getFrontPath()+"/register";
			
		}
		try{
			registerService.saveRegisterInfo(register);
			addMessage(redirectAttributes, "注册成功，谢谢！");
		}catch(Exception e){
			e.printStackTrace();
			logger.error("注册异常  {},id {}", e.getMessage(),register.getCardnum());			addMessage(redirectAttributes, "注册异常，请联系管理员确认是否已注册过！");
		}
		
		
		return "redirect:" + Global.getAdminPath();

	}

}
