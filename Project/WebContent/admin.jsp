<%@ page import="java.sql.*"%>
<%@ page errorPage="bad.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: grey;
}

#container {
	border: 2px solid black;
	text-align: center;
	line-height: 40px;
	background-color: #eae9e9;
	padding: 50px;
}

a {
	background-color: grey;
	display: inline-block;
	color: white;
	padding-left: 20%;
	padding-right: 20%;
	margin: 4px;
	text-decoration: none;
}

a:hover {
	background-color: black;
}
</style>

</head>
<body>
	<%

	
		String emailEnt = request.getParameter("username");
		String passEnt = request.getParameter("password");
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project", "root", "1234");

		PreparedStatement ps = con.prepareStatement("select * from admin");
		
		
		ResultSet rs = ps.executeQuery();
		boolean exist = false;
		String name="";

		
		while (rs.next()) {
			String s = rs.getString("username");
			String pw = rs.getString("password");
			name = rs.getString("name");
			if (emailEnt.equalsIgnoreCase(s) && passEnt.equals(pw)) {
				
				
				exist = true;
				break;
			}

		}
		
	if(exist){
	session.setAttribute("valid", "truetrue");
	session.setAttribute("user",emailEnt);
	session.setAttribute("pass", passEnt);
	session.setAttribute("userfull",name);
	
	%>
	<div id="container">

		<h1>Welcome : <%=name %></h1>

		<a href="addqs.jsp">Add Question</a><br> 
		<a href="deletequestion.jsp">Delete Question</a><br> 
		<a href="approvecompany.jsp">Approve a Comapany</a><br> 
		<a href="showallcpy.jsp">Show All Companies</a><br> 
		<a href="delcompany.jsp">Delete Company</a><br> 
		<a href="deluser.jsp">Delete User</a><br> 
		<a href="findcompany.jsp">Find Company</a><br>
		<a href="finduser.jsp">Find User</a><br> 
		<a href="feedbackadmin.jsp">View Feedback And Approval</a><br>
		<br>
		<a href="adminlogout.jsp">Logout</a>
		


	</div><% 
	} 
	else{%> 
		<h2 align="center" style="color: 
		 #ffeb3b;">Please Try Again, Invalid Username or 
		 password</h2> 
		<jsp:include 
		 page="adminlogin.html"></jsp:include> 
		 
	<% 
	} 
	 
		 
	%> 


</body>
</html>