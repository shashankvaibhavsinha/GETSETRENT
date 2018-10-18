<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String name=request.getParameter("name");
	String username=request.getParameter("username");
	String emailid=request.getParameter("emailid");
	String password=request.getParameter("password");
	String cpassword=request.getParameter("cpassword");
	
	long time = System.currentTimeMillis();
	java.sql.Timestamp timestamp = new java.sql.Timestamp(time);
	//System.out.println("Time in milliseconds :" + timestamp);
	//out.println(name+username+emailid+password+cpassword);
	String status = "1";
	if(password.equals(cpassword))
	{
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
			PreparedStatement stmt= conn.prepareStatement("insert into LGUSER values(LGUSER_SEQ.nextval,?,?,?,?,?,?)");  
			stmt.setString(1,name);
			stmt.setString(2,username);
			stmt.setString(3,emailid);
			stmt.setString(4,password);
			stmt.setString(5,status);
			stmt.setTimestamp(6,timestamp);
			int i=stmt.executeUpdate();  
			out.println("Data is successfully inserted!");
			response.sendRedirect("index.html");
		}
		catch(Exception e){
			out.println(e);
		}
	}
	else
	{
		response.sendRedirect("index.html");
	}
	
%>