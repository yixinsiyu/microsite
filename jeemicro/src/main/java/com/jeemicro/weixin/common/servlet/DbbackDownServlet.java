package com.jeemicro.weixin.common.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * 数据库备份下载Servlet
 * @author ZT
 * @version 2017-05-16
 */
public class DbbackDownServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());

	public void fileOutputStream(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String filename = request.getParameter("filename");		// 获得请求文件名
		logger.info("-----------下载数据库备份：" + filename + "-----------");
		response.setContentType(getServletContext().getMimeType(filename));	 // 设置文件MIME类型
		response.setHeader("Content-Disposition", "attachment;filename=" + filename);// 设置Content-Disposition
		// 读取目标文件，通过response将目标文件写到客户端
		// 获取目标文件的绝对路径
		String fullFileName = getServletContext().getRealPath("/db/" + filename);
		InputStream in = new FileInputStream(fullFileName);		// 读取文件
		OutputStream out = response.getOutputStream();
		int b;
		while ((b = in.read()) != -1) {
			out.write(b);
		}
		in.close();
		out.close();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fileOutputStream(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fileOutputStream(request, response);
	}
}
