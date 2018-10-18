<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		HttpSession ss = request.getSession();  
		if (ss != null) {
			ss.removeAttribute("id");
			ss.removeAttribute("name");
			ss.invalidate();
			response.sendRedirect("index.html");
		}
	%>
</body>
</html>