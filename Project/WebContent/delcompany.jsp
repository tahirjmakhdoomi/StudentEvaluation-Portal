<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" errorPage="bad.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
body{
background-color: grey;
}
#container{
border: 2px solid black;
text-align: center;
line-height: 50px;
background-color: #eae9e9;
padding: 50px;

}
input{
border:1px solid grey;
padding: 2px;
margin: 4px;

}
span{
border: 2px solid grey;
padding: 4px;
font-style: bold;

}
.btn{
background-color: grey;
color: white;
padding-right:12px;

padding-left:12px;
padding-top: 10px;

padding-bottom: 10px;
text-decoration: none;
}


.btn:hover{
background-color: black;
color: white;
}
table,th,tr,td{
border : 2px solid grey;
border-collapse: collapse;
margin: auto;
padding:2px;


}

</style>
</head>
<body>
<div id="container">
		
	<%			
		String validity = (String) session.getAttribute("valid");
		if (validity.equals("truetrue")) {			

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select * from company");

			ResultSet rs = ps.executeQuery();
			boolean exist = false;
			%>
			<h1>Welcome: <%=session.getAttribute("userfull")%></h1>
			<div id="blocks">
			<h3 class="fie">List Of All Companies </h3>
			<h4 class="fie">Select To Delete Company</h4>
			
			<form action="delcompanyfinal.jsp" method="post">
			<table>
			<tr><th>S.No</th><th>Name</th><th>Email</th><th>Approved</th><th>Selection</th></tr>
			<%int i =0;
			while(rs.next())
			{
				
				String s = rs.getString("approve");
					 String compEmail = rs.getString("email");
					 String name = rs.getString("name");
					
					 String sd = s.replace(' ', '-');
					i++;				
				%>
				
				<tr><td><%=i%></td><td><%=name %></td><td><%=compEmail%></td><td><%=s%></td><td><input type="radio" value=<%=compEmail%> name="email" required></td></tr>
				
				<%
					
			}%>
			</table><br>
			<input type="submit" value="Delete" class="btn">
			</form>
			</div>
</div>			

	<%
		}

		else {
	%>


	<jsp:forward page="bad.jsp"></jsp:forward>

	<%
		}
	%>



</body>
</html>