package com.jeemicro.weixin.common.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jeemicro.weixin.common.config.Global;
import com.jeemicro.weixin.common.utils.HttpsGetUtil;

import net.sf.json.JSONObject;

public class Oauth2Servlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * The doGet method of the servlet. <br>
     * 
     * This method is called when a form has its tag value method equals to get.
     * 
     * @param request
     *            the request send by the client to the server
     * @param response
     *            the response send by the server to the client
     * @throws ServletException
     *             if an error occurred
     * @throws IOException
     *             if an error occurred
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //静默授权
        String get_access_token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
                + "appid="
                + Global.APPID
                + "&secret="
                + Global.APPSECRET
                + "&code=CODE&grant_type=authorization_code";

        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String code = request.getParameter("code");
        PrintWriter out = response.getWriter();
        //System.out.println("******************code=" + code);
        out.println("******************code="+code);
       
        String json = "";
    	try{
    		get_access_token_url = get_access_token_url.replace("CODE", code);
    		json = HttpsGetUtil.doHttpsGetJson(get_access_token_url);
			}catch(Exception e){
				 out.println("请在微信客户端打开");
			}
    	System.out.println(json);
        /*JSONObject jsonObject = JSONObject.fromObject(json);
        String openid = jsonObject.getString("openid");*/

        response.setContentType("text/html; charset=utf-8");
        
        out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
        out.println("  <BODY>");
        out.print("    This is ");
        out.print(this.getClass());
        out.println(", using the POST method \n");
        out.println("openid:" + json + "\n\n");
        out.println(">");
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

}