/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.gen.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.gen.entity.GenTemplate;

/**
 * 代码模板DAO接口
 * @author zmrid
 * @version 2016-10-15
 */
@MyBatisDao
public interface GenTemplateDao extends CrudDao<GenTemplate> {
	
}
