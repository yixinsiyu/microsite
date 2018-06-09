/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.service.TreeService;
import com.jeemicro.weixin.modules.sys.dao.AreaDao;
import com.jeemicro.weixin.modules.sys.entity.Area;
import com.jeemicro.weixin.modules.sys.utils.UserUtils;

/**
 * 区域Service
 * @author zmrid
 * @version 2016-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {

	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
}