<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int renter_id= Integer.parseInt(request.getParameter("renter_id"));
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
		Statement stmt = conn.createStatement();
		String sql = "DELETE FROM LGRENTER WHERE id = "+renter_id;
   		stmt.executeUpdate(sql);
	}
	catch(Exception e){
		out.println(e);
	}
%>