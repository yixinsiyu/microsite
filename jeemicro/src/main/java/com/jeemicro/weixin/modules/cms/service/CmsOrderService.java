/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.dao.CmsOrderDao;

/**
 * 余票Service
 * @author h
 * @version 2018-04-05
 */
@Service
@Transactional(readOnly = true)
public class CmsOrderService extends CrudService<CmsOrderDao, CmsOrder> { 
	
	@Autowired
	CmsOrderDao cmsOrderDao;

	public CmsOrder get(String id) {
		return super.get(id);
	}
	
	public List<CmsOrder> findList(CmsOrder cmsOrder) {
		return super.findList(cmsOrder);
	}
	
	public Page<CmsOrder> findPage(Page<CmsOrder> page, CmsOrder cmsOrder) {
		return super.findPage(page, cmsOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(CmsOrder cmsOrder) {
		super.save(cmsOrder);
	}
	
	@Transactional(readOnly = false)
	public void update(CmsOrder cmsOrder) {
		cmsOrderDao.update(cmsOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmsOrder cmsOrder) {
		super.delete(cmsOrder);
	}
	
}