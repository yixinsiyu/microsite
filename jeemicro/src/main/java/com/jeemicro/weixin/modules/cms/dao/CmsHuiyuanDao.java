/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.dao;

import java.util.List;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;

/**
 * 会员管理DAO接口
 * @author zmrid
 * @version 2017-07-18
 */
@MyBatisDao
public interface CmsHuiyuanDao extends CrudDao<CmsHuiyuan> {
	
	public List<CmsHuiyuan> findListByOpenid(String openid);
	public CmsHuiyuan getByMobile(String mobile);
	public CmsHuiyuan getByCertNum(String certNum);
	
	/**
	 * 老会员激活
	 * @param OaCounter
	 * @return
	 */
	public int lhyjh(CmsHuiyuan cmsHuiyuan);
}