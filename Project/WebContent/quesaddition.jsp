<%@page import="java.sql.*" %>
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
		String validity = (String) session.getAttribute("valid");
		if (validity.equals("truetrue")) {
			
			String question = request.getParameter("question");
			String ans1 = request.getParameter("ans1");
			String ans2 = request.getParameter("ans2");
			String ans3 = request.getParameter("ans3");
			String ans4 = request.getParameter("ans4");
			String ansckt = request.getParameter("ansckt");
						

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select ques from questions");

			ResultSet rs = ps.executeQuery();
			boolean exist = false;
			while(rs.next())
			{
				String s = rs.getString("ques");
				
				if(question.equalsIgnoreCase(s)){
					exist = true;
					break;
				}
				
					
			}
			%>
			<% 
			if(exist)
			{%>
			<h3 align="center" style="color: #ffeb3b;">Question Already Exists. Please Add A Different Question </h3>
			<jsp:include page="addqs.jsp"></jsp:include>
			<%}else
			{
				
				PreparedStatement ps2 = con.prepareStatement("insert into questions values('"+question+"','"+ans1+"','"+ans2+"','"+ans3+"','"+ans4+"','"+ansckt+"')");
				ps2.executeUpdate();
			%>
			
			
			<h2 align="center" style="color: #ffeb3b;">Added Successfully. Add Another Qs :)</h2>
			<jsp:include page="addqs.jsp"></jsp:include>
			<%} %>
		<%}else{%>

			<jsp:forward page="bad.jsp"></jsp:forward>
			
		<%}
		%>	
			
			
			
			
			
	

</body>
</html>