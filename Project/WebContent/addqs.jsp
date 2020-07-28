<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
.qs{
width:100%;
}
.choice{
width:21%;
float: left;

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

</style>
</head>
<body>
	<%
		String validity = (String) session.getAttribute("valid");
		if (validity.equals("truetrue")) {
	%>
	<div id="container">
		<h1>Welcome: <%=session.getAttribute("userfull")%></h1>

		<div id="blocks">
			<h3 class="fie">Add Question</h3>
			<fieldset>
				<legend>Qs</legend>
				<form action="quesaddition.jsp" method="post">
					<input class="qs" type="text" name="question" placeholder="Enter Your Qs Here" required="required"><br> 
					
					<input class="choice" type="text" name="ans1" placeholder="Enter Choice 1" required="required">
					<input class="choice" type="text" name="ans2" placeholder="Enter Choice 2" required="required">
					<input class="choice" type="text" name="ans3" placeholder="Enter Choice 3" required="required">
					<input class="choice" type="text" name="ans4" placeholder="Enter Choice 4" required="required">
					<br>
					<input class="choice" type="text" name="ansckt" placeholder="Enter Correct Ans" required="required">
					<br>
				
					<input type="submit" value="Add Question" class="btn"><br>
				</form>

			</fieldset>
			
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