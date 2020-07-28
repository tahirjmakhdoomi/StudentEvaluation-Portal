<%@page import="java.util.Date"%>
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
		String validity = (String) session.getAttribute("studentvalid");
		if (validity.equals("trueyes")) {			
				
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			String feedback = request.getParameter("feed");
			
			PreparedStatement ps = con.prepareStatement("insert into feedbackstu values(?,?,?)");
			ps.setString(1, session.getAttribute("userstu").toString());
			ps.setString(2, feedback);
			ps.setString(3, "false");
			ps.executeUpdate();
			
			PreparedStatement ps2 = con.prepareStatement("update student set feedbackgiven=? where email=?");
			ps2.setString(1, "true");
			ps2.setString(2, session.getAttribute("userstu").toString());
			ps2.executeUpdate();
			
			
			%>
			<h1>Your feedback has been recorded</h1>
			
	
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