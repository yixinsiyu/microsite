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
import com.jeemicro.weixin.modules.cms.entity.CmsCancleOrder;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.dao.CmsCancleOrderDao;

/**
 * 撤销票Service
 * @author quxiao
 * @version 2018-05-07
 */
@Service
@Transactional(readOnly = true)
public class CmsCancleOrderService extends CrudService<CmsCancleOrderDao, CmsCancleOrder> {

	@Autowired
	CmsCancleOrderDao cmsOrderDao;
	public CmsCancleOrder get(String id) {
		return super.get(id);
	}
	
	public List<CmsCancleOrder> findList(CmsCancleOrder cmsCancleOrder) {
		return super.findList(cmsCancleOrder);
	}
	
	public Page<CmsCancleOrder> findPage(Page<CmsCancleOrder> page, CmsCancleOrder cmsCancleOrder) {
		return super.findPage(page, cmsCancleOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(CmsCancleOrder cmsCancleOrder) {
		super.save(cmsCancleOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmsCancleOrder cmsCancleOrder) {
		super.delete(cmsCancleOrder);
	}
	
	@Transactional(readOnly = false)
	public void update(CmsCancleOrder cmsOrder) {
		cmsOrderDao.update(cmsOrder);
	}
	
}