/**
 * Copyright ZT All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.jeemicro.weixin.common.utils.SystemPath;
import com.jeemicro.weixin.modules.sys.entity.SysDbbackup;
import com.jeemicro.weixin.modules.sys.service.SysDbbackupService;
import com.jeemicro.weixin.modules.sys.utils.DbbackUtils;

/**
 * 数据库备份Controller
 * @author ZT
 * @version 2017-05-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysDbbackup")
public class SysDbbackupController extends BaseController {

	@Autowired
	private SysDbbackupService sysDbbackupService;
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@ModelAttribute
	public SysDbbackup get(@RequestParam(required=false) String id) {
		SysDbbackup entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysDbbackupService.get(id);
		}
		if (entity == null){
			entity = new SysDbbackup();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysDbbackup:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysDbbackup sysDbbackup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysDbbackup> page = sysDbbackupService.findPage(new Page<SysDbbackup>(request, response), sysDbbackup); 
		model.addAttribute("page", page);
		return "modules/sys/sysDbbackupList";
	}

	@RequiresPermissions("sys:sysDbbackup:view")
	@RequestMapping(value = "form")
	public String form(SysDbbackup sysDbbackup, Model model) {
		model.addAttribute("sysDbbackup", sysDbbackup);
		return "modules/sys/sysDbbackupForm";
	}

	@RequiresPermissions("sys:sysDbbackup:edit")
	@RequestMapping(value = "save")
	public String save(SysDbbackup sysDbbackup, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysDbbackup)){
			return form(sysDbbackup, model);
		}
		String backFileName = DateUtils.getTimeForBack()+System.currentTimeMillis() + Global.BACKSUFFIX;
		String backFilePath = SystemPath.getSysPath()+"db\\";
        try {  
            if (DbbackUtils.exportDatabaseTool(Global.LOCALPATH, Global.getConfig("jdbc.username"), Global.getConfig("jdbc.password"), backFilePath, backFileName , Global.getConfig("jdbc.back.database"))) {  
            	logger.info("-------------数据库成功备份！！！-------------");
            } else {
            	logger.info("-------------数据库备份失败！！！-------------");
            }
        } catch (InterruptedException e) {  
            e.printStackTrace();  
        }  
		sysDbbackup.setFileName(backFileName);
		sysDbbackup.setFilePath(backFilePath);
		sysDbbackupService.save(sysDbbackup);
		addMessage(redirectAttributes, "数据库备份成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysDbbackup/?repage";
	}
	
	@RequiresPermissions("sys:sysDbbackup:edit")
	@RequestMapping(value = "delete")
	public String delete(SysDbbackup sysDbbackup, RedirectAttributes redirectAttributes) {
		sysDbbackupService.delete(sysDbbackup);
		addMessage(redirectAttributes, "删除数据库备份成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysDbbackup/?repage";
	}
	
	@RequiresPermissions("sys:sysDbbackup:view")
	@RequestMapping(value = "hy")
	public String hy(SysDbbackup sysDbbackup, Model model, RedirectAttributes redirectAttributes) throws IOException {
		
		String fileName = sysDbbackup.getFileName();
		String filePath = sysDbbackup.getFilePath();
        try {  
            if (DbbackUtils.recover(filePath+"\\"+fileName)){  
            	logger.info("-------------数据库还原成功！！！-------------");
            } else {
            	logger.info("-------------数据库还原失败！！！-------------");
            }
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
		addMessage(redirectAttributes, "数据库还原成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysDbbackup/?repage";
	}
}