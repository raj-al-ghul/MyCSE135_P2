<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256" import="DashboardPackage.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>Project 2: Dashboard</title>
</head>
<body>
	<%
		UserBean currentUser = (UserBean) (session
				.getAttribute("currentSessionUser"));
		//currentUser = UserDAO.getCat(currentUser);
	%>
	<form action="ControllerServlet">

		<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
			<TD>

				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD><b></>Select View:</b></TD>
					<TD><b></>Select State:</b></TD>
					<TD><b></>Select Age:</b></TD>
					<TD><b></>Select Category:</b></TD>
					<TD><b>Execute Query:</b></TD>
					<TR>
						<TD><select name="view">
								<option value="customer">Customer</option>
								<option value="state">State</option>
						</select></TD>
						<%
							String[] states = { "Alabama", "Alaska", "Arizona", "Arkansas",
									"California", "Colorado", "Connecticut", "Delaware",
									"Florida", "Georgia", "Hawaii", "Idaho", "Illinois",
									"Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
									"Maine", "Maryland", "Massachusetts", "Michigan",
									"Minnesota", "Mississippi", "Missouri", "Montana",
									"Nebraska", "Nevada", "New Hampshire", "New Jersey",
									"New Mexico", "New York", "North Carolina", "North Dakota",
									"Ohio", "Oklahoma", "Oregon", "Pennsylvania",
									"Rhode Island", "South Carolina", "South Dakota",
									"Tennessee", "Texas", "Utah", "Vermont", "Virginia",
									"Washington", "West Virginia", "Wisconsin", "Wyoming" };
							out.write("<TD><select name=\"state\" size=\"1\">");
							out.write("<option value=\"default\">All</option>");
							for (int j = 0; j < states.length; j++) {
								out.write("<option value=\"" + states[j] + "\">" + states[j]
										+ "</option>");
							}
							out.write("</select></TD>");
						%>

						<TD><select name="age">
								<option value="default">All</option>
								<option value="age0">12-18</option>
								<option value="age1">18-45</option>
								<option value="age2">45-65</option>
								<option value="age3">Over 65</option>
						</select></TD>

						<TD><select name="category">
								<option value="default">All</option>
								<%
									currentUser = UserDAO.getCat(currentUser);
									System.out.println("PARSE CAT QUERY");
									boolean moreCat;
									int i = 0;
									if (currentUser == null) {
										System.out.println("NULL BEAN");
									} else {
										System.out.println("NOT NULL");
										while (moreCat = currentUser.rs.next()) {
											String catNm = currentUser.rs.getString("name");
											String catId = currentUser.rs.getString("id");
											out.write("<option value=\"" + catId + "\">" + catNm
													+ "</option>");

											i++;
										}
									}
									UserDAO.closeConn();
								%>

						</select></TD>
						<TD><center>
								<input type="submit" value="Run" style="height: 2em; width: 7em"><input
									type="hidden" name="st" value="1">
							</center></TD>
					</TR>

				</TABLE>

			</TD>

		</TABLE>

	</form>
</body>
</html>