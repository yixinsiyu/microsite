package com.jeemicro.weixin.common.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jeemicro.weixin.common.config.Global;



public class DbhyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String filename = request.getParameter("filename");		// 获得请求文件名
		String targetFile = getServletContext().getRealPath("/db/" + filename);
		
	    String[] execCMD = new String[]{Global.getConfig("jdbc.hy.path"), Global.getConfig("jdbc.back.database") , "-u" + Global.getConfig("jdbc.username") , "-p" + Global.getConfig("jdbc.password"), "-e source", targetFile};
	    Process process = Runtime.getRuntime().exec(execCMD);

	    int processComplete = 0;
		try {
			processComplete = process.waitFor();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	    if (processComplete == 0) {
	        System.out.println("还原成功.");
	    } else {
	        throw new RuntimeException("还原数据库失败.");
	    }
	}
}
