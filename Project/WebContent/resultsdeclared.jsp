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
				
				int incorrect = (int)session.getAttribute("incrt");
				Date d1 = new Date();
				float percent = ((correct*100)/25);
			
			
			%>
			<h1>Welcome: <%=session.getAttribute("stuname")%></h1>
		
			<div id="blocks">
			<h5 class="fie">Results</h5>
			
			<h4>Correct Answers : <%=correct %> | Incorrect Answers : <%=incorrect %></h4>		
			
			<h4>Percentage :<%=percent %>%</h4>	
			<table>
			<tr><th>Question</th><th>Answer You Provided</th><th>Correct Answer</th></tr>
			<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select ques,ans,ansckt from analysis where testno=?");
			ps.setInt(1, Integer.parseInt(session.getAttribute("resultno").toString()));
			
			ResultSet rs = ps.executeQuery();			
			while(rs.next()){
			%>
			<tr><td><%=rs.getString("ques")%></td><td><%=rs.getString("ans")%></td><td><%=rs.getString("ansckt")%></td></tr>
			
			<%} %>
			</table>
			<br>	
			<h3>Do you want to update your results?</h3>
			<fieldset><form action="resultrecord.jsp" method="post">
			Yes: <input type="radio" value="yes" name="response" required> No: <input type="radio" value="no" name="response" required>			
			<br>
			<input type="submit" value="Submit" class="btn">
			</form>
			</fieldset>
		
			</div>
			<hr>
			<h4><a href="logout.jsp" class="btn">Logout</a></h4>
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