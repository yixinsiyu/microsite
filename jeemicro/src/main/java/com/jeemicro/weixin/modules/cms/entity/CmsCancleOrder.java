/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.jeemicro.weixin.common.persistence.DataEntity;

/**
 * 撤销票Entity
 * @author quxiao
 * @version 2018-05-07
 */
public class CmsCancleOrder extends DataEntity<CmsCancleOrder> {
	
	private static final long serialVersionUID = 1L;
	private Date orderTime;		// 取消时间
	private String orderMp;		// 上午取消数
	private String orderAp;		// 下午取消数
	private String orderTotal;		// 总数
	private String orderVersion;		// version
	
	public CmsCancleOrder() {
		super();
	}

	public CmsCancleOrder(String id){
		super(id);
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="取消时间不能为空")
	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	
	@Length(min=0, max=11, message="上午取消数长度必须介于 0 和 11 之间")
	public String getOrderMp() {
		return orderMp;
	}

	public void setOrderMp(String orderMp) {
		this.orderMp = orderMp;
	}
	
	@Length(min=0, max=11, message="下午取消数长度必须介于 0 和 11 之间")
	public String getOrderAp() {
		return orderAp;
	}

	public void setOrderAp(String orderAp) {
		this.orderAp = orderAp;
	}
	
	@Length(min=0, max=11, message="总数长度必须介于 0 和 11 之间")
	public String getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(String orderTotal) {
		this.orderTotal = orderTotal;
	}
	
	@Length(min=0, max=11, message="version长度必须介于 0 和 11 之间")
	public String getOrderVersion() {
		return orderVersion;
	}

	public void setOrderVersion(String orderVersion) {
		this.orderVersion = orderVersion;
	}
	
}