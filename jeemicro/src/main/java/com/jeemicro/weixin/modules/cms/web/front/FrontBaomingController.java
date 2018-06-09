/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web.front;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jeemicro.weixin.common.config.Global;
import com.jeemicro.weixin.common.mapper.JsonMapper;
import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.utils.DateUtils;
import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.modules.cms.entity.Article;
import com.jeemicro.weixin.modules.cms.entity.Baoming;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.entity.Site;
import com.jeemicro.weixin.modules.cms.service.BaomingService;
import com.jeemicro.weixin.modules.cms.service.CmsHuiyuanService;
import com.jeemicro.weixin.modules.cms.service.CmsOrderService;
import com.jeemicro.weixin.modules.cms.utils.CmsUtils;
import com.jeemicro.weixin.modules.sys.utils.UserUtils;

import freemarker.template.utility.DateUtil;

/**
 * 报名Controller
 * @author zmrid
 * @version 2017-07-15
 */
@Controller
@RequestMapping(value = "${frontPath}/baoming")
public class FrontBaomingController extends BaseController{
	
	@Autowired
	private BaomingService baomingService;
	@Autowired
	private CmsOrderService cmsOrderService;
/*	@Autowired
	private CmsHuiyuanService cmsHuiyuanService;*/
	
	private static Map dataMap= new HashMap();
	/**
	 * 报名
	 */
	@RequestMapping(value = "", method=RequestMethod.GET)
	public String baoming(@RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="30") Integer pageSize, Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		
		Page<Baoming> page = new Page<Baoming>(pageNo, pageSize);
		Baoming baoming = new Baoming();
		baoming.setDelFlag(Baoming.DEL_FLAG_NORMAL);
		page = baomingService.findPage(page, baoming);
		model.addAttribute("page", page);
		/*List<CmsHuiyuan> cmshuiyuan = cmsHuiyuanService.findList(new CmsHuiyuan());
	    model.addAttribute("cmshuiyuan", cmshuiyuan);*/
		 Map map = new HashMap();
		 map.put("date", "2017-10-07");
		 map.put("data", "70");
		 List list = new ArrayList();
		 list.add(map);
		 String json=JsonMapper.toJsonString(list);
		 model.addAttribute("data", json);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontBaoming";
	}
	
	/**
	 * 报名-保存报名信息
	 */
	@RequestMapping(value = "", method=RequestMethod.POST)
	public synchronized String baomingSave(Baoming baoming, String orderDate, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String data =request.getParameter("orderDate");
		System.out.println("dfdfd--------------->"+data);
		CmsOrder cmsOrder = new CmsOrder();
		cmsOrder.setOrderTime(DateUtils.parseDate(data));
		cmsOrder=cmsOrderService.get(cmsOrder);
		int orderTotal =cmsOrder.getOrderTotal();
		if(orderTotal>0){
			cmsOrder.setOrderTotal(orderTotal-1);
		}else{
			addMessage(redirectAttributes, "余票不足！请重新选择");
			return "redirect:"+Global.getFrontPath()+"/baoming";
		}
		
		
        baoming.setIp(request.getRemoteAddr());
		baoming.setCreateDate(DateUtils.parseDate(data));
		baoming.setDelFlag(Baoming.DEL_FLAG_AUDIT);
		baoming.setCurrentUser(UserUtils.getUser().getCurrentUser());
		try{
			cmsOrderService.update(cmsOrder);
			baomingService.save(baoming);
			addMessage(redirectAttributes, "报名成功，谢谢！");
			}catch(Exception e){
				addMessage(redirectAttributes, "您已经参与了报名！");
			}
		return "redirect:"+Global.getFrontPath()+"/baoming";
	}
	
	 @RequestMapping(value="getData")
	 @ResponseBody
	 public String getData(){
		 Map map = new HashMap();
		 map.put("date", "2017-10-07");
		 map.put("data", "70");
		 List list = new ArrayList();
		 list.add(map);
		 String json=JsonMapper.toJsonString(list);
			System.out.println("json--------->"+json);
			
			return json;
	 
	 }
	 

	
	@RequestMapping(value="bmSaveData")
	 @ResponseBody
	 public String bmSaveData(@RequestParam(required=false, defaultValue="0") String date,
			 @RequestParam(required=false, defaultValue="0") String num){
		
		System.out.println("date--------->"+date);
		System.out.println("num--------->"+num);
		System.out.println("d----------->"+UserUtils.getUser().getCurrentUser());
		Baoming baoming = new Baoming();
		baoming.setCreateDate(new Date());
		baoming.setDelFlag(Baoming.DEL_FLAG_AUDIT);
		baoming.setCurrentUser(UserUtils.getUser().getCurrentUser());
		try{
			baomingService.save(baoming);
			//addMessage(redirectAttributes, "报名成功，谢谢！");
			}catch(Exception e){
				//addMessage(redirectAttributes, "您已经参与了报名！");
			}
		
		
		return "包名城管";
	 
	 }
	
	@RequestMapping(value = {"baomingTip", ""})
	public String baomingTip() {
	
		return "modules/cms/baomingTip";
	}
}
