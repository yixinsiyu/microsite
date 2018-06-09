/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeemicro.weixin.common.persistence.Page;
import com.jeemicro.weixin.common.service.CrudService;
import com.jeemicro.weixin.modules.cms.dao.CmsHuiyuanDao;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.sys.entity.Office;
import com.jeemicro.weixin.modules.sys.entity.Role;
import com.jeemicro.weixin.modules.sys.entity.User;
import com.jeemicro.weixin.modules.sys.service.SystemService;

/**
 * 会员管理Service
 * @author zmrid
 * @version 2017-07-18
 */
@Service
@Transactional(readOnly = true)
public class CmsHuiyuanService extends CrudService<CmsHuiyuanDao, CmsHuiyuan> {
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private CmsHuiyuanDao cmsHuiyuanDao;
	public CmsHuiyuan get(String id) {
		return super.get(id);
	}
	
	public List<CmsHuiyuan> findList(CmsHuiyuan cmsHuiyuan) {
		return super.findList(cmsHuiyuan);
	}
	
	public Page<CmsHuiyuan> findPage(Page<CmsHuiyuan> page, CmsHuiyuan cmsHuiyuan) {
		return super.findPage(page, cmsHuiyuan);
	}
	
	@Transactional(readOnly = false)
	public void save(CmsHuiyuan cmsHuiyuan) {
		try {
			Office company = new Office();
			company.setId("1");
			User user = new User();
			user.setCompany(company);
			Office office = new Office();
			office.setId("2");
			user.setOffice(office);
			user.setUserType("1");
			//user.setLoginName(cmsHuiyuan.getMobile());
			user.setLoginName(cmsHuiyuan.getCardnum());
			user.setName(cmsHuiyuan.getUsername());
			user.setPhone(cmsHuiyuan.getMobile());
			//user.setIdentyNo(cmCustomerInfo.geti);
			//user.set
			user.setPassword(systemService.entryptPassword(cmsHuiyuan.getPassword()));
			/*for(int i=1;i<3;i++){
				Role role = new Role();
				role.setId(new Integer(i).toString());
				user.getRoleList().add(role);
			}*/
			
			Role role = new Role();
			role.setId("f1572642a5454d2f981712db26ba24e0");
			user.getRoleList().add(role);
			
			
			systemService.saveUser(user);
			
			
			super.save(cmsHuiyuan);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
	}
	@Transactional(readOnly = false)
	public void saveRegisterInfo(CmsHuiyuan cmsHuiyuan) throws Exception  {
		try {
			Office company = new Office();
			company.setId("1");
			User user = new User();
			user.setCompany(company);
			Office office = new Office();
			office.setId("2");
			user.setOffice(office);
			user.setUserType("1");
			//user.setLoginName(cmsHuiyuan.getMobile());
			user.setLoginName(cmsHuiyuan.getCardnum());
			user.setName(cmsHuiyuan.getUsername());
			user.setPhone(cmsHuiyuan.getMobile());
			//user.setIdentyNo(cmCustomerInfo.geti);
			//user.set
			user.setPassword(systemService.entryptPassword(cmsHuiyuan.getPassword()));
			/*for(int i=1;i<3;i++){
				Role role = new Role();
				role.setId(new Integer(i).toString());
				user.getRoleList().add(role);
			}*/
			
			Role role = new Role();
			role.setId("f1572642a5454d2f981712db26ba24e0");
			user.getRoleList().add(role);
			
			
			systemService.saveUser(user);
			
			super.save(cmsHuiyuan);
			
		} catch (Exception e) {
			logger.error("注册异常  {},id {}", e.getMessage(),cmsHuiyuan.getCardnum());
			throw e;
			
		}
		
		
	}
	
	
	@Transactional(readOnly = false)
	public void delete(CmsHuiyuan cmsHuiyuan) {
		super.delete(cmsHuiyuan);
	}
	
	public List<CmsHuiyuan> findListByOpenid(String openid) {
		return dao.findListByOpenid(openid);
	}
	//老会员激活
	@Transactional(readOnly = false)
	public int lhyjh(CmsHuiyuan cmsHuiyuan) {
		
			return dao.lhyjh(cmsHuiyuan);
		}
	
	public CmsHuiyuan getByMobile(String mobile){
		return dao.getByMobile(mobile);
	}
	public CmsHuiyuan getByCertNum(String certNum){
		return dao.getByCertNum(certNum);
	}
	
	@Transactional(readOnly = false)
	public void update(CmsHuiyuan cmsHuiyuan) {
		cmsHuiyuanDao.update(cmsHuiyuan);
	}
}