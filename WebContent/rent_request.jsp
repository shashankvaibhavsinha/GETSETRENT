<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int renter_id= Integer.parseInt(request.getParameter("renter_id"));
	int status= Integer.parseInt(request.getParameter("status"));
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
		if(status==0){
			PreparedStatement pre= conn.prepareStatement("Update LGRENTER SET status = 'REMOVED' where id="+renter_id);  
			pre.executeUpdate();
			pre.close();
		}else{
			PreparedStatement pre= conn.prepareStatement("Update LGRENTER SET status = 'APPROVED' where id="+renter_id);  
			pre.executeUpdate();
			pre.close();
		}
	}
	catch(Exception e){
		out.println(e);
	}
%>