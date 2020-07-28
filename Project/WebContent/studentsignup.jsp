<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
<%
	String nameEnt = request.getParameter("name");
	String emailEnt = request.getParameter("username");
	String passEnt = request.getParameter("password");
	String numEnt = request.getParameter("contact");
	String yearEnt = request.getParameter("year");
	String qualifEnt = request.getParameter("qualif");
	String collegeEnt = request.getParameter("college");
	String tech = request.getParameter("tech");
	

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
	
	PreparedStatement ps = con.prepareStatement("select email from student");

	ResultSet rs = ps.executeQuery();
	boolean exist = false;
	while(rs.next())
	{
		String s = rs.getString("email");
		
		if(emailEnt.equalsIgnoreCase(s)){
			exist = true;
			break;
		}
		
			
	}
	%>
	<% 
	if(exist)
	{%>
	<h3 align="center" style="color: #ffeb3b;">Email Already Signed Up. Please Login </h3>
	<jsp:include page="studentlogin.html"></jsp:include>
	<%}else
	{
		
		PreparedStatement ps2 = con.prepareStatement("insert into student values('"+emailEnt+"','"+nameEnt+"','"+passEnt+"','"+numEnt+"','"+qualifEnt+"','"+yearEnt+"','"+collegeEnt+"','0','false','"+tech+"')");
		ps2.executeUpdate();
	%>
	
	
	<h2 align="center" style="color: #ffeb3b;">Register Successful. Login :)</h2>
	<jsp:include page="studentlogin.html"></jsp:include>
	<%}%>
</body>
</html>