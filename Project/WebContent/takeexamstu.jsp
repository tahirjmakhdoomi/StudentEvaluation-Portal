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

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/project","root","1234");
			
			PreparedStatement ps = con.prepareStatement("select * from questions");
			
			
			ResultSet r1 = ps.executeQuery();
			
			PreparedStatement resultone = con.prepareStatement("select email,testno from result");
			ResultSet resultschecker1 = resultone.executeQuery();
			boolean flagresult = true;
			if(!resultschecker1.next()){
				PreparedStatement quesEval = con.prepareStatement("insert into result values('default','0','0','0','0','0')");
				quesEval.executeUpdate();
				session.setAttribute("resultno",1);
				flagresult= false;
				
			}
			if(flagresult)
			{
				PreparedStatement results = con.prepareStatement("select email,testno from result");
				ResultSet resultschecker = results.executeQuery();
				
				while(resultschecker.next())
				{
				String email = resultschecker.getString("email");
				
				if(email.equals(session.getAttribute("userstu").toString()))
				{
				int resultno = resultschecker.getInt("testno");
				PreparedStatement check = con.prepareStatement("select email,testno from result");
				ResultSet counterres = resultone.executeQuery();
				while(counterres.next()){
					String emailttt = counterres.getString("email");
					if(emailttt.equals(session.getAttribute("userstu").toString())){
						if(resultno<counterres.getInt("testno")){
							resultno=counterres.getInt("testno");
							System.out.println(resultno);	
						}
					
						
					}
				}
				session.setAttribute("resultno",resultno+1);
				
				}
				else{
					int result = 1;
					session.setAttribute("resultno",result);
				}
				/* else{
					PreparedStatement quesEval = con.prepareStatement("insert into result values('"+(String)session.getAttribute("userstu")+"','0','0','0','0','1')");
					quesEval.executeUpdate();		
					session.setAttribute("resultno",1);
					} */
					
				}
			}
		
			
			boolean exist = false;
			
			int loop= Integer.parseInt(session.getAttribute("loop").toString());
				
			
			
			if(loop<26){
			%>
			<h1>Welcome: <%=session.getAttribute("stuname")%></h1>
			<div id="blocks">
			<h3 class="fie">Question No. <%=loop%> of 25</h3>
			<form action="examevaluation.jsp" method="post">
			
			<%int i = 1;
			while(r1.next())
			{
				
				
				if(i==loop)
				{
					
				String s = r1.getString("ques");
				String ans1=r1.getString("ans1");
				String ans2=r1.getString("ans2");
				String ans3=r1.getString("ans3");
				String ans4=r1.getString("ans4");
				
				session.setAttribute("ques",s);
				session.setAttribute("i",loop);
				String sd = s.replace(' ', '-');
				
				%>
				<h2 class="fie"><%=s %></h2>
				1. <%=ans1 %> <input type="radio" name="ans" value=<%=ans1.replace(' ', '$')%> required><br>
				2. <%=ans2 %> <input type="radio" name="ans" value=<%=ans2.replace(' ', '$')%> required><br>
				3. <%=ans3 %> <input type="radio" name="ans" value=<%=ans3.replace(' ', '$')%> required><br>
				4. <%=ans4 %> <input type="radio" name="ans" value=<%=ans4.replace(' ', '$')%> required><br>
				
				
				<%}i++;
				
				}%>
		<br>
			<input type="submit" value="Done" class="btn">
			</form>
			</div>
			<%}else{
				int correct = (int)session.getAttribute("crt");
				
				int incorrect = (int)session.getAttribute("incrt");
				Date d1 = new Date();
				float percent = ((correct*100)/25);
				PreparedStatement submission = con.prepareStatement("insert into result values('"+(String)session.getAttribute("userstu")+"','"+correct+"','"+incorrect+"','"+d1.toString()+"','"+percent+"','"+(int)session.getAttribute("resultno")+"')");
				submission.executeUpdate();
				System.out.println(percent);
			
			
			%>
			<jsp:forward page="resultsdeclared.jsp"></jsp:forward>
			<%} %>
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