/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web;

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
import com.jeemicro.weixin.common.utils.StringUtils;
import com.jeemicro.weixin.modules.cms.entity.CmsCancleOrder;
import com.jeemicro.weixin.modules.cms.service.CmsCancleOrderService;

/**
 * 撤销票Controller
 * @author quxiao
 * @version 2018-05-07
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/cmsCancleOrder")
public class CmsCancleOrderController extends BaseController {

	@Autowired
	private CmsCancleOrderService cmsCancleOrderService;
	
	@ModelAttribute
	public CmsCancleOrder get(@RequestParam(required=false) String id) {
		CmsCancleOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmsCancleOrderService.get(id);
		}
		if (entity == null){
			entity = new CmsCancleOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("cms:cmsCancleOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmsCancleOrder cmsCancleOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmsCancleOrder> page = cmsCancleOrderService.findPage(new Page<CmsCancleOrder>(request, response), cmsCancleOrder); 
		model.addAttribute("page", page);
		return "modules/cms/cmsCancleOrderList";
	}

	@RequiresPermissions("cms:cmsCancleOrder:view")
	@RequestMapping(value = "form")
	public String form(CmsCancleOrder cmsCancleOrder, Model model) {
		model.addAttribute("cmsCancleOrder", cmsCancleOrder);
		return "modules/cms/cmsCancleOrderForm";
	}

	@RequiresPermissions("cms:cmsCancleOrder:edit")
	@RequestMapping(value = "save")
	public String save(CmsCancleOrder cmsCancleOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmsCancleOrder)){
			return form(cmsCancleOrder, model);
		}
		cmsCancleOrderService.save(cmsCancleOrder);
		addMessage(redirectAttributes, "保存撤销票成功");
		return "redirect:"+Global.getAdminPath()+"/cms/cmsCancleOrder/?repage";
	}
	
	@RequiresPermissions("cms:cmsCancleOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(CmsCancleOrder cmsCancleOrder, RedirectAttributes redirectAttributes) {
		cmsCancleOrderService.delete(cmsCancleOrder);
		addMessage(redirectAttributes, "删除撤销票成功");
		return "redirect:"+Global.getAdminPath()+"/cms/cmsCancleOrder/?repage";
	}

}