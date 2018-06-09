/**
 * Copyright ZT All rights reserved.
 */
package com.jeemicro.weixin.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.jeemicro.weixin.common.persistence.DataEntity;

/**
 * 数据库备份Entity
 * @author ZT
 * @version 2017-05-15
 */
public class SysDbbackup extends DataEntity<SysDbbackup> {
	
	private static final long serialVersionUID = 1L;
	private String dbName;		// 数据库名称
	private String fileName;		// 文件名称
	private String filePath;		// 文件地址
	
	public SysDbbackup() {
		super();
	}

	public SysDbbackup(String id){
		super(id);
	}

	@Length(min=1, max=255, message="数据库名称长度必须介于 1 和 255 之间")
	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	
	@Length(min=1, max=255, message="文件名称长度必须介于 1 和 255 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=1, max=500, message="文件地址长度必须介于 1 和 500 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}