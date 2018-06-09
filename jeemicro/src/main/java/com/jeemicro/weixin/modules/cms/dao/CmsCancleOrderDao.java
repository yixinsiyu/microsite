/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.CmsCancleOrder;

/**
 * 撤销票DAO接口
 * @author quxiao
 * @version 2018-05-07
 */
@MyBatisDao
public interface CmsCancleOrderDao extends CrudDao<CmsCancleOrder> {
	
}