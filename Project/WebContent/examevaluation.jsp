<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		String validity = (String) session.getAttribute("studentvalid");
		if (validity.equals("trueyes")) {
			
			String emailEnt = request.getParameter("ans");
			//String question = ques.replace('-', ' ');
			emailEnt=emailEnt.replace('$',' ');
			System.out.print(emailEnt);
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select ques,anscrt from questions");

			ResultSet rs = ps.executeQuery();
			boolean correct = false;
			String qs = (String)session.getAttribute("ques");
			System.out.print("qs = "+qs);
			System.out.println("answeer: "+emailEnt);
			
			int i=1;
			if(session.getAttribute("i")!=null){
				i=(int)session.getAttribute("i");
				System.out.println("value of i"+i);
			};
			String anscrrrt="";
			while(rs.next())
			{
				String qst = rs.getString("ques");
				String s = rs.getString("anscrt");
				anscrrrt =s;
				if(qst.equals(qs))
				{
					i++;		
					if(s.equalsIgnoreCase(emailEnt)){
						correct = true;
					}
						break;	
					
					
				}
				
				
					
			}
			%>
			<% 
			if(correct)
			{
			session.setAttribute("loop", i);
			int crt = (int)session.getAttribute("crt");
			crt++;
			session.setAttribute("crt",crt);	
			//System.out.println(session.getAttribute("resultno").toString());
			
			PreparedStatement analysiscorrect = con.prepareStatement("insert into analysis values('"+session.getAttribute("userstu").toString()+"','"+Integer.parseInt(session.getAttribute("resultno").toString())+"','"+qs+"','"+emailEnt+"','"+anscrrrt+"')");
			analysiscorrect.executeUpdate();

			
			
			
			%>
			<jsp:forward page="takeexamstu.jsp"></jsp:forward>
			<%
			}
			else
			{
				session.setAttribute("loop", i);
				int incrt = (int)session.getAttribute("incrt");
				incrt++;
				session.setAttribute("incrt",incrt);
			//	System.out.println(session.getAttribute("resultno").toString());			
				PreparedStatement analysiscorrect = con.prepareStatement("insert into analysis values('"+session.getAttribute("userstu").toString()+"','"+Integer.parseInt(session.getAttribute("resultno").toString())+"','"+qs+"','"+emailEnt+"','"+anscrrrt+"')");
				analysiscorrect.executeUpdate();

				/* PreparedStatement ps2 = con.prepareStatement("delete from company where email=?");
				ps2.setString(1, emailEnt);
				ps2.executeUpdate(); */
			%>
			<jsp:forward page="takeexamstu.jsp"></jsp:forward>
			<%} %>
			
			
		<%}else
		
		{
		%>
			<jsp:forward page="bad.jsp"></jsp:forward>
			
		<%}
		%>	

</body>
</html>