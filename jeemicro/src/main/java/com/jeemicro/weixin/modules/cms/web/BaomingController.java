/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jeemicro.weixin.common.config.Global;
import com.jeemicro.weixin.common.mapper.JsonMapper;
import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.utils.DateUtils;
import com.jeemicro.weixin.common.utils.StringUtils;
import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.modules.cms.entity.Baoming;
import com.jeemicro.weixin.modules.cms.entity.CmsCancleOrder;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.entity.Site;
import com.jeemicro.weixin.modules.cms.service.BaomingService;
import com.jeemicro.weixin.modules.cms.service.CmsCancleOrderService;
import com.jeemicro.weixin.modules.cms.service.CmsHuiyuanService;
import com.jeemicro.weixin.modules.cms.service.CmsOrderService;
import com.jeemicro.weixin.modules.cms.utils.CmsUtils;
import com.jeemicro.weixin.modules.sys.utils.DictUtils;
import com.jeemicro.weixin.modules.sys.utils.UserUtils;

/**
 * 留言Controller
 * @author zmrid
 * @version 2016-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/baoming")
public class BaomingController extends BaseController {

	@Autowired
	private BaomingService baomingService;
	@Autowired
	private CmsOrderService cmsOrderService;
	@Autowired
	private CmsCancleOrderService cmsCancleOrderService;
/*	@Autowired
	private CmsHuiyuanService cmsHuiyuanService;*/
	
	private static Map dataMap= new HashMap();

	@ModelAttribute
	public Baoming get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return baomingService.get(id);
		}else{
			return new Baoming();
		}
	}
	
	@RequiresPermissions("cms:baoming:view")
	@RequestMapping(value = {"list", ""})
	public String list(Baoming baoming, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Baoming> page = baomingService.findPage(new Page<Baoming>(request, response), baoming); 
        model.addAttribute("page", page);
     
		return "modules/cms/baomingList";
	}

	@RequiresPermissions("cms:baoming:view")
	@RequestMapping(value = "form")
	public String form(Baoming baoming, Model model) {
		model.addAttribute("baoming", baoming);
		return "modules/cms/baomingForm";
	}

	@RequiresPermissions("cms:baoming:edit")
	@RequestMapping(value = "save")
	public String save(Baoming baoming, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baoming)){
			return form(baoming, model);
		}
		if (baoming.getReUser() == null){
			baoming.setReUser(UserUtils.getUser());
			baoming.setReDate(new Date());
		}
		baomingService.save(baoming);
		addMessage(redirectAttributes, DictUtils.getDictLabel(baoming.getDelFlag(), "cms_del_flag", "保存")
				+"留言'" + baoming.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/baoming/?repage&status=2";
	}
	
	@RequiresPermissions("cms:baoming:edit")
	@RequestMapping(value = "delete")
	public String delete(Baoming baoming, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		baomingService.delete(baoming, isRe);
		addMessage(redirectAttributes, (isRe!=null&&isRe?"恢复审核":"删除")+"留言成功");
		return "redirect:" + adminPath + "/cms/baoming/?repage&status=2";
	}
	
	
	/**
	 * 报名
	 */
	@RequestMapping(value = "index", method=RequestMethod.GET)
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
		 
		
		 List list = new ArrayList();
		 CmsOrder cmsOrder = new CmsOrder();
		 List<CmsOrder> list1 =cmsOrderService.findList(cmsOrder);
		 for(CmsOrder order :list1){
			 Map map = new HashMap();
			 map.put("date",DateUtils.formatDate(order.getOrderTime(), "yyyy-MM-dd"));
			 map.put("data", order.getOrderTotal());
			 list.add(map);
		 }
		
		 String json=JsonMapper.toJsonString(list);
		 model.addAttribute("data", json);
		//return "modules/cms/front/themes/"+site.getTheme()+"/frontBaoming";
		return "modules/cms/frontBaoming";
	}
	
	/**
	 * 报名-另一页面展示
	 */
	@RequestMapping(value = "two", method=RequestMethod.GET)
	public String baoming( Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
	
	
		 CmsOrder cmsOrder = new CmsOrder();
		 List<CmsOrder> list =cmsOrderService.findList(cmsOrder);
		 
		//String json=JsonMapper.toJsonString(list);
		 model.addAttribute("data", list);
		return "modules/cms/frontBaoming1";
	}
	
	/**
	 * 报名-保存报名信息
	 */
	@RequestMapping(value = "add", method=RequestMethod.POST)
	public synchronized String baomingSave(Baoming baoming, String orderDate, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String data =request.getParameter("orderDate");
		System.out.println("dfdfd--------------->"+data);
		CmsOrder cmsOrder = new CmsOrder();
		try {
			cmsOrder.setOrderTime(DateUtils.parseDate(data, "yyyy-MM-dd"));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		cmsOrder=cmsOrderService.get(cmsOrder);
		int orderTotal =cmsOrder.getOrderTotal();
		int orderAp =cmsOrder.getOrderAp();
		int orderMp= cmsOrder.getOrderMp();
		int order =0;
		StringBuffer sb= new StringBuffer();
		if(orderTotal>0){
			//cmsOrder.setOrderTotal(orderTotal-1);
			if(orderAp>0){
				cmsOrder.setOrderAp(orderAp-1);
				order=35-cmsOrder.getOrderAp();
				if(order<=15&&order>=1){
					sb.append("下午1：30分");
				}else if(order>=16&&order<=25){
					sb.append("下午2：30分");
				}else{
					sb.append("下午3：30分");
				}
			}else{
				cmsOrder.setOrderMp(orderMp-1);
				order=35-cmsOrder.getOrderMp();
				if(order<=15&&order>=1){
					sb.append("上午9点");
				}else if(order>=16&&order<=25){
					sb.append("上午10点");
				}else{
					sb.append("上午11点");
				}
			}
		}else{
			addMessage(redirectAttributes, "余票不足！请重新选择");
			return "redirect:"+Global.getFrontPath()+"/baoming";
		}
		
		baoming.setCreateDate(DateUtils.parseDate(data));
		baoming.setId(String.valueOf(order));//顺序号
		baoming.setContent(sb.toString());
		baoming.setPhone(UserUtils.getUser().getPhone());
		baoming.setCurrentUser(UserUtils.getUser().getCurrentUser());
        baoming.setIp(request.getRemoteAddr());
		
		baoming.setDelFlag(Baoming.DEL_FLAG_AUDIT);
		
		try{
			/*cmsOrderService.update(cmsOrder);
			baomingService.save(baoming);*/
			baomingService.saveB(baoming, cmsOrder);
			addMessage(redirectAttributes, "报名成功，谢谢！");
			}catch(Exception e){
				addMessage(redirectAttributes, "您已经参与了报名！");
			}
		return "redirect:"+ adminPath +"/cms/baoming/frontBaomingResult";
	}
	
	/**
	 * 报名-保存报名信息
	 */
	@RequestMapping(value = "addTwo", method=RequestMethod.GET)
	public synchronized String baomingSave(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		logger.info("当前线程 {}", Thread.currentThread().getName()+"   cardnum->"+UserUtils.getUser().getPhone());
		String data =request.getParameter("time");
		String flg =request.getParameter("flg");
		logger.info("dfdfd--------------->"+data);
		CmsOrder cmsOrder = new CmsOrder();
		String date;
		try {
			Date d =DateUtils.parseDate(data, "yyyy-MM-dd");
			//date=DateUtils.formatDate(d, "yyyy-MM-dd");
			cmsOrder.setOrderTime(d);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		cmsOrder=cmsOrderService.get(cmsOrder);
		int orderTotal =cmsOrder.getOrderTotal();
		int orderAp =cmsOrder.getOrderAp();
		int orderMp= cmsOrder.getOrderMp();
		int order =0;
		StringBuffer sb= new StringBuffer();
		Baoming baoming=new Baoming();
		
		
		if("ap".equals(flg)){
			if(orderAp>0){
				//cmsOrder.setOrderTotal(orderTotal-1);
				int maxNum=baomingService.getMaxOrderByDate(data, flg);
				cmsOrder.setOrderAp(orderAp-1);
				//order=orderTotal-cmsOrder.getOrderAp();
				order=maxNum+1;
				if(order<=15&&order>=1){
					sb.append("下午1：30分");
				}else if(order>=16&&order<=30){
					sb.append("下午2：30分");
				}else{
					sb.append("下午3：30分");
				}
				baoming.setWorkunit("ap");
			}else{
				addMessage(redirectAttributes, "余票不足！请重新选择");
				return "redirect:"+adminPath+"/cms/baoming/two";
			}
			
		}else{
			if(orderMp>0){
				//cmsOrder.setOrderTotal(orderTotal-1);
				int maxNum=baomingService.getMaxOrderByDate(data, flg);
				cmsOrder.setOrderMp(orderMp-1);
				//order=cmsOrder.getOrderMpTotal()-cmsOrder.getOrderMp();
				order=maxNum+1;
				if(order<=15&&order>=1){
					sb.append("上午9点");
				}else if(order>=16&&order<=30){
					sb.append("上午10点");
				}else{
					sb.append("上午11点");
				}
				baoming.setWorkunit("mp");
			}else{
				addMessage(redirectAttributes, "余票不足！请重新选择");
				return "redirect:"+adminPath+"/cms/baoming/two";
			}
			
		}
		
		
		baoming.setCreateDate(DateUtils.parseDate(data));
		baoming.setReDate(new Date());//报名日期
		baoming.setId(String.valueOf(order));//顺序号
		baoming.setHuodong(String.valueOf(order));
		baoming.setContent(sb.toString());
		baoming.setPhone(UserUtils.getUser().getPhone());
		baoming.setCurrentUser(UserUtils.getUser().getCurrentUser());
        baoming.setIp(request.getRemoteAddr());
		
		baoming.setDelFlag(Baoming.DEL_FLAG_AUDIT);
		logger.info("当前线程 {}", Thread.currentThread().getName()+"order-->"+order);
		try{
			/*cmsOrderService.update(cmsOrder);
			baomingService.save(baoming);*/
			baomingService.saveB(baoming, cmsOrder);
			addMessage(redirectAttributes, "报名成功，谢谢！");
			}catch(Exception e){
				addMessage(redirectAttributes, "您已经参与或者撤销过报名！");
			}
		return "redirect:"+ adminPath +"/cms/baoming/frontBaomingResult";
	}
	
	@RequestMapping(value = {"frontBaomingResult", ""})
	public String frontBaomingResult(Baoming baoming, HttpServletRequest request, HttpServletResponse response, Model model) {
		baoming=baomingService.get(UserUtils.getUser().getPhone());
		if(baoming==null){
			baoming= new Baoming();
		}
		model.addAttribute("baoming", baoming);
		model.addAttribute("cardNum", UserUtils.getUser().getLoginName());
		model.addAttribute("username", UserUtils.getUser().getName());
		return "modules/cms/frontBaomingResult";
	}
	
	@RequestMapping(value = {"baomingTip", ""})
	public String baomingTip() {
	
		return "modules/cms/baomingTip";
	}
	
	
	@RequestMapping(value = {"cancle", ""})
	public synchronized String cancle(Baoming baoming, RedirectAttributes redirectAttributes) {
		if(baoming==null){
			baoming=baomingService.get(UserUtils.getUser().getPhone());
		}
		Date date1=baoming.getCreateDate();
		Double day=DateUtils.getDistanceOfTwoDate(date1, new Date());
		if(day>=-1){
			addMessage(redirectAttributes, "距离审核1天内,当天，过期都不能撤销预约");
		}else{
			CmsCancleOrder ccOrder = new CmsCancleOrder();
			ccOrder.setOrderTime(date1);
			ccOrder =cmsCancleOrderService.get(ccOrder);
			
			/*CmsOrder cmsOrder = new CmsOrder();
			cmsOrder.setOrderTime(date1);
			cmsOrder =cmsOrderService.get(cmsOrder);*/
			//cmsOrder.setOrderTotal(cmsOrder.getOrderTotal()+1);
			String flg=baoming.getWorkunit();
			if("ap".equals(flg)){
				ccOrder.setOrderAp(ccOrder.getOrderAp()+1);
			}else{
				ccOrder.setOrderMp(ccOrder.getOrderMp()+1);
			}
			baoming.setDelFlag(Baoming.DEL_FLAG_DELETE);
			baoming.setReContent(baoming.getReContent()+1);
			
			try{
				
				baomingService.updateB(baoming, ccOrder);
				addMessage(redirectAttributes, "撤销成功，谢谢！");
				}catch(Exception e){
					logger.error(UserUtils.getUser().getPhone()+":"+e.getMessage());
					addMessage(redirectAttributes, "撤销失败！");
				}
		}
		return "redirect:"+ adminPath +"/cms/baoming/frontBaomingResult";
	}
	

}
