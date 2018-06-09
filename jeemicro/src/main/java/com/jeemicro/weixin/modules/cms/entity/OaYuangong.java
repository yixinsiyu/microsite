/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.entity;

import org.hibernate.validator.constraints.Length;

import com.jeemicro.weixin.common.persistence.DataEntity;

/**
 * 员工信息表Entity
 * @author zmrid
 * @version 2017-07-14
 */
public class OaYuangong extends DataEntity<OaYuangong> {
	
	private static final long serialVersionUID = 1L;
	private String phone;		// 电话
	private String username;		// 姓名
	private String picture;		// 照片
	private String zhiwu;		// 职务
	
	public OaYuangong() {
		super();
	}

	public OaYuangong(String id){
		super(id);
	}

	@Length(min=0, max=100, message="电话长度必须介于 0 和 100 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Length(min=0, max=100, message="姓名长度必须介于 0 和 100 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=0, max=100, message="照片长度必须介于 0 和 100 之间")
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	@Length(min=0, max=100, message="职务长度必须介于 0 和 100 之间")
	public String getZhiwu() {
		return zhiwu;
	}

	public void setZhiwu(String zhiwu) {
		this.zhiwu = zhiwu;
	}
	
}