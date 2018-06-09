/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.jeemicro.weixin.common.persistence.DataEntity;
import com.jeemicro.weixin.common.utils.IdGen;
import com.jeemicro.weixin.modules.sys.entity.User;

/**
 * 报名Entity
 * @author zmrid
 * @version 2017-07-17
 */
public class Baoming extends DataEntity<Baoming> {
	
	private static final long serialVersionUID = 1L;
	private String huodong; 	// 报名项目
	private String content; // 报名内容
	private String name; 	// 姓名
	private String phone; 	// 电话
	private String workunit;// 单位
	private String ip; 		// 留言IP
	private Date createDate;// 留言时间
	private User reUser; 		// 回复人
	private Date reDate;	// 回复时间
	private int reContent;// 回复内容
	private String delFlag;	// 删除标记删除标记（0：正常；1：删除；2：审核）

	public Baoming() {
		this.delFlag = DEL_FLAG_AUDIT;
	}

	public Baoming(String id){
		this();
		this.id = id;
	}
	
	public void prePersist(){
		this.id = IdGen.uuid();
		this.createDate = new Date();
	}
	

	@Length(min=1, max=2000)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min=0, max=100)
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Length(min=0, max=100)
	public String getWorkunit() {
		return workunit;
	}

	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}

	@Length(min=1, max=100)
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	@NotNull
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public User getReUser() {
		return reUser;
	}

	public void setReUser(User reUser) {
		this.reUser = reUser;
	}

	public int getReContent() {
		return reContent;
	}

	public void setReContent(int reContent) {
		this.reContent = reContent;
	}

	public String getHuodong() {
		return huodong;
	}

	public void setHuodong(String huodong) {
		this.huodong = huodong;
	}

	public Date getReDate() {
		return reDate;
	}

	public void setReDate(Date reDate) {
		this.reDate = reDate;
	}

	@Length(min=1, max=1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	
}


