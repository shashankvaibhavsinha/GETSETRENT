<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int rentee_id= Integer.parseInt(request.getParameter("rentee_id"));
	int uid= Integer.parseInt(request.getParameter("uid"));
	int rid= Integer.parseInt(request.getParameter("rid"));
	String status = "REQUESTED";
	int is_deleted = 0;
	long time = System.currentTimeMillis();
	java.sql.Timestamp timestamp = new java.sql.Timestamp(time);
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
		PreparedStatement stmt= conn.prepareStatement("insert into LGRENTER values(LGRENTER_SEQ.nextval,?,?,?,?,?,?)");  
    	stmt.setInt(1,rentee_id);
		stmt.setInt(2,uid);
		stmt.setInt(3,rid);
		stmt.setString(4,status);
		stmt.setInt(5,is_deleted);
		stmt.setTimestamp(6,timestamp);
		int i=stmt.executeUpdate(); 
		if(i==1){
			out.println("Data Updated is successfully inserted!");
		}else{
			out.println("Some Error Occur in updating data");
		}
	}
	catch(Exception e){
		out.println(e);
	}
%>