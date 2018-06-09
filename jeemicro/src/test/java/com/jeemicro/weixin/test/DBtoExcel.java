package com.jeemicro.weixin.test;

import java.io.File;   
import jxl.*;   
import jxl.write.*;  
import jxl.write.biff.RowsExceededException;  
import java.sql.*;  
import java.util.*; 


public class DBtoExcel {

	static Map map = new HashMap();
	Map map1 = new HashMap();
	/** 
   * 导出Excel表 
   * @param rs 数据库结果集 
   * @param filePath 要保存的路径，文件名为 fileName.xls 
   * @param sheetName 工作簿名称 工作簿名称，本方法目前只支持导出一个Excel工作簿 
   * @param columnName 列名，类型为Vector 
   */  
  public void WriteExcel(ResultSet rs, String filePath, String sheetName, Vector columnName) {  
      WritableWorkbook workbook = null;  
      WritableSheet sheet = null;  
      map1.put("ap", "下午");
      map1.put("mp", "上午");
        
      int rowNum = 1; // 从第一行开始写入  
      try {  
          workbook = Workbook.createWorkbook(new File(filePath)); // 创建Excel文件  
          sheet = workbook.createSheet(sheetName, 0); // 创建名为 sheetName 的工作簿    
            
          this.writeCol(sheet, columnName, 0); // 首先将列名写入  
          // 将结果集写入  
          while(rs.next()) {  
              Vector col = new Vector(); // 用以保存一行数据  
                
              for(int i = 1; i <= columnName.size(); i++) { // 将一行内容保存在col中  
                  
                  if(i==7){
                	  col.add(map.get(rs.getString(i)));
                  }else if(i==3){
                	  col.add(map1.get(rs.getString(i)));
                  }else{
                	  col.add(rs.getString(i));  
                  }
                  
              }  
              // 写入Excel  
              this.writeCol(sheet, col, rowNum++);  
          }  
            
      }catch(Exception e) {  
          e.printStackTrace();  
      }  
      finally {  
          try {  
              // 关闭  
              workbook.write();  
              workbook.close();  
              rs.close();  
          }catch(Exception e) {  
              e.printStackTrace();  
          }  
      }  
  }
  /*** 
   * 将数组写入工作簿  
   * @param sheet 要写入的工作簿 
   * @param col 要写入的数据数组 
   * @param rowNum 要写入哪一行 
   * @throws WriteException  
   * @throws RowsExceededException  
   */  
  private void writeCol(WritableSheet sheet, Vector col, int rowNum) throws RowsExceededException, WriteException {  
      int size = col.size(); // 获取集合大小  
        
      for(int i = 0; i < size; i++) { // 写入每一列  
          Label label = new Label(i, rowNum, (String) col.get(i));   
          sheet.addCell(label);  
      }  
  }
  
  public static void main(String[] args) throws SQLException {
		
		String sql1 ="select value,label from sys_dict where type='sycp_type'";
		
  	String DRIVER = "com.mysql.jdbc.Driver";  
      String URL = "jdbc:mysql://120.27.17.97:3306/jeemicro";//根据自己的数据库设置路径和用户名密码
      String USERNAME = "root";  
      String USERPASSWORD = "Atos123$";  
        
      String sql = "select '',cms_baoming.create_date,cms_baoming.workunit,cms_baoming.huodong,cms_huiyuan.username,"
      +" cms_huiyuan.cardnum,cms_huiyuan.sycp,cms_huiyuan.gzdw,cms_huiyuan.tjr,cms_huiyuan.mobile,cms_huiyuan.dengji,cms_huiyuan.openid,cms_huiyuan.remarks"
  +" from cms_huiyuan, cms_baoming"
+"  where cms_huiyuan.mobile = cms_baoming.phone and DATE_FORMAT(cms_baoming.create_date,'%Y-%m-%d')='2018-05-24' and cms_baoming.del_flag='2' and cms_baoming.workunit='ap'"
+ " order by cms_baoming.huodong;"; // 根据自己的要求书写sql语句  
      Vector columnName = new Vector(); // 列名   
      //columnName.add("顺序号");  
      columnName.add("档案号");
      columnName.add("预约日期");   
      columnName.add("上下午");   
      columnName.add("预约顺序号");   
      columnName.add("孩子姓名");   
      columnName.add("身份证号码"); 
      columnName.add("所在村居"); 
      columnName.add("详细地址"); 
      columnName.add("房东姓名"); 
      columnName.add("房东电话"); 
      columnName.add("监护人姓名"); 
      columnName.add("监护人电话"); 
      columnName.add("监护人电话2"); 
      
      // 连接数据库  
      ResultSet rs1 ; 
      try {
			Class.forName(DRIVER);
			Connection conn = DriverManager.getConnection(URL,USERNAME,USERPASSWORD);  
	        PreparedStatement ps = conn.prepareStatement(sql1);  
	        rs1 = ps.executeQuery();

	        while(rs1.next()){
	        	            System.out.println(rs1.getString("value")+" "
	        	                           +rs1.getString("label"));
	        	            map.put(rs1.getString("value"), rs1.getString("label"));
	         }
	      
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}               
      
           // 连接数据库  
      ResultSet rs ; 
      try {
			Class.forName(DRIVER);
			Connection conn = DriverManager.getConnection(URL,USERNAME,USERPASSWORD);  
	        PreparedStatement ps = conn.prepareStatement(sql);  
	        rs = ps.executeQuery();
	     // 导出文件的路径和工作簿名称都可根据自己的需求修改
	        new DBtoExcel().WriteExcel(rs, "d:/data/day24-ap.xls", "访问记录", columnName);
	      
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}                 
	}
}