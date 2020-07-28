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
		String validity = (String) session.getAttribute("studentvalid");
		if (validity.equals("trueyes")) {			

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			String userstu = session.getAttribute("userstu").toString(); 
			System.out.print(userstu);
			PreparedStatement ps = con.prepareStatement("select * from student where email=?");
			ps.setString(1, userstu);
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			PreparedStatement psresults = con.prepareStatement("select * from result where email=?");
			psresults.setString(1, userstu);
			ResultSet results = psresults.executeQuery();
			
			boolean exist = false;
			int percent = Integer.parseInt(rs.getString("percent"));
			int score = (percent*25)/100;
			%>
			<h1>Welcome: <%=rs.getString("name")%></h1>
			<div id="blocks">
			<table>
			<tr><th>Email: </th><td><%= rs.getString("email")%></td></tr>
			<tr><th>Qualification:  </th><td><%= rs.getString("qualification")%></td></tr>
			<tr><th>Score / 25: </th><td><%= score%></td></tr>
			<tr><th>Percentage:  </th><td><%= rs.getString("percent")%></td></tr>
			
			</table>
			
			<h3 class="fie">Other Recent Test Scores:> </h3>
			
			<table>
			<tr><th>S No</th><th>Date</th><th>Correct</th><th>Incorrect</th><th>Percent</th></tr>
			<%int i=0;
			while(results.next())
			{
				
				String s = rs.getString("email");
				
				if(s.equalsIgnoreCase(session.getAttribute("userstu").toString()))
				{
					 int per = results.getInt("percent");
					 String date = results.getString("date");
					 int correct = results.getInt("correct");
					 int incorrect = results.getInt("incorrect");
						i++;
					 
				%>
				
				
			<tr><td><%=i %></td><td><%=date %></td><td><%=correct %></td><td><%=incorrect %></td><td><%=per %></td></tr>	
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