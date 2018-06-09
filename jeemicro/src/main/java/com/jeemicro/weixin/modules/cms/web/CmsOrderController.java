/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web;

import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jeemicro.weixin.common.config.Global;
import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.common.utils.DateUtils;
import com.jeemicro.weixin.common.utils.StringUtils;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.service.CmsOrderService;

/**
 * 余票Controller
 * @author h
 * @version 2018-04-05
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/cmsOrder")
public class CmsOrderController extends BaseController {

	@Autowired
	private CmsOrderService cmsOrderService;
	
	@ModelAttribute
	public CmsOrder get(@RequestParam(required=false) String id) {
		CmsOrder entity = null;
	
		if (StringUtils.isNotBlank(id)){
			Date d=new Date(id);
			/*try {
				d=DateUtils.parseDate(id, "yyyy-MM-dd hh:mm:ss");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
			entity = cmsOrderService.get(DateUtils.formatDate(d, "yyyy-MM-dd"));
		}
		if (entity == null){
			entity = new CmsOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("cms:cmsOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmsOrder cmsOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmsOrder> page = cmsOrderService.findPage(new Page<CmsOrder>(request, response), cmsOrder); 
		model.addAttribute("page", page);
		return "modules/cms/cmsOrderList";
	}

	@RequiresPermissions("cms:cmsOrder:view")
	@RequestMapping(value = "form")
	public String form(CmsOrder cmsOrder, Model model) {
		model.addAttribute("cmsOrder", cmsOrder);
		return "modules/cms/cmsOrderForm";
	}

	@RequiresPermissions("cms:cmsOrder:edit")
	@RequestMapping(value = "save")
	public String save(CmsOrder cmsOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmsOrder)){
			return form(cmsOrder, model);
		}
		cmsOrderService.save(cmsOrder);
		addMessage(redirectAttributes, "保存余票成功");
		return "redirect:"+Global.getAdminPath()+"/cms/cmsOrder/?repage";
	}
	
	@RequiresPermissions("cms:cmsOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(CmsOrder cmsOrder, RedirectAttributes redirectAttributes) {
		cmsOrderService.delete(cmsOrder);
		addMessage(redirectAttributes, "删除余票成功");
		return "redirect:"+Global.getAdminPath()+"/cms/cmsOrder/?repage";
	}

}