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
text-align: center;
line-height: 40px;
background-color: #eae9e9;

padding: 50px;


}
a{
background-color: grey;
display: inline-block;
color:	white;
padding : 2px;
text-decoration: none;

}
#blocks{
border: 1px solid black;
width: 33%;
margin-left: auto;
margin-right: auto; 



}

marquee{
height: 100px;
}

a:hover{
background-color: black;
}

</style>
</head>
<body>

<div id="container">
	<h1>Welcome Please Go Through Your Respective Section</h1>
	
	<div id="blocks">
	<h1>Admin Section</h1>
	<h3><a href="adminlogin.html">Click Here To Proceed</a></h3>
	
	
	</div>
	<div id="blocks">
	<h1>Company Section</h1>
	<h3><a href="companylogin.html">Click Here To Proceed</a></h3>
	
	</div>
	<div id="blocks">
	<h1>Student Section</h1>
	<h3><a href="studentlogin.html">Click Here To Proceed</a></h3>
	
	</div>
	
	<div id="subdr">
	<h4>Reviews</h4>
	<marquee direction="up" style="width:40%; background-color: lightgrey;" scrollamount="2">
	<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
	
	PreparedStatement ps = con.prepareStatement("select * from feedbackstu where approved=?");
	ps.setString(1, "true");

	ResultSet rs = ps.executeQuery();
	while(rs.next()){
		String s = rs.getString("feed");
	%>
	<b><%=s %></b><br>
	
	
	
	<%
	
	}
	con.close();
	%> 
	</marquee>
	
	</div>	
	
	
</div>
	
	



</body>
</html>



