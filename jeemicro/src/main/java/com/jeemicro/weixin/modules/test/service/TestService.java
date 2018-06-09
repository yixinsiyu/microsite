/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.test.dao.TestDao;
import com.jeemicro.weixin.modules.test.entity.Test;

/**
 * 测试Service
 * @author zmrid
 * @version 2016-10-17
 */
@Service
@Transactional(readOnly = true)
public class TestService extends CrudService<TestDao, Test> {

}
