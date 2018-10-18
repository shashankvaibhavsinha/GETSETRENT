<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int renter_id= Integer.parseInt(request.getParameter("renter_id"));
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
		Statement st = conn.createStatement();
		Statement st1 = conn.createStatement();
		ResultSet rs = st.executeQuery("Select * from LGRENTER where id="+renter_id);
	    if(rs.next()){
	    	int rentee_id = rs.getInt("rentee_id");
	    	String status = rs.getString("status");
	    	ResultSet rs1 = st1.executeQuery("Select * from LGRENTEE where id="+rentee_id);
		    if(rs1.next()){
		    	String owner_name = rs1.getString("owner_name");
		    	String owner_contact = rs1.getString("owner_contact");
		    	String house_address = rs1.getString("house_address");
		    	String city = rs1.getString("city");
		    	String state = rs1.getString("state");
		    	String longitude = rs1.getString("longitude");
		    	String latitute = rs1.getString("latitute");
		    	String house_type = rs1.getString("house_type");
		    	String rent_amount = rs1.getString("rent_amount");
		    	out.print(owner_name+"$"+owner_contact+"$"+house_address+"$"+city+"$"+state+"$"+longitude+"$"+latitute+"$"+house_type+"$"+rent_amount+"$"+status);
		    }
	    }
	}
	catch(Exception e){
		out.println(e);
	}
	
%>