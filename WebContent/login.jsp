<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String login=request.getParameter("username");
	String password=request.getParameter("password");
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
		Statement st = conn.createStatement();
	    ResultSet rs = st.executeQuery("Select * from LGUSER where (username = '" + login + "' OR email = '" + login + "') AND password = '" + password + "'");
	    while(rs.next())
	    {
	    	int id = rs.getInt("id");
	    	String name = rs.getString("name");
	    	String email = rs.getString("email");
	    	out.println(id);
	    	out.println(name);
	    	HttpSession ss = request.getSession();  
	    	ss.setAttribute("id",id); 
	        ss.setAttribute("name",name);
	        ss.setAttribute("email",email);
	    	response.sendRedirect("dashboard.jsp");
	    }
			response.sendRedirect("index.html");
	}
	catch(Exception e){
		out.println(e);
	}		
%>