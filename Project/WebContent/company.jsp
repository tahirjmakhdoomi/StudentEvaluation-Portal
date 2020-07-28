<%@page import="java.sql.*"%>
<%@page errorPage="bad.jsp" %>
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

		PreparedStatement ps = con.prepareStatement("select * from company");
		
		
		ResultSet rs = ps.executeQuery();
		boolean exist = false;
		boolean approval=false;
		String name="";
		
		
		while (rs.next()) {
			String s = rs.getString("email");
			String pw = rs.getString("password");
			String approve = rs.getString("approve");
			
			if (emailEnt.equalsIgnoreCase(s) && passEnt.equals(pw)) {
				
				exist = true;
				if(approve.equalsIgnoreCase("true")){
					approval=true;
					name= rs.getString("name");
					session.setAttribute("compvalidity", "exactly");
					
				}
				
				break;
			}
			

		}
		
	if(approval){%>
	
		<div id="container">

		<h1>Welcome : <%=name%></h1>

		<form action="finddetails.jsp">
		<table border=1>
		<tr><th>Percentage: </th><td><select name="min">
				<option value="0" selected>Min %</option>
				<option value="50">50</option>
				<option value="60">60</option>
				<option value="70">70</option>
				<option value="80">80</option>
				<option value="90">90</option>
					
				</select>
				</td><td><select name="max">
				<option value="0" selected>Max %</option>
				<option value="60">60</option>
				<option value="70">70</option>
				<option value="80">80</option>
				<option value="90">90</option>
				<option value="100">100</option>
					
				</select></td> </tr>
				<tr><th>Qualification</th>
				<td colspan=2><select name="qualification">
				<option value="$" selected>Select One</option>
				<option value="bca">BCA</option>
				<option value="mca">MCA</option>
				<option value="btech">BTech</option>
				<option value="diploma">Diploma</option>
				<option value="other">Other</option>
					
				</select></td></tr>
				
				<tr><th>Technology</th><td colspan=2><select name="tech">
				<option value="$" selected>Select One</option>
				<option value="c">C</option>
				<option value="java">JAVA</option>
				<option value="c++">C++</option>
					
				</select></td></tr>
				
				<tr><th>Year Of Passing</th><td colspan=2><select name="yop">
				<option value="$" selected>Select One</option>
				<option value="2014">2014</option>
				<option value="2015">2015</option>
				<option value="2016">2016</option>
				<option value="2017">2017</option>
					
				</select></td></tr>
				<tr><th colspan=3><input type="submit" value="submit"></th></tr>
		
		</table>
				</form>
		

	</div>
		
		
		<%
	}
	else if(exist){%>
		<div id="container"><h2 align="center">Your Account is pending for approval from the Admin. Please contact administrator</h2>
		</div>
	<%
	}else{		
	%>
		<h2 align="center" style="color: #ffeb3b;">Please Try Again</h2>
		<jsp:include page="companylogin.html"></jsp:include>
	
	<%} %>
</body>

</body>
</html>