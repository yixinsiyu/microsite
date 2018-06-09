/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;

/**
 * 余票DAO接口
 * @author h
 * @version 2018-04-05
 */
@MyBatisDao
public interface CmsOrderDao extends CrudDao<CmsOrder> {
	
}