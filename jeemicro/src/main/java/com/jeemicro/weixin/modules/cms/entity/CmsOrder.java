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
 * 余票Entity
 * @author h
 * @version 2018-04-05
 */
public class CmsOrder extends DataEntity<CmsOrder> {
	
	private static final long serialVersionUID = 1L;
	private Date orderTime;		// 时间
	private int orderMp;		// 上午余票
	private int orderAp;		// 下午余票
	private int orderTotal;
	private int orderMpTotal;
	public int getOrderMpTotal() {
		return orderMpTotal;
	}

	public void setOrderMpTotal(int orderMpTotal) {
		this.orderMpTotal = orderMpTotal;
	}

	private int orderVersion;
	
	public int getOrderVersion() {
		return orderVersion;
	}

	public void setOrderVersion(int orderVersion) {
		this.orderVersion = orderVersion;
	}

	public int getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(int orderTotal) {
		this.orderTotal = orderTotal;
	}

	public CmsOrder() {
		super();
	}

	public CmsOrder(String id){
		super(id);
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="时间不能为空")
	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	
	
	public int getOrderMp() {
		return orderMp;
	}

	public void setOrderMp(int orderMp) {
		this.orderMp = orderMp;
	}
	
	
	public int getOrderAp() {
		return orderAp;
	}

	public void setOrderAp(int orderAp) {
		this.orderAp = orderAp;
	}
	
}