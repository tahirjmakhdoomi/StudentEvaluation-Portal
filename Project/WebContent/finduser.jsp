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

form{

!border: 2px dotted grey;
margin: auto;
width:50%;}

.left{
float:left;
}
.right{
float:right;
}
</style>
</head>
<body>
<div id="container">
		
	<%			
		String validity = (String) session.getAttribute("valid");
		if (validity.equals("truetrue")) {	
			%>
			
			<h1>Welcome: <%=session.getAttribute("userfull")%></h1>
			<div id="blocks">
			<fieldset>
			
			<form action="finduseremail.jsp" method="post" class="left">
			Find By Email:
			<input type="email" name="email" placeholder="Enter Email" required>
			<input type="submit" value="Find" class="btn">
			</form>
			
			<form action="findusername.jsp" method="post" class="right" >
			Find By Name:
			<input type="text" name="name" placeholder="Enter Name" required>
			<input type="submit" value="Find" class="btn">
			</form></fieldset>
			
		
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