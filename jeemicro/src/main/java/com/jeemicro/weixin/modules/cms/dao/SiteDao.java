/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.Site;

/**
 * 站点DAO接口
 * @author zmrid
 * @version 2016
 */
@MyBatisDao
public interface SiteDao extends CrudDao<Site> {

}
