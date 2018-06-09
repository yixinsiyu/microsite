/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.web.front;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeemicro.weixin.common.web.BaseController;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;
import com.jeemicro.weixin.modules.cms.service.OaYuangongService;

/**
 * 网站搜索Controller
 * @author zmrid
 * @version 2016-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}/search")
public class FrontSearchController extends BaseController{
	
	@Autowired
	private OaYuangongService oaYuangongService;

	@RequestMapping(value = "")
	public String search(OaYuangong oaYuangong, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<OaYuangong> list = oaYuangongService.findListForFront(oaYuangong); 
		model.addAttribute("page", list);
		return "modules/cms/front/themes/basic/frontSearch";
	}
}
