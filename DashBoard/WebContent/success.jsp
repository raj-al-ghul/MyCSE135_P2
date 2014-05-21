<%@ page language="java"
	contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256" import="DashboardPackage.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Successful Query</title>
</head>
<body>
	<h1>CONGRATS!!!!!</h1>
	<%
		UserBean currentUser = (UserBean) (session
				.getAttribute("currentSessionUser"));
	%>

	
		<%
			boolean more;
			while (more = currentUser.rsBean.next()) {
				//System.out.println( "USER: " + currentUser.rsBean.getString("USER_NAME") );
				out.write(currentUser.rsBean.getString("USER_NAME") + "<br>");
			}
			UserDAO.closeConn(currentUser);%> 
				
				
				
			
	


</body>
</html>