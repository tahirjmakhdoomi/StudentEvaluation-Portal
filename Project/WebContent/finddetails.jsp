<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
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

.btn:hover{
background-color: black;
color: white;
}
table,th,tr,td{
border : 3px solid grey;
border-collapse: collapse;
margin: auto;
padding:2px;


}


</style>
</head>
<body>

<div id="container">
		
	<%			
		String validity = (String) session.getAttribute("compvalidity");
		if (validity.equals("exactly")) {
			int min = Integer.parseInt(request.getParameter("min"));

			int max = Integer.parseInt(request.getParameter("max"));
			if(min>max){
				min=0;
			}
			String tech = request.getParameter("tech");
			String qualification = request.getParameter("qualification");
			String yop = request.getParameter("yop");

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select * from student");

			ResultSet rs = ps.executeQuery();
			boolean exist = false;
			%>
			<div id="blocks">
			<h3 class="fie">List</h3>
			
			<table>
			<tr><th>S No</th><th>Name</th><th>Email</th><th>Contact</th></tr>
			<%int i=0;
			while(rs.next())
			{
				int percentdb = rs.getInt("percent");
				String qualificationdb = rs.getString("qualification");
				String yopdb = rs.getString("year");
				String techdb = rs.getString("tech");
				String name= rs.getString("name");
				String email = rs.getString("email");
				String mobile = rs.getString("contact");
				
				
				
				if(techdb.equalsIgnoreCase(tech) || yopdb.equalsIgnoreCase(yop) || qualificationdb.equalsIgnoreCase(qualification) || (percentdb>=min && percentdb<=max) )
				{
				i++;	 
				
					 
				%>
				
				
			<tr><td><%=i %></td><td><%=name %></td><td><%=email %></td><td><%=mobile %></td></tr>	
				<%
				}
				
					
			}%>
			
			</table>
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