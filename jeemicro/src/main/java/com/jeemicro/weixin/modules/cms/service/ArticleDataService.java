/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.cms.dao.ArticleDataDao;
import com.jeemicro.weixin.modules.cms.entity.ArticleData;

/**
 * 站点Service
 * @author zmrid
 * @version 2016-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
