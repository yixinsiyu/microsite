/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.cms.dao.OaYuangongDao;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;

/**
 * 员工信息表Service
 * @author zmrid
 * @version 2017-07-14
 */
@Service
@Transactional(readOnly = true)
public class OaYuangongService extends CrudService<OaYuangongDao, OaYuangong> {

	public OaYuangong get(String id) {
		return super.get(id);
	}
	
	public List<OaYuangong> findList(OaYuangong oaYuangong) {
		return super.findList(oaYuangong);
	}
	
	//查询用户信息列表For前台
	public List<OaYuangong> findListForFront(OaYuangong oaYuangong) {
		return dao.findListForFront(oaYuangong);
	}
	
	public Page<OaYuangong> findPage(Page<OaYuangong> page, OaYuangong oaYuangong) {
		return super.findPage(page, oaYuangong);
	}
	
	@Transactional(readOnly = false)
	public void save(OaYuangong oaYuangong) {
		super.save(oaYuangong);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaYuangong oaYuangong) {
		super.delete(oaYuangong);
	}
	
}