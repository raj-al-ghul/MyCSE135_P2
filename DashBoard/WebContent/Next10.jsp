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

	<%
		/*int count = 0;
		int i = 0;
		boolean moreProd = true;

		currentUser = UserDAO.products(currentUser);

		String[] strArr = new String[10];

		while (count < 10 && (moreProd = currentUser.rs.next())) {

			if (i >= currentUser.prodOffset) {
				strArr[count] = "prod" + currentUser.rs.getString("id");
				count++;
			}
			i++;

		}

		System.out.println("i: " + i + " count: " + count + " prodOffset: "
				+ currentUser.prodOffset
				+ "****************************************");
		currentUser.prodOffset = i;
		UserDAO.closeConn();*/
	%>
	<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
		<TD><h1>View by Customer:</h1>

			<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
				<%
					int count = 0;
					int i = 0;
					boolean moreProd = true;
					String[] strArr = new String[10];

					currentUser = UserDAO.products(currentUser);
					//UserDAO.next20 = UserDAO.next20 - 20;
					//currentUser = UserDAO.get20FromTemp(currentUser);
					boolean more;
					int index = 0;
					while (count < 10 && (more = currentUser.rs.next())) {
						//System.out.println("i = " + i);

						if (i >= currentUser.prodOffset) {
							//System.out.println("IN THRE IF");
							strArr[count] = "prod" + currentUser.rs.getString("id");

							String prodName = currentUser.rs.getString("name");
							out.write("<TD><b>"
									+ prodName.substring(0,
											Math.min(prodName.length(), 10))
									+ "</b></TD>");
							count++;
						}
						i++;

					}
					currentUser.prodOffset = currentUser.prodOffset + count;
					UserDAO.closeConn();
				%>
				<%
					UserDAO.next20 = UserDAO.next20 - 20;
					currentUser = UserDAO.get20FromTemp(currentUser);

					more = true;
					index = 0;
					while (index < 20 && (more = currentUser.rs.next())) {
						index++;
						out.write("<TR>");

						for (i = 0; i < 10 && i < count; i++) {
							out.write("<TD>" + currentUser.rs.getString(strArr[i])
									+ "</TD>");

						}

						out.write("</TR>");
						//currentUser.curUsers++;
					}
					UserDAO.closeConn();
				%>

			</TABLE></TD>
	</TABLE>

	<center>
		<%
			System.out.println("^^^^^BUTTONS: " + currentUser.prodTot + " - "
					+ currentUser.prodCurr);
			System.out.println("^^^^^BUTTONS: " + currentUser.viewTot + " - "
					+ currentUser.viewCurr);

			if (currentUser.prodTot > currentUser.prodCurr) {
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
			/*
				System.out.println("curr: " + currentUser.curUsers + " tot: "
						+ currentUser.totUsers);
				String buttonView = "Customers";
				if (selectedView.equals("state")) {
					buttonView = "State";
				}*/
			//if (currentUser.curUsers < currentUser.totUsers)
			if (currentUser.viewTot > currentUser.viewCurr) {
		%>

		<form action="ControllerServlet">
			<input type="submit" value="Next 20 <%=currentUser.view%>s"
				style="height: 2em; width: 10em"><input type="hidden"
				name="st" value="3">
		</form>
		<%
			}
		%>


	</center>
</body>
</html>