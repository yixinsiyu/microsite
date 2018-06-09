/**
 * Copyright &copy; 2012-2016 < All rights reserved.
 */
package com.jeemicro.weixin.modules.cms.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.jeemicro.weixin.common.persistence.DataEntity;

/**
 * 会员管理Entity
 * @author zmrid
 * @version 2017-07-18
 */
public class CmsHuiyuan extends DataEntity<CmsHuiyuan> {
	
	private static final long serialVersionUID = 1L;
	
	private String username;		// 孩子姓名
	private String cardnum;          //孩子身份证号
	private String sycp;      //乡居名称
	private String gzdw;      //地址
	private String tjr;//房东姓名
	private String mobile;			// 房东电话
	
	private String dengji;//第一监护人
	private String openid;//第一监护人电话
	private String yzm;//第二监护人电话
	private String remarks;//第二监护人电话
	

	

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	private String password;		// 密码

	

	private String  sex;			//性别
	private Date 	shengri;		//生日

	public CmsHuiyuan() {
		super();
	}

	public CmsHuiyuan(String id){
		super(id);
	}

	@Length(min=1, max=192, message="mobile长度必须介于 1 和 192 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=1, max=300, message="username长度必须介于 1 和 300 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=1, max=300, message="password长度必须介于 1 和 300 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getYzm() {
		return yzm;
	}

	public void setYzm(String yzm) {
		this.yzm = yzm;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getCardnum() {
		return cardnum;
	}

	public void setCardnum(String cardnum) {
		this.cardnum = cardnum;
	}

	public String getDengji() {
		return dengji;
	}

	public void setDengji(String dengji) {
		this.dengji = dengji;
	}

	public String getGzdw() {
		return gzdw;
	}

	public void setGzdw(String gzdw) {
		this.gzdw = gzdw;
	}

	public String getTjr() {
		return tjr;
	}

	public void setTjr(String tjr) {
		this.tjr = tjr;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	

	public String getSycp() {
		return sycp;
	}

	public void setSycp(String sycp) {
		this.sycp = sycp;
	}

	public Date getShengri() {
		return shengri;
	}

	public void setShengri(Date shengri) {
		this.shengri = shengri;
	}
	
}