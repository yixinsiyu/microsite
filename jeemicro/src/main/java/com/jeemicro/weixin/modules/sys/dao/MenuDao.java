/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.dao;

import java.util.List;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author zmrid
 * @version 2016-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);
	
	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
}
