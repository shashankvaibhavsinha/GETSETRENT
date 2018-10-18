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
		String ename=request.getParameter("ename");
		String econtact=request.getParameter("econtact");
		String esex=request.getParameter("esex");
		String eaddress=request.getParameter("eaddress");
		String ecity=request.getParameter("ecity");
		String estate=request.getParameter("estate");
		String ecountry=request.getParameter("ecountry");
		String efacebook=request.getParameter("efacebook");
		String einstagram=request.getParameter("einstagram");
		String etwitter=request.getParameter("etwitter");
		String elinkedin=request.getParameter("elinkedin");
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
			/* PreparedStatement pre = conn.prepareStatement("UPDATE LGUSER SET password = '" +rnewpass+ "' where password = '"+oldpass + "' AND id = "+sid);
			pre.executeUpdate();
			pre.close(); */
			Statement st = conn.createStatement();
		    ResultSet rs = st.executeQuery("Select * from LGPROFILE where U_ID = "+sid);
		    if(rs.next())
		    {
		    	PreparedStatement pre = conn.prepareStatement("UPDATE LGPROFILE SET contact='"+econtact+"',sex='"+esex.toUpperCase()+"',address='"+eaddress.toUpperCase()+"',city='"+ecity.toUpperCase()+"',state='"+estate.toUpperCase()+"',country='"+ecountry.toUpperCase()+"',s_facebook='"+efacebook+"',s_instagram='"+einstagram+"',s_twiter='"+etwitter+"',s_linkedin='"+elinkedin+"' where U_ID = "+sid);
				pre.executeUpdate();
				pre.close();
		    	response.sendRedirect("dashboard.jsp");
		    }
		    else{
		    	PreparedStatement stmt= conn.prepareStatement("insert into LGPROFILE values(LGPROFILE_SEQ.nextval,?,?,?,?,?,?,?,?,?,?,?)");  
		    	stmt.setInt(1,sid);
				stmt.setString(2,econtact);
				stmt.setString(3,esex.toUpperCase());
				stmt.setString(4,eaddress.toUpperCase());
				stmt.setString(5,ecity.toUpperCase());
				stmt.setString(6,estate.toUpperCase());
				stmt.setString(7,ecountry.toUpperCase());
				stmt.setString(8,efacebook);
				stmt.setString(9,einstagram);
				stmt.setString(10,etwitter);
				stmt.setString(11,elinkedin);
				int i=stmt.executeUpdate(); 
				if(i==1){
					out.println("Data Updated is successfully inserted!");
					response.sendRedirect("dashboard.jsp");
				}else{
					out.println("Some Error Occur in updating data");
					response.sendRedirect("dashboard.jsp");
				}
		    }
		}
		catch(Exception e){
			out.println(e);
		}
	    
    }
%>