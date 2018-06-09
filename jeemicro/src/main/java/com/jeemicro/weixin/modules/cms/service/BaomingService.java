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
import com.jeemicro.weixin.modules.cms.dao.BaomingDao;
import com.jeemicro.weixin.modules.cms.entity.Baoming;
import com.jeemicro.weixin.modules.cms.entity.CmsCancleOrder;
import com.jeemicro.weixin.modules.cms.entity.CmsHuiyuan;
import com.jeemicro.weixin.modules.cms.entity.CmsOrder;
import com.jeemicro.weixin.modules.cms.entity.OaYuangong;

/**
 * 在线报名Service
 * @author zmrid
 * @version 2017-07-15
 */
@Service
@Transactional(readOnly = true)
public class BaomingService extends CrudService<BaomingDao, Baoming> {

	@Autowired
	private CmsOrderService cmsOrderService;
	@Autowired
	private CmsCancleOrderService cmsCancleOrderService;
	public Baoming get(String id) {
		return dao.get(id);
	}
	
	public Page<Baoming> findPage(Page<Baoming> page, Baoming baoming) {

		baoming.getSqlMap().put("dsf", dataScopeFilter(baoming.getCurrentUser(), "o", "u"));
		baoming.setPage(page);
		page.setList(dao.findList(baoming));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void delete(Baoming baoming, Boolean isRe) {
		//dao.updateDelFlag(id, isRe!=null&&isRe?Guestbook.DEL_FLAG_AUDIT:Guestbook.DEL_FLAG_DELETE);
		dao.delete(baoming);
	}
	
	/**
	 * 更新索引
	 */
	public void createIndex(){
		//dao.createIndex();
	}
	
	/**
	 * 全文检索
	 */
	//FIXME 暂不提供
	public Page<Baoming> search(Page<Baoming> page, String q, String beginDate, String endDate){

		return page;
	}
	
	
	/**
	 * 删除数据
	 * @param entity
	 * @throws Exception 
	 */
	@Transactional(readOnly = false)
	public synchronized void saveB(Baoming baoming,CmsOrder order) throws Exception {
		logger.info("当前线程 {}", Thread.currentThread().getName()+"baoming-->"+baoming.getHuodong());
		try{
			Baoming baoming1=this.get(baoming.getPhone());
			if(baoming1!=null){
				if("1".equals(baoming1.getDelFlag())){
					dao.update(baoming);//状态变更。
					cmsOrderService.update(order);//漂亮减少
					
				}
				logger.info("重新报名{},{}"+baoming.getPhone()+" sta:"+baoming.getDelFlag());
			}else{
				dao.insert(baoming);//新增
				cmsOrderService.update(order);//漂亮减少
				logger.info("首次报名"+baoming.getPhone());
			}
		}catch(Exception e){
			logger.error("报名异常"+baoming.getPhone());
			throw e;
		}
		
		
	}
	
	/**
	 * 删除数据
	 * @param entity
	 * @throws Exception 
	 */
	@Transactional(readOnly = false)
	public synchronized void updateB(Baoming baoming,CmsCancleOrder order) throws Exception {
		try{
			dao.update(baoming);//更新
			cmsCancleOrderService.update(order);//漂亮增加
		}catch(Exception e){
			logger.error("取消异常"+baoming.getPhone());
			throw e;
		}
		
	}
	
	public int getMaxOrderByDate(String date,String workunit){
		Integer count=dao.getMaxOrderByDate(date,workunit);
	    if(count==null){
	    	return 0;
	    }
		return count;
	}
}
