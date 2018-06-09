/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import java.util.List;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.Baoming;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;

/**
 * 在线报名DAO接口
 * @author zmrid
 * @version 2017
 */
@MyBatisDao
public interface BaomingDao extends CrudDao<Baoming> {
	
	public Integer getMaxOrderByDate(String createDate,String workunit);
	
	
}
