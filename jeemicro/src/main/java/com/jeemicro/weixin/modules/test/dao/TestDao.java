/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.test.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.test.entity.Test;

/**
 * 测试DAO接口
 * @author zmrid
 * @version 2016-10-17
 */
@MyBatisDao
public interface TestDao extends CrudDao<Test> {
	
}
