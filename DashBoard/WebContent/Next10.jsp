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
					int count = 0;
					int i;
					boolean moreProd = true;

					String[] strArr = new String[10];
					while (count < 10 && (moreProd = currentUser.prodRS.next())) {
						out.write("<TD><b>" + currentUser.prodRS.getString("name")
								+ "</b></TD>");

						strArr[count] = "prod" + currentUser.prodRS.getString("id");
						count++;

					}
				%>

				<%
					boolean more;
					int index = 0;
					while (more = currentUser.rsAllTemp.next() && index < 10) {
						index++;
						out.write("<TR>");
						String name = currentUser.rsAllTemp.getString("name");
						out.write("<TD>" + name + "</TD>");

						for (i = 0; i < count; i++) {
							out.write("<TD>"
									+ currentUser.rsAllTemp.getString("prod"
											+ currentUser.strArr
													.get(currentUser.prodIndex))
									+ "</TD>");
							currentUser.prodIndex++;

						}

						out.write("</TR>");
					}

					currentUser = UserDAO.closeConn(currentUser);
				%>

			</TABLE></TD>
	</TABLE>



	<center>
		<form action="ControllerServlet">
			<input type="submit" value="Next 10 Products"
				style="height: 2em; width: 10em"><input type="hidden"
				name="st" value="2">
		</form>
		<%
			if (more == true) {
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
</body>
</html>