/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.dao;

import com.jeemicro.weixin.common.persistence.TreeDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * @author zmrid
 * @version 2016-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	
}
