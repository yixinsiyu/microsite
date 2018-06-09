/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import java.util.List;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;

/**
 * 员工信息表DAO接口
 * @author zmrid
 * @version 2017-07-14
 */
@MyBatisDao
public interface OaYuangongDao extends CrudDao<OaYuangong> {
	/**
	 * 查询用户信息For前台
	 * @param oaYuangong
	 * @return
	 */
	public List<OaYuangong> findListForFront(OaYuangong oaYuangong);
}