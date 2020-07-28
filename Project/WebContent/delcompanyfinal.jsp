<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="bad.jsp" %>
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
			
			String emailEnt = request.getParameter("email");
			//String question = ques.replace('-', ' ');						

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select email from company");

			ResultSet rs = ps.executeQuery();
			boolean deleteReady = false;
			while(rs.next())
			{
				String s = rs.getString("email");
				if(emailEnt.equalsIgnoreCase(s))
				{
					deleteReady = true;
					break;
				}
				
					
			}
			%>
			<% 
			if(!deleteReady)
			{%>
			<h3 align="center" style="color: #ffeb3b;">Company Doesnt Exist Or Is Already Deleted </h3>
			<jsp:include page="delcompany.jsp"></jsp:include>
			<%}else
			{
				
				PreparedStatement ps2 = con.prepareStatement("delete from company where email=?");
				ps2.setString(1, emailEnt);
				ps2.executeUpdate();
			%>
			<h2 align="center" style="color: #ffeb3b;">Deletion Successfully. Delete Another Company :)</h2>
			<jsp:include page="delcompany.jsp"></jsp:include>
			<%} %>
			
			
		<%}else{%>

			<jsp:forward page="bad.jsp"></jsp:forward>
			
		<%}
		%>	

</body>
</html>