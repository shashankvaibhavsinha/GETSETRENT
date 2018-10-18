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
		String oldpass=request.getParameter("oldpass");
		String newpass=request.getParameter("newpass");
		String rnewpass=request.getParameter("rnewpass");
		if(newpass.equals(rnewpass))
		{
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
				PreparedStatement pre = conn.prepareStatement("UPDATE LGUSER SET password = '" +rnewpass+ "' where password = '"+oldpass + "' AND id = "+sid);
				pre.executeUpdate();
				pre.close();
				out.println("<script>alert(1)</script>");
			}
			catch(Exception e){
				out.println(e);
			}
		}
	    response.sendRedirect("dashboard.jsp");
    }
%>