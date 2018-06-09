/**
 * Copyright ZT All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.dao;

import com.jeemicro.weixin.common.persistence.CrudDao;
import com.jeemicro.weixin.common.persistence.annotation.MyBatisDao;
import com.jeemicro.weixin.modules.sys.entity.SysDbbackup;

/**
 * 数据库备份DAO接口
 * @author ZT
 * @version 2017-05-15
 */
@MyBatisDao
public interface SysDbbackupDao extends CrudDao<SysDbbackup> {
	
}