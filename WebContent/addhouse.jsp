<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	HttpSession ss=request.getSession(false);  
    if(ss!=null)
    {  
    	int sid=(int)ss.getAttribute("id");
    	String name=(String)ss.getAttribute("name");
        //out.print(name);
		String owner=request.getParameter("owner");
		String address=request.getParameter("address");
		String contact=request.getParameter("contact");
		String lat=request.getParameter("lat");
		String lng=request.getParameter("long");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		String housetype=request.getParameter("housetype");
		String amount=request.getParameter("amount");
		long time = System.currentTimeMillis();
		java.sql.Timestamp timestamp = new java.sql.Timestamp(time);
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
			PreparedStatement stmt= conn.prepareStatement("insert into LGRENTEE values(LGRENTEE_SEQ.nextval,?,?,?,?,?,?,?,?,?,?,?,?)");  
	    	stmt.setInt(1,sid);
			stmt.setString(2,owner.toUpperCase());
			stmt.setString(3,address.toUpperCase());
			stmt.setString(4,contact.toUpperCase());
			stmt.setString(5,lng);
			stmt.setString(6,lat);
			stmt.setString(7,housetype.toUpperCase());
			stmt.setString(8,amount);
			stmt.setTimestamp(9,timestamp);
			stmt.setString(10,"ACTIVE");
			stmt.setString(11,city.toUpperCase());
			stmt.setString(12,state.toUpperCase());
			int i=stmt.executeUpdate(); 
			if(i==1){
				out.println("Data Updated is successfully inserted!");
				response.sendRedirect("dashboard.jsp");
			}else{
				out.println("Some Error Occur in updating data");
				response.sendRedirect("dashboard.jsp");
			}
		}
		catch(Exception e){
			out.println(e);
		}
	    
    }
%>