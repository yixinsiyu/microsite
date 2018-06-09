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
import com.jeemicro.weixin.common.utils.StringUtils;
import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;
import com.jeemicro.weixin.modules.cms.service.OaYuangongService;

/**
 * 员工信息表Controller
 * @author zmrid
 * @version 2017-07-14
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/oaYuangong")
public class OaYuangongController extends BaseController {

	@Autowired
	private OaYuangongService oaYuangongService;
	
	@ModelAttribute
	public OaYuangong get(@RequestParam(required=false) String id) {
		OaYuangong entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaYuangongService.get(id);
		}
		if (entity == null){
			entity = new OaYuangong();
		}
		return entity;
	}
	
	@RequiresPermissions("cms:oaYuangong:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaYuangong oaYuangong, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaYuangong> page = oaYuangongService.findPage(new Page<OaYuangong>(request, response), oaYuangong); 
		model.addAttribute("page", page);
		return "modules/cms/oaYuangongList";
	}

	@RequiresPermissions("cms:oaYuangong:view")
	@RequestMapping(value = "form")
	public String form(OaYuangong oaYuangong, Model model) {
		model.addAttribute("oaYuangong", oaYuangong);
		return "modules/cms/oaYuangongForm";
	}

	@RequiresPermissions("cms:oaYuangong:edit")
	@RequestMapping(value = "save")
	public String save(OaYuangong oaYuangong, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaYuangong)){
			return form(oaYuangong, model);
		}
		oaYuangongService.save(oaYuangong);
		addMessage(redirectAttributes, "保存员工信息表成功");
		return "redirect:"+Global.getAdminPath()+"/cms/oaYuangong/?repage";
	}
	
	@RequiresPermissions("cms:oaYuangong:edit")
	@RequestMapping(value = "delete")
	public String delete(OaYuangong oaYuangong, RedirectAttributes redirectAttributes) {
		oaYuangongService.delete(oaYuangong);
		addMessage(redirectAttributes, "删除员工信息表成功");
		return "redirect:"+Global.getAdminPath()+"/cms/oaYuangong/?repage";
	}

}