<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256" import="DashboardPackage.*"
	import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		UserBean currentUser = (UserBean) (session
				.getAttribute("currentSessionUser"));
	%>

	<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
		<TD><h1>View by Customer:</h1>

			<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
				<TD><b>Name:</b></TD>
				<%
					currentUser = UserDAO.products(currentUser);
					int count = 0;
					boolean moreProd;
					while (moreProd = currentUser.rs.next()) {
						currentUser.prodCount++;
					}
					UserDAO.closeConn();


					currentUser = UserDAO.products(currentUser);

					String[] strArr = new String[10];

					while (count < 10 && (moreProd = currentUser.rs.next())) {
						out.write("<TD><b>" + currentUser.rs.getString("name")
								+ "</b></TD>");

						strArr[count] = "prod" + currentUser.rs.getString("id");
						count++;

					}
					UserDAO.closeConn();
				%>
				<%
					
					currentUser = UserDAO.get20FromTemp(currentUser);

					boolean more = true;
					int index = 0;
					while (index < 20 && (more = currentUser.rs.next())) {
						System.out.println("IN WHILE 20 from temp");
						index++;
						out.write("<TR>");
						String name;
						if (currentUser.view.equals("customer")) {
							name = currentUser.rs.getString("name");
						} else {
							name = currentUser.rs.getString("state");
						}
						out.write("<TD>" + name + "</TD>");

						for (int i = 0; i < count && i < 10; i++) {
							out.write("<TD>" + currentUser.rs.getString(strArr[i])
									+ "</TD>");

						}

						out.write("</TR>");
					}
					UserDAO.closeConn();
					//currentUser = UserDAO.closeConn(currentUser);
				%>




			</TABLE></TD>
	</TABLE>
	<center>

		<%
			if (currentUser.prodTot > currentUser.prodCurr) {
				System.out.println("in IF");
		%>

		<form action="ControllerServlet">
			<input type="submit" value="Next 10 Products"
				style="height: 2em; width: 10em"><input type="hidden"
				name="st" value="2">
		</form>
		<%
			}
		%>

		<%
			if (currentUser.viewTot > currentUser.viewCurr) {
		%>

		<form action="ControllerServlet">
			<input type="submit" value="Next 20 Names"
				style="height: 2em; width: 10em"><input type="hidden"
				name="st" value="3">
		</form>
		<%
			}
		%>
	</center>


	Prod Page
	<%=(int) (currentUser.prodCurr / 10)%>
	of
	<%=(int) Math.ceil((double) currentUser.prodTot / 10.0)%>

	View Page
	<%=(int) (currentUser.viewCurr / 20)%>
	of
	<%=(int) Math.ceil((double) currentUser.viewTot / 20.0)%>
</body>
</html>