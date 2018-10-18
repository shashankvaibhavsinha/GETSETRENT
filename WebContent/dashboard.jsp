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
    	int rrrs = 0, rrru = 0, rrss = 0, rrsu = 0, arrs = 0;
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
		    ResultSet drs = st.executeQuery("Select * from LGRENTER where rid = "+sid+" OR u_id ="+sid);
		    while(drs.next())
		    {
		    	int u_id = drs.getInt("U_ID");
		    	int rid = drs.getInt("rid");
		    	String status = drs.getString("status");
		    	if(rid == sid){
		    		if(status.equals("REQUESTED"))
		    			rrru++;
		    		else
		    			rrrs++;
		    	}
		    	if(u_id == sid){
		    		if(status.equals("REQUESTED"))
		    		{
		    			rrsu++;
			    	}
		    		if(status.equals("REMOVED"))
		    			rrss++;
		    	}
		    	if(u_id == sid){
		    		if(status.equals("APPROVED"))
		    			arrs++;
		    	}
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
	  <a href="#" onclick="dashboard();"><span class="glyphicon glyphicon-list"></span>&nbsp;DASHBOARD</a><a href="#profile" data-toggle="modal" data-target="#profile"><span class="glyphicon glyphicon-user"></span>&nbsp;MY PROFILE</a>
	  <a href="#" onclick="edit_profile();"><span class="glyphicon glyphicon-edit"></span>&nbsp;EDIT PROFILE</a>
	  <!-- <a href="#"><span class="glyphicon glyphicon-comment"></span>&nbsp;MESSAGES</a> -->
	  <a href="#" onclick="add_house();"><span class="glyphicon glyphicon-plus"></span>&nbsp;ADD HOUSE</a>
	  <a href="#" onclick="view_house();"><span class="glyphicon glyphicon-filter"></span>&nbsp;VIEW HOUSE</a>
	  <a href="#" onclick="search_house();"><span class="glyphicon glyphicon-search"></span>&nbsp;SEARCH HOUSE</a>
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
<!------------------ start View RENT REQUEST SENT ----------------------->
<div class="modal fade" id="view_request" tabindex="-1" role="dialog" aria-labelledby="profileModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content block">
     <!--  <div class="modal-header"> -->
       <div id="viewbody" class="modal-body" style="padding-top: 0px; font-size:20px;">
       </div>
    </div>
  </div>
</div>
<!---------------------- end View RENT REQUEST SENT ---------------->

<div id = "dashboard">
	<div class="row" style="margin: 10px; font-size:20px;">
		<div class="col-sm-11 block">
			<div class = "row">
				<div class = "col-sm-8">
					Rent Request Recieved&nbsp;<span class="glyphicon glyphicon-check"></span>
				</div>
				<div class = "col-sm-2">
					&emsp;&emsp;&emsp;<% out.println(rrrs);%>&nbsp;<span class="glyphicon glyphicon-eye-open">
				</div>
				<div class = "col-sm-2">
					<% out.println(rrru);%>&nbsp;<span class="glyphicon glyphicon-eye-close"></span>
					&emsp;&emsp;&emsp;&emsp;&nbsp;
					<span id = "rrr_down" class="glyphicon glyphicon-chevron-down cursor" onclick="rrr();" style="display: inline;"></span>
					<span id = "rrr_up" class="glyphicon glyphicon-chevron-up cursor" onclick="rrr();" style="display: none;"></span>
				</div>
			</div>
			<div class="row" id = "rrr" style="display: none;max-height:400px;overflow-y:auto;">
				<div class = "col-sm-12">

					<%
						try{
							Class.forName("oracle.jdbc.driver.OracleDriver");
							Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
							Statement st = conn.createStatement();
							Statement st1 = conn.createStatement();
							ResultSet rs = st.executeQuery("Select * from LGRENTER where rid="+sid);
						    while(rs.next())
						    {
						    	int uid = rs.getInt("u_id");
						    	ResultSet drs = st1.executeQuery("Select * from LGUSER where id="+uid);
							    if(drs.next())
							    {
							    	int renter_id = rs.getInt("id");
							    	String status = rs.getString("status");
							    	String uname = drs.getString("name");
							    	String uemail = drs.getString("email");
							    	out.println("<hr><div class='row'><div class='col-sm-1'><img src='default.png' style='width: 100%; border-radius: 50%; background-color: #f9f9f9;'></div>");
							    	out.println("<div class='col-sm-4'>"+uname.toUpperCase()+"</div>");
							    	out.println("<div class='col-sm-4'>"+uemail+"</div>");
							    	if(status.equals("REQUESTED"))
							    		out.println("<div class='col-sm-3'><button class='cancel' onclick='rent_request("+renter_id+",0)'>DECLINE</button>&emsp;<button class='success' onclick='rent_request("+renter_id+",1)'>ACCEPT</button></div>");
							    	if(status.equals("APPROVED"))
							    		out.println("<div class='col-sm-3'><button class='success'>ACCEPTED</button></div>");
							    	if(status.equals("REMOVED"))
							    		out.println("<div class='col-sm-3'><button class='cancel'>DECLINED</button></div>");
							    	out.println("</div>");
							    }
						    }
						}catch(Exception e){
							out.println(e);
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin: 10px; font-size:20px;">
		<div class="col-sm-11 block">
			<div class = "row">
				<div class = "col-sm-8">
					Rent Request Sent&nbsp;<span class="glyphicon glyphicon-share"></span>
				</div>
				<div class = "col-sm-2">
					&emsp;&emsp;&emsp;<% out.println(rrss);%>&nbsp;<span class="glyphicon glyphicon-eye-open">
				</div>
				<div class = "col-sm-2">
					<% out.println(rrsu);%>&nbsp;<span class="glyphicon glyphicon-eye-close"></span>
					&emsp;&emsp;&emsp;&emsp;&nbsp;
					<span id = "rrs_down" class="glyphicon glyphicon-chevron-down cursor" onclick="rrs();" style="display: inline;"></span>
					<span id = "rrs_up" class="glyphicon glyphicon-chevron-up cursor" onclick="rrs();" style="display: none;"></span>
				</div>
			</div>
			<div class="row" id = "rrs" style="display: none;max-height:400px;overflow-y:auto;">
				<div class = "col-sm-12">
				<%
					try{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
						Statement st = conn.createStatement();
						Statement st1 = conn.createStatement();
						ResultSet rs = st.executeQuery("Select * from LGRENTER where u_id="+sid+" and (status = 'REQUESTED' OR status = 'REMOVED')");
					    while(rs.next())
					    {
					    	int renter_id = rs.getInt("id");
					    	int rentee_id = rs.getInt("rentee_id");
					    	ResultSet drs = st1.executeQuery("Select * from LGRENTEE where id="+rentee_id);
						    if(drs.next())
						    {
						    	out.println("<hr><div class='row'><div class='col-sm-1'><img src='default.png' style='width: 100%; border-radius: 50%; background-color: #f9f9f9;'></div>");
						    	out.println("<div class='col-sm-2'>"+drs.getString("owner_name")+"</div>");
						    	out.println("<div class='col-sm-3'>"+drs.getString("house_address")+"</div>");
						    	out.println("<center><div class='col-sm-3'>"+drs.getString("city")+", "+drs.getString("state")+"</div>");
						    	out.println("<div class='col-sm-3'><button class='cancel' onclick='delete_request("+renter_id+")'>DELETE</button>&emsp;<button class='success' onclick='view_request("+renter_id+")'  data-toggle='modal' data-target='#view_request'>VIEW</button></div>");
						    	out.println("</center></div>");
						    }
					    }
					}catch(Exception e){
						out.println(e);
					}
				%>				
			</div>
		</div>
	</div>
	<div class="row" style="margin: 10px; font-size:20px;">
		<div class="col-sm-11 block">
			<div class = "row">
				<div class = "col-sm-8">
					Approved Rent Request&nbsp;<span class="glyphicon glyphicon-saved"></span>
				</div>
				<div class = "col-sm-2"></div>
				<div class = "col-sm-2">
					<% out.println(arrs);%>&nbsp;<span class="glyphicon glyphicon-eye-open"></span>
					&emsp;&emsp;&emsp;&emsp;&nbsp;
					<span id = "ars_down" class="glyphicon glyphicon-chevron-down cursor" onclick="ars();" style="display: inline;"></span>
					<span id = "ars_up" class="glyphicon glyphicon-chevron-up cursor" onclick="ars();" style="display: none;"></span>
				</div>
			</div>
			<div class="row" id = "ars" style="display: none;max-height:400px;overflow-y:auto;">
				<div class = "col-sm-12">
				<%
					try{
						Class.forName("oracle.jdbc.driver.OracleDriver");
						Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
						Statement st = conn.createStatement();
						Statement st1 = conn.createStatement();
						ResultSet rs = st.executeQuery("Select * from LGRENTER where u_id="+sid+" and status = 'APPROVED'");
					    while(rs.next())
					    {
					    	int rentee_id = rs.getInt("rentee_id");
					    	ResultSet drs = st1.executeQuery("Select * from LGRENTEE where id="+rentee_id);
						    if(drs.next())
						    {
						    	out.println("<hr><div class='row'><div class='col-sm-1'><img src='default.png' style='width: 100%; border-radius: 50%; background-color: #f9f9f9;'></div>");
						    	out.println("<div class='col-sm-2'>"+drs.getString("owner_name")+"</div>");
						    	out.println("<div class='col-sm-3'>"+drs.getString("house_address")+"</div>");
						    	out.println("<center><div class='col-sm-3'>"+drs.getString("city")+", "+drs.getString("state")+"</div>");
						    	out.println("<div class='col-sm-3'><button class='success'>APPROVED</button></div>");
						    	out.println("</center></div>");
						    }
					    }
					}catch(Exception e){
						out.println(e);
					}
				%>
			</div>
		</div>
	</div>
</div>
</div>
</div>
<div id="edit_profile" style="display: none;">
	<center style ="height: 60px;">
		<h1 style ="font-family: AcryleScript; font-size:60px; margin-top: 0px;"><u>Edit Profile</u></h1>
	</center>
	<div class="row">
		<div class="col-sm-2">
		</div>
		<div class="col-sm-8 block" style="font-size:20px;">
		<center>
		<form action="editprofile.jsp" method="post">
			<div class = "row">
				<div class = "col-sm-4">
					Name
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="ename" placeholder="Enter Your Name" value="<% out.println(name);%>" disabled>
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					Contact No.
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="econtact" placeholder="Enter Your Contact Number" value="<% out.println(contact);%>">
				</div>
			</div>
			</center>
			<div class = "row">
				<div class = "col-sm-4">
					<center>Sex</center>
				</div>
				<div class = "col-sm-1">
				</div>
				<div class = "col-sm-7">
					<% if(sex.equals("MALE"))
						{
							out.println("&ensp;<input type='radio' name = 'esex' value='MALE' checked>MALE&ensp;&ensp;&ensp;<input type='radio' name = 'esex' value='FEMALE'>FEMALE");
						}
					else if(sex.equals("FEMALE")){
							out.println("&ensp;<input type='radio' name = 'esex' value='MALE'>MALE&ensp;&ensp;&ensp;<input type='radio' name = 'esex' value='FEMALE' checked>FEMALE");
						}
					else{
						out.println("&ensp;<input type='radio' name = 'esex' value='MALE'>MALE&ensp;&ensp;&ensp;<input type='radio' name = 'esex' value='FEMALE'>FEMALE");
					}
					%>
					<!-- &ensp;<input type="radio" name = "esex" value="MALE">MALE
					&ensp;&ensp;&ensp;<input type="radio"name = "esex" value="FEMALE">FEMALE -->
				</div>
			</div>
			<center>
			<div class = "row">
				<div class = "col-sm-4">
					Address
				</div>
				<div class = "col-sm-8">
					<textarea class ="txtbox" name = "eaddress" placeholder="Enter Your Address"><% out.println(address);%></textarea>
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					City
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name = "ecity" placeholder="Enter Your City" value="<% out.println(city);%>">
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					State
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name = "estate" placeholder="Enter Your State" value="<% out.println(state);%>">
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					Country
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="ecountry" placeholder="Enter Your Country" value="<% out.println(country);%>">
				</div>
			</div>
			<hr>
			<div class = "row">
				<div class = "col-sm-4">
					Facebook
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="efacebook" placeholder="Enter your Facebook link" value="<% out.println(facebook);%>">
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					Instagram
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="einstagram" placeholder="Enter your Instagram link" value="<% out.println(instagram);%>">
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					Twitter
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="etwitter" placeholder="Enter your Twitter link" value="<% out.println(twitter);%>">
				</div>
			</div>
			<div class = "row">
				<div class = "col-sm-4">
					LinkedIn
				</div>
				<div class = "col-sm-8">
					<input type="text" class="txtbox" name="elinkedin" placeholder="Enter your LinkedIn link" value="<% out.println(linkedin);%>">
				</div>
			</div>
			<hr>
			<div class = "row">
				<div class="col-sm-6">
			    </div>
			    <div class="col-sm-6">
			        <input type="reset" class="btn btn-secondary">
			        <input type="submit" class="btn btn-primary">
			    </div>
		    </div>
		    </form>
		    </center>
		</div>
		<div class="col-sm-2">
		</div>
	</div>
</div>
<div id = "search_house" style="display: none;">
	<div class="row" style="margin: 10px; font-size:20px;">
		<center><img src="search_house.jpg" style="width: 32%;"></center>
		<form action="search_house.jsp" method="get">
			<center><input type="text" class="txtbox" name="searchhouse" placeholder="Enter Locality, Streat, or place to Search house" style="width: 60%;"></center>
			<br><center><button class="bttn">LeGhar Search</button></center>
		</form>
	</div>
</div>
<div id = "add_house" style="display: none;">
	<center style ="height: 60px;">
		<h1 style ="font-family: AcryleScript; font-size:60px; margin-top: 0px;"><u>Add Details</u></h1>
	</center>
	<div class="row block" style="margin: 10px; font-size:20px;">
		<div class="col-sm-6" style="padding: 30px;">
			<div id = "position">
				<form>
					Region
					<select onchange="set_country(this,country,city_state)" size="1" name="region" class="multiselect-ui form-control">
						<option value="" selected="selected">SELECT REGION</option>
						<script type="text/javascript">
						setRegions(this);
						</script>
					</select>
					Country<select name="country" size="1" disabled="disabled" onchange="set_city_state(this,city_state)" class="multiselect-ui form-control"></select>
					State<select name="city_state" size="1" disabled="disabled" onchange="print_city_state(country,this)" class="multiselect-ui form-control"></select>
					City<input type = "text" name = "city" id="city" disabled= "disabled" width = "40px" class="multiselect-ui form-control" onchange = "city_val()">
				</form>
				<div id="txtregion" style ="display:none;"></div>
				<div id="txtplacename" style ="display:none;">asia</div>
				<div id= "coordinate"></div>
				*****Please select the point in map******
				<input type = "submit" onclick="add_details()" value="Proceed >>>" placeholder="Enter House owner Name" class="success form-control" style="margin-top: 15px;">
			</div>
			<div id = "house_det" style = "display:none;">
				<form action="addhouse.jsp" method="post">
					<input type = "text" name = "owner" placeholder="Enter House owner Name" class="multiselect-ui form-control pad">
					<textarea name ="address" placeholder="Enter House Address" class="multiselect-ui form-control pad"></textarea>
					<input type = "text" name = "contact" placeholder="Enter Contact Information" class="multiselect-ui form-control pad">
					<input type = "text" name = "lat" id ="lat" class="multiselect-ui form-control pad" style = "width: 50%; float:left;">
					<input type = "text" name = "long" id= "long" class="multiselect-ui form-control pad" style = "width: 50%">
					<input type = "hidden" name = "city" id="addcity">
					<input type = "hidden" name = "state" id="addstate">
					<select name = "housetype" class = "multiselect-ui form-control pad">
						<option value = "">Select House Type</option>
						<option value = "1bhk">1 BHK</option>
						<option value = "2bhk">2 BHK</option>
						<option value = "3bhk">3 BHK</option>
					</select>
					Rent Amount<input type = "text" name = "amount" placeholder="Enter your Rent Amount" class="multiselect-ui form-control pad" style="width:50%">
					<input type = "submit" placeholder="Enter House owner Name" class="success form-control" style="margin-top: 15px;">
				</form>
			</div>
		</div>
		<div class="col-sm-6">
			<div id = "map" style="height: 400px; margin-top: 30px; background-image: url('loading.gif');background-position: center; background-repeat: no-repeat;"></div>
		</div> 
	</div>
</div>
<div id="view_house" style="display: none;">
	<!-- <center style ="height: 60px;"><br>
		<h1 style ="font-family: AcryleScript; font-size:60px; margin-top: 0px;">No house Available</h1>
	</center> -->
	<div class="row">
		<div class="col-sm-5" style ="height: 60px;"><br>
			<center><h1 style ="font-family: AcryleScript; font-size:60px; margin-top: 0px;"><u>View Houses</u></h1></center>
		</div>
	</div><br><br>
	<div class="row" style="margin: 10px; font-size:20px;">
		<%
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				int c=0;
				Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","oracle");
				Statement st = conn.createStatement();
			    ResultSet rs = st.executeQuery("Select * from LGRENTEE where U_ID = "+sid);
			    while(rs.next())
			    {
			    	c++;
			    	int id = rs.getInt("id");
			    	//getString("");
			    	out.println("<div class='col-sm-5 block' style='padding: 10px 50px;'>");
			    	out.println("<div class = 'row'><h3><b>");
			    	out.println(rs.getString("owner_name"));
			    	out.println("</b></h3><hr></div>");
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
			    if(c==0){
			    	out.println("<div class='row'><div class='col-sm-5'><br><center><h1 style ='font-family: AcryleScript; font-size:60px; margin-top: 0px;'>No house Available</h1></center></div></div>");
			    }
			    
			}
			catch(Exception e){
				out.println(e);
			}
		%>
	</div>
</div>
<script>
function rent_request(renter_id,status){
	$.ajax({
        type: "post",
        url: "rent_request.jsp",
        data: {"renter_id":renter_id, "status":status},
        success: function(html){
            location.reload();
        },
        error:function (xhr, ajaxOptions, thrownError){
            alert(xhr.status);
            alert(thrownError);
        }  
    });
    return false;
}
function delete_request(renter_id){
	$.ajax({
        type: "post",
        url: "delete_request.jsp",
        data: {"renter_id":renter_id},
        success: function(html){
            location.reload();
        },
        error:function (xhr, ajaxOptions, thrownError){
            alert(xhr.status);
            alert(thrownError);
        }  
    });
    return false;
}
function view_request(renter_id){
	$('#viewbody').html("");
	$.ajax({
        type: "post",
        url: "view_request.jsp",
        data: {"renter_id":renter_id},
        success: function(data){
        	/* var result = "a$b$c";
        	result = result.split('$');
        	console.log(result[0]); */
        	result = data.split('$');
        	//console.log(result);
        	$('#viewbody').append("<div class = 'row'><h3><b>");
        	$('#viewbody').append(result[0]);
        	$('#viewbody').append("</b></h3><hr></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-phone'></span>&nbsp;Contact No.</div><div class='col-sm-8'>"+result[1]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-home'></span>&nbsp;Address</div><div class='col-sm-8'>"+result[2]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-send'></span>&nbsp;City</div><div class='col-sm-8'>"+result[3]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-send'></span>&nbsp;State</div><div class='col-sm-8'>"+result[4]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-globe'></span>&nbsp;Longitude</div><div class='col-sm-8'>"+result[5]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-globe'></span>&nbsp;Latitute</div><div class='col-sm-8'>"+result[6]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-paperclip'></span>&nbsp;House Type</div><div class='col-sm-8'>"+result[7]+"</div></div>");
        	$('#viewbody').append("<div class = 'row'><div class='col-sm-4'><span class='glyphicon glyphicon-usd'></span>&nbsp;Amount</div><div class='col-sm-8'>"+result[8]+"</div></div>");
        	if(result[9] == "REQUESTED")
        		$('#viewbody').append("<hr><div class = 'row'><div class='col-sm-12'><span class='glyphicon glyphicon-exclamation-sign'></span>&nbsp;Request not accepted yet</div></div>");
        	if(result[9] == "REMOVED")
        		$('#viewbody').append("<hr><div class = 'row'><div class='col-sm-12'><span class='glyphicon glyphicon-exclamation-sign'></span>&nbsp;Request rejected</div></div>");
        } 
    });
    return false;
}
function setRegions()
    {
    	for (region in countries)
    		document.write('<option value="' + region + '">' + region + '</option>');
    	var map = new google.maps.Map(document.getElementById('map'), {
            mapTypeID:google.maps.MapTypeId.ROADMAP,
            zoom: 2,
          });
    	myMap(region, map);
    }

    function set_country(oRegionSel, oCountrySel, oCity_StateSel)
    {
    	var countryArr;
    	oCountrySel.length = 0;
    	oCity_StateSel.length = 0;
    	var region = oRegionSel.options[oRegionSel.selectedIndex].text;
    	if (countries[region])
    	{
    		oCountrySel.disabled = false;
    		oCity_StateSel.disabled = true;
    		oCountrySel.options[0] = new Option('SELECT COUNTRY','');
    		countryArr = countries[region].split('|');
    		for (var i = 0; i < countryArr.length; i++)
    			oCountrySel.options[i + 1] = new Option(countryArr[i], countryArr[i]);
    		document.getElementById('txtregion').innerHTML = region;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 2,
              });
        	myMap(region, map);
    		//document.getElementById('txtplacename').innerHTML = '';
    	}
    	else oCountrySel.disabled = true;
    }

    function set_city_state(oCountrySel, oCity_StateSel)
    {
    	var city_stateArr;
    	oCity_StateSel.length = 0;
    	var country = oCountrySel.options[oCountrySel.selectedIndex].text;
    	if (city_states[country])
    	{
    		oCity_StateSel.disabled = false;
    		oCity_StateSel.options[0] = new Option('SELECT NEAREST DIVISION','');
    		city_stateArr = city_states[country].split('|');
    		for (var i = 0; i < city_stateArr.length; i++)
    			oCity_StateSel.options[i+1] = new Option(city_stateArr[i],city_stateArr[i]);
    		document.getElementById('txtplacename').innerHTML = country;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 4,
              });
    		myMap(country, map);
    	}
    	else oCity_StateSel.disabled = true;
    }

    function print_city_state(oCountrySel, oCity_StateSel)
    {
    	var country = oCountrySel.options[oCountrySel.selectedIndex].text;
    	var city_state = oCity_StateSel.options[oCity_StateSel.selectedIndex].text;
    	if (city_state && city_states[country].indexOf(city_state) != -1)
    	{
    		var cityloc = city_state + ', ' + country;
    		document.getElementById('txtplacename').innerHTML = cityloc;
    		var map = new google.maps.Map(document.getElementById('map'), {
                mapTypeID:google.maps.MapTypeId.ROADMAP,
                zoom: 7,
              });
    		myMap(cityloc, map);
    		document.getElementById('city').disabled = false;
    	}
    	else document.getElementById('txtplacename').innerHTML = country;
    	document.getElementById('addstate').value = city_state;
    }
    function city_val()
    {	
    	var citi = document.getElementById('city').value;
    	var city = citi + ", " + document.getElementById('txtplacename').innerHTML;
    	document.getElementById('txtplacename').innerHTML = city;
    	var map = new google.maps.Map(document.getElementById('map'), {
            mapTypeID:google.maps.MapTypeId.ROADMAP,
            zoom: 14,
          });
		myMap(city, map);
		document.getElementById('addcity').value = citi;
    }
    function initMap()
    {
    	var mapCanvas = document.getElementById("map");
    	var mapOptions = {
    	  center: new google.maps.LatLng(23.64216,86.169075), zoom: 2
    	};
    	var map = new google.maps.Map(mapCanvas, mapOptions);
    }
    function myMap(address, map){
	   
		    var geocoder = new google.maps.Geocoder();
    		geocodeAddress(geocoder, map);
    		var marker;
              
              function placeMarker(location) {
            	    if ( marker ) {
            	      marker.setPosition(location);
            	    } else {
            	      marker = new google.maps.Marker({
            	        position: location,
            	        map: map
            	      });
            	    }
            	  }
              
              google.maps.event.addListener(map, 'click', function(event) {
            	    placeMarker(event.latLng);
            	    //*****************
            	    var myLatLng = event.latLng;
            	    var lat = myLatLng.lat();
            	    var lng = myLatLng.lng();
            	    //********************
            	    var posn=marker.getPosition();
            	    alert(posn);
            	    document.getElementById("coordinate").innerHTML = "Your Coordinate " + posn;
            	    document.getElementById("lat").value = lat;
            	    document.getElementById("long").value = lng;
            	  });

          }

          function geocodeAddress(geocoder, resultsMap) {
        	  var address = document.getElementById('txtplacename').innerHTML;
        	geocoder.geocode({'address': address}, function(results, status) {
              if (status === 'OK') {
                resultsMap.setCenter(results[0].geometry.location);
              } else {
                alert('Unable to Locate: ' + status);
              }
            });
	  }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsw-iXkE2waBHq3XqrVGzuasP4K4GqCyo&callback=initMap"></script>
</body>
</html> 
<%
		}else{
			response.sendRedirect("index.html");
		}
%>