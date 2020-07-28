<%@page import="java.sql.*"%>

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
.btn{
background-color: grey;
color: white;
}
a:hover {
	background-color: black;
}
.btn:hover{
	background-color: black;
}
.field{
margin-top:20px;
border:2px solid grey;
width:30%;
height: 30px;
}
</style>
</head>
<body>
<body>
	<%

	
		String emailEnt = request.getParameter("username");
		String passEnt = request.getParameter("password");
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project", "root", "1234");

		PreparedStatement ps = con.prepareStatement("select * from student");
		
		
		ResultSet rs = ps.executeQuery();
		boolean exist = false;
		String name="";
		
		while (rs.next()) {
			String s = rs.getString("email");
			String pw = rs.getString("password");
			name = rs.getString("name");
			
			if (emailEnt.equalsIgnoreCase(s) && passEnt.equals(pw)) {
				
				
				session.setAttribute("studentvalid", "trueyes");
				session.setAttribute("userstu", emailEnt);
				session.setAttribute("stuname", name);
				session.setAttribute("passstu", passEnt);
				int loop = 1;
				session.setAttribute("loop", loop);
				int crt= 0;
				session.setAttribute("crt", crt);
				int incrt = 0;
				session.setAttribute("incrt", incrt);
				exist = true;
				break;
			}
			

		}
		
	if(exist){%>
	
		<div id="container">

		<h1>Welcome : <%=name%></h1>

		<a href="takeexamstu.jsp">Take Exam</a><br> 
		<a href="performancereport.jsp">View Your Performance Report</a><br> 
		<%
		PreparedStatement ps2 = con.prepareStatement("select * from student where email=?");
		ps2.setString(1, session.getAttribute("userstu").toString());
		ResultSet rsfeedback = ps2.executeQuery();
		rsfeedback.next();
		if(rsfeedback.getString("feedbackgiven").equals("true")){
		%>
		<h5>You have already given you feedback</h5>
		<%
		}
		else{%>
	
		<form action="feedbackstu.jsp" method="post">
		<input type="text" name="feed" placeholder="Please Provide Your Feedback Here." class="field">
		<input type="submit" value="Submit" class="btn">
		</form>
		<%} %>

	</div>
		
		<%
	}
	else{%>
		<h2 align="center" style="color: #ffeb3b;">Please Try Again</h2>
		<jsp:include page="studentlogin.html"></jsp:include>
		
		
	<%
	}
	
		
	%>
	

</body>

</body>
</html>