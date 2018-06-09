/**
 * Copyright ZT All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.sys.entity.SysDbbackup;
import com.jeemicro.weixin.modules.sys.dao.SysDbbackupDao;

/**
 * 数据库备份Service
 * @author ZT
 * @version 2017-05-15
 */
@Service
@Transactional(readOnly = true)
public class SysDbbackupService extends CrudService<SysDbbackupDao, SysDbbackup> {
	
	@Autowired
	private SysDbbackupDao sysDbbackupDao;
	public SysDbbackup get(String id) {
		return super.get(id);
	}
	
	public List<SysDbbackup> findList(SysDbbackup sysDbbackup) {
		return super.findList(sysDbbackup);
	}
	
	public Page<SysDbbackup> findPage(Page<SysDbbackup> page, SysDbbackup sysDbbackup) {
		sysDbbackup.getSqlMap().put("dsf", dataScopeFilter(sysDbbackup.getCurrentUser(), "o", "s"));
		// 设置分页参数
		sysDbbackup.setPage(page);
				// 执行分页查询
				page.setList(sysDbbackupDao.findList(sysDbbackup));
				return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SysDbbackup sysDbbackup) {
		super.save(sysDbbackup);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysDbbackup sysDbbackup) {
		super.delete(sysDbbackup);
	}
	
}