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
		String validity = (String) session.getAttribute("studentvalid");
		if (validity.equals("trueyes")) {			
			
			int correct = (int)session.getAttribute("crt");
			String email = (String)session.getAttribute("userstu");			
			int percent = ((correct*100)/25);
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			String resp = request.getParameter("response");
			
			if(resp.equals("yes"))
			{
			PreparedStatement ps = con.prepareStatement("update student set percent=? where email=?");
			ps.setInt(1,percent);
			ps.setString(2,email);
			ps.executeUpdate();
			
			PreparedStatement ps9 = con.prepareStatement("delete from analysis where email=?");
			ps9.setString(1, email);
			ps9.execute();
			
			session.setAttribute("studentvalid", "heheheheh");		
			
			
			
			%>
			<h1>Your response has been recorded</h1>
			<h2>You've also been succeesfully logged out</h2>
			<h3>Login again to see your result</h3>
			
			<%}else{
				PreparedStatement ps9 = con.prepareStatement("delete from analysis where email=?");
				ps9.setString(1, email);
				ps9.execute();
				
				session.setAttribute("studentvalid", "heheheheh");
			%>
			<h1>Your response has been recorded</h1>
			<h2>You've also been succeesfully logged out</h2>
			<h3>Login again to see your result</h3>
			
			<%} %>
			<hr>
			<h4><a href="studentlogin.html" class="btn" >Login</a></h4>
			<hr>
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