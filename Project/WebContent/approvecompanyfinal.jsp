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
			
			String emailEnt = request.getParameter("approval");
			//String question = ques.replace('-', ' ');						

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select email,approve from company");

			ResultSet rs = ps.executeQuery();
			boolean approveReady = false;
			while(rs.next())
			{
				String s = rs.getString("email");
				String apprv = rs.getString("approve");
				if(emailEnt.equalsIgnoreCase(s)&&apprv.equals("false"))
				{
					approveReady = true;
					break;
				}
				
					
			}
			%>
			<% 
			if(!approveReady)
			{%>
			<h3 align="center" style="color: #ffeb3b;">Company Doesnt Exist Or Is Already Approved </h3>
			<jsp:include page="approvecompany.jsp"></jsp:include>
			<%}else
			{
				
				PreparedStatement ps2 = con.prepareStatement("update company set approve=? where email=?");
				ps2.setString(1, "true");
				ps2.setString(2, emailEnt);
				ps2.executeUpdate();
			%>
			<h2 align="center" style="color: #ffeb3b;">Approval Successfully. Approve Another Company :)</h2>
			<jsp:include page="approvecompany.jsp"></jsp:include>
			<%} %>
			
			
		<%}else{%>

			<jsp:forward page="bad.jsp"></jsp:forward>
			
		<%}
		%>	

</body>
</html>