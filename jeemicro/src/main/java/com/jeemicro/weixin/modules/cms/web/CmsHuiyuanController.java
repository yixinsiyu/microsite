/**
 * Copyright &copy; 2012-2016  All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web;

import java.util.List;

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
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.service.CmsHuiyuanService;
import com.jeemicro.weixin.modules.sys.utils.UserUtils;

/**
 * 会员管理Controller
 * @author zmrid
 * @version 2017-07-18
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/cmsHuiyuan")
public class CmsHuiyuanController extends BaseController {

	@Autowired
	private CmsHuiyuanService cmsHuiyuanService;
	
	@ModelAttribute
	public CmsHuiyuan get(@RequestParam(required=false) String id) {
		CmsHuiyuan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmsHuiyuanService.get(id);
		}
		if (entity == null){
			entity = new CmsHuiyuan();
		}
		return entity;
	}
	
	@RequiresPermissions("cms:cmsHuiyuan:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmsHuiyuan cmsHuiyuan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmsHuiyuan> page = cmsHuiyuanService.findPage(new Page<CmsHuiyuan>(request, response), cmsHuiyuan); 
		model.addAttribute("page", page);
		return "modules/cms/cmsHuiyuanList";
	}
	@RequiresPermissions("cms:cmsHuiyuan:view")
	@RequestMapping(value = {"single", ""})
	public String single( CmsHuiyuan cmsHuiyuan,HttpServletRequest request, HttpServletResponse response, Model model) {
		String phone=UserUtils.getUser().getCurrentUser().getPhone();
		cmsHuiyuan=cmsHuiyuanService.getByMobile(phone);
		model.addAttribute("cmsHuiyuan", cmsHuiyuan);
		return "modules/cms/cmsHuiyuanFormSingle";
	}

	@RequiresPermissions("cms:cmsHuiyuan:view")
	@RequestMapping(value = "form")
	public String form(CmsHuiyuan cmsHuiyuan, Model model) {
		model.addAttribute("cmsHuiyuan", cmsHuiyuan);
		/*List<CmsHuiyuan> cmshuiyuan2 = cmsHuiyuanService.findList(new CmsHuiyuan());
	    model.addAttribute("cmshuiyuan2", cmshuiyuan2);*/
		return "modules/cms/cmsHuiyuanForm";
	}

	//@RequiresPermissions("cms:cmsHuiyuan:edit")
	@RequestMapping(value = "save")
	public String save(CmsHuiyuan cmsHuiyuan, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmsHuiyuan)){
			return form(cmsHuiyuan, model);
		}
		CmsHuiyuan cmsHuiyuan1= cmsHuiyuanService.getByMobile(cmsHuiyuan.getMobile());
		if(cmsHuiyuan1!=null){
			cmsHuiyuanService.update(cmsHuiyuan);
			addMessage(redirectAttributes, "信息更新成功");
			model.addAttribute("cmsHuiyuan", cmsHuiyuan);
			return "modules/cms/cmsHuiyuanFormSingle";
		}else{
			cmsHuiyuanService.save(cmsHuiyuan);
			addMessage(redirectAttributes, "信息保存成功");
		}
		
		return "redirect:"+Global.getAdminPath()+"/cms/cmsHuiyuan/?repage";
	}
	
	@RequiresPermissions("cms:cmsHuiyuan:edit")
	@RequestMapping(value = "delete")
	public String delete(CmsHuiyuan cmsHuiyuan, RedirectAttributes redirectAttributes) {
		cmsHuiyuanService.delete(cmsHuiyuan);
		addMessage(redirectAttributes, "删除会员成功");
		return "redirect:"+Global.getAdminPath()+"/cms/cmsHuiyuan/?repage";
	}

}