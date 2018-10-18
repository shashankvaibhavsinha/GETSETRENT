<%@page import="java.sql.*,java.util.*,javax.servlet.http.HttpServlet, javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
		HttpSession ss = request.getSession(false);  
		if (ss.getAttribute("id")!= null) {
		int sid=(int)ss.getAttribute("id");
		String nm=(String)ss.getAttribute("name");
		String email=(String)ss.getAttribute("email");
    	String name= nm.toUpperCase();
    	String contact = "";
    	String sex = "";
    	String address = "";
    	String city = "";
    	String state = "";
    	String country = "";
    	String facebook = "";
    	String instagram = "";
    	String twitter = "";
    	String linkedin = "";
    	try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
			Statement st = conn.createStatement();
		    ResultSet rs = st.executeQuery("Select * from LGPROFILE where U_ID = "+sid);
		    if(rs.next())
		    {
		    	if(rs.getString("contact")!= null)
		    		contact = rs.getString("contact");
		    	if(rs.getString("sex")!= null)
		    		sex = rs.getString("sex");
		    	if(rs.getString("address")!= null)
		    		address = rs.getString("address");
		    	if(rs.getString("city")!= null)
		    		city = rs.getString("city");
		    	if(rs.getString("state")!= null)
		    		state = rs.getString("state");
		    	if(rs.getString("country")!= null)
		    		country = rs.getString("country");
		    	if(rs.getString("s_facebook")!= null)
		    		facebook = rs.getString("s_facebook");
		    	if(rs.getString("s_instagram")!= null)
		    		instagram = rs.getString("s_instagram");
		    	if(rs.getString("s_twiter")!= null)
		    		twitter = rs.getString("s_twiter");
		    	if(rs.getString("s_linkedin")!= null)
		    		linkedin = rs.getString("s_linkedin");
		    }
    	}catch(Exception e){
			out.println(e);
		}
		
%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="logo2.png">
	<title>
		Dashboard
	</title>
<!-- ********************** -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="script.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="city_state.js"></script>
<!-- ********************** -->
</head>
<body>
<div class="loading" id="loading" style="display: none;">
		<img src="loading.svg" class="loading_icon">
	</div>
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <center>
	<img src="default.png" style="width: 52%; border-radius: 50%; background-color: #f9f9f9;">
  </center>
	  <a href="#" style="padding: 15% 10% 8% 10%;">
	  <%
	  	out.println(name);
	   %>
	  </a>
	  <a href="dashboard.jsp"><span class="glyphicon glyphicon-list"></span>&nbsp;DASHBOARD</a><a href="#profile" data-toggle="modal" data-target="#profile"><span class="glyphicon glyphicon-user"></span>&nbsp;MY PROFILE</a>
	  <a href="#" onclick="edit_profile();"><span class="glyphicon glyphicon-edit"></span>&nbsp;EDIT PROFILE</a>
	  <!-- <a href="#"><span class="glyphicon glyphicon-comment"></span>&nbsp;MESSAGES</a> -->
	  <a href="#"><span class="glyphicon glyphicon-plus"></span>&nbsp;ADD HOUSE</a>
	  <a href="#"><span class="glyphicon glyphicon-filter"></span>&nbsp;VIEW HOUSE</a>
	  <a href="#"><span class="glyphicon glyphicon-search"></span>&nbsp;SEARCH HOUSE</a>
	  <a href="#setting" data-toggle="modal" data-target="#setting"><span class="glyphicon glyphicon-wrench"></span>&nbsp;SETTING</a>
</div>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a id = "logoname" class="navbar-brand" href="#">
      	<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;
      		<img src="logo_name_gray.png" onmouseover="this.src = 'logo_name_white.png'" onmouseout="this.src = 'logo_name_gray.png'" style="width: 42%;">
      	</span>
      </a>

    </div>
    <!-- <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">Page 1-1</a></li>
          <li><a href="#">Page 1-2</a></li>
          <li><a href="#">Page 1-3</a></li>
        </ul>
      </li>
    </ul> -->
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#profile" data-toggle="modal" data-target="#profile"><span class="glyphicon glyphicon-user"></span>&nbsp; My Profile</a></li>
      <li><a href="signout.jsp"><span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp; Sign out</a></li>
    </ul>
    <!-- <ul class="nav navbar-nav navbar-right">
      <li>
      	<form class="navbar-form navbar-left" action="/action_page.php">
	      <div class="input-group">
	        <input type="text" class="form-control" placeholder="Search" name="search">
	        <div class="input-group-btn">
	          <button class="btn btn-default" type="submit">
	            <i class="glyphicon glyphicon-search"></i>
	          </button>
	        </div>
	      </div>
	    </form>
      </li>
    </ul> -->
  </div>
</nav>
<!----------------------------start Profile ------------------------>
<div class="modal fade" id="profile" tabindex="-1" role="dialog" aria-labelledby="profileModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
     <!--  <div class="modal-header"> -->
       <div class="modal-body">
        <!-- <h4 class="modal-title" id="exampleModalLongTitle"><b>My Profile</b>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button></h4> -->
     <!-- </div>
      <div class="modal-body"> -->
        <div class="row">
		  <div class="col-sm-9"><h1><% out.println(name);%></h1><hr></div>
		  <div class="col-sm-3"><img src="default.png" style="width: 100%; border-radius: 50%; background-color: #f9f9f9;"></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Email ID</div>
			<div class="col-sm-8"><% out.println(email);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Sex</div>
			<div class="col-sm-8"><% out.println(sex);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Contact No.</div>
			<div class="col-sm-8"><% out.println(contact);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Address</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(address);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">City</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(city);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">State</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(state);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Country</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(country);%></div>
		</div>
		<hr>
		<h4><b>Social Media</b></h4>
		<div class="row">
			<div class="col-sm-4">Facebook</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(facebook);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Instagram</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(instagram);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Twiter</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(twitter);%></div>
		</div>
		<div class="row">
			<div class="col-sm-4">Linkedin</div>
			<div class="col-sm-6" style="word-wrap: break-word;"><% out.println(linkedin);%></div>
		</div>
      <!-- </div>
      <div class="modal-footer"> -->
      	<div class="row" style="margin-top: 20px;">
      		<div class="col-sm-12">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		    </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--------------------end Profile ------------------------>
<!------------------ start setting ----------------------->
<div class="modal fade" id="setting" tabindex="-1" role="dialog" aria-labelledby="profileModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
     <!--  <div class="modal-header"> -->
       <div class="modal-body" style="padding-top: 0px;"> 
      	<h3><span class="glyphicon glyphicon-wrench"></span>&ensp;<b>Setting</b>
      		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	    </h3>
        <hr>
        <div class="row" style="padding-left: 20px;">
      		<h4>Change your Password</h4>
      		<form action="setting.jsp" method="post">
      			<input type="password" name="oldpass" id = "oldpass" class="txtbox" placeholder="Old Password">
      			<input type="password" name="newpass" id="newpass" class="txtbox" placeholder="New Password">
      			<input type="password" name="rnewpass" id="rnewpass" class="txtbox" placeholder="Re-Enter New Password"><hr>
      			<input type="reset" value = "Reset" class = "cancel">
      			<button name="setting" onclick="setting();" class = "success">Submit</button>
      		</form>
        </div>	
      </div>
    </div>
  </div>
</div>
<!---------------------- end setting ---------------->
<%
	if(ss!=null)
    {  
    	String searchhouse=request.getParameter("searchhouse");
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			int c=0;
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
			Statement st = conn.createStatement();
			Statement st1 = conn.createStatement();
		    ResultSet rs = st.executeQuery("Select * from LGRENTEE where city='"+searchhouse.toUpperCase()+"' OR state='"+searchhouse.toUpperCase()+"'");
			out.println("<div class='row'><div class='col-sm-12' style ='height: 60px;'><br>");
			out.println("<center><h1 style='font-family: AcryleScript; font-size:60px; margin-top: 0px;'><u>Search Houses</u></h1></center></div>");
	    	out.println("</div><br><br>");
	    	out.println("<div class='row' style='margin: 10px; font-size:20px;''>");
			while(rs.next())
		    {
		    	c++;
		    	int rentee_id = rs.getInt("id");
		    	int rid = rs.getInt("u_id");
				out.println("<div class='col-sm-5 block' style='padding: 10px 50px;''>");
		    	out.println("<div class = 'row'><h3><b>");
		    	out.println(rs.getString("owner_name")+"</b>");
		    	if(sid!=rid){
		    		ResultSet drs = st1.executeQuery("Select * from LGRENTER where U_ID ="+sid+" and RENTEE_ID ="+rentee_id);
					if(drs.next()){
						String status = drs.getString("status");
						if(status.equals("REQUESTED")){
							out.println("<button class='success' style='float:right;''>REQUESTED</button>");
					    }
						if(status.equals("APPROVED")){
							out.println("<button class='success' style='float:right;'>APPROVED</button>");
					    }
					}else{
						out.println("<button id='bttn"+rentee_id+"' class='success' style='float:right;' onclick='request("+rentee_id+","+sid+","+rid+");'>SEND REQUEST</button>");
				    }
				}
		    	out.println("</h3><hr></div>");
		    	out.println("<div class = 'row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-phone'></span>&nbsp;Contact No.</div><div class = 'col-sm-8'>"+rs.getString("owner_contact")+"</div></div>");
		    	out.println("<div class = 'row' style='word-wrap: break-word;''><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-home'></span>&nbsp;Address</div><div class = 'col-sm-8'>"+rs.getString("house_address")+"</div></div>");
		    	out.println("<div class='row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-send'></span>&nbsp;City</div><div class = 'col-sm-8'>"+rs.getString("city")+"</div></div>");
		    	out.println("<div class='row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-send'></span>&nbsp;State</div><div class = 'col-sm-8'>"+rs.getString("state")+"</div></div>");
		    	out.println("<div class='row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-globe'></span>&nbsp;Longitude</div><div class = 'col-sm-8'>"+rs.getString("longitude")+"</div></div>");
		    	out.println("<div class = 'row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-globe'></span>&nbsp;Latitute</div><div class = 'col-sm-8'>"+rs.getString("latitute")+"</div></div>");
		    	out.println("<div class = 'row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-paperclip'></span>&nbsp;House Type</div><div class = 'col-sm-8'>"+rs.getString("house_type")+"</div></div>");
		    	out.println("<div class = 'row'><div class = 'col-sm-4'>");
		    	out.println("<span class='glyphicon glyphicon-usd'></span>&nbsp;Amount</div><div class = 'col-sm-8'>"+rs.getString("rent_amount")+"</div></div>");
		    	out.println("</div>");
		    }
		    out.println("</div>");
		    if(c==0){
		    	out.println("<div class='row'><div class='col-sm-12'><br><center><h1 style ='font-family: AcryleScript; font-size:60px; margin-top: 0px;'>No house Available</h1></center></div></div>");
		    }
		    
		}
		catch(Exception e){
			out.println(e);
		}
    }
}
%>
</body>
<script>
	function request(rentee_id, uid, rid){
		$.ajax({
	        type: "post",
	        url: "request.jsp",
	        data: {"rentee_id":rentee_id, "uid":uid,"rid":rid},
	        success: function() {
	           $('#bttn'+rentee_id).html('Request Send');
	        },
	        error:function (xhr, ajaxOptions, thrownError){
	            alert(xhr.status);
	            alert(thrownError);
	        }  
	    });
	    return false;
	}
</script>
</html>