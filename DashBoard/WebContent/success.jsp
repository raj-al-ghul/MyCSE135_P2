<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256" import="DashboardPackage.*"
	import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Successful Query</title>
</head>
<body>

	<%
		UserBean currentUser = (UserBean) (session
				.getAttribute("currentSessionUser"));

		String selectedView = currentUser.view;
		String selectedSt = currentUser.state;
		String selectedAge = currentUser.age;
		String selectedCat = currentUser.category;

		if (selectedView.equals("state")) {
			currentUser.viewTot = 50;
		} else {

		}
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
								<option
									<%if (selectedView.equals("customer")) {
				out.print("selected = \"selected\"");
			}%>
									value="customer">Customer</option>
								<option
									<%if (selectedView.equals("state")) {
				out.print("selected = \"selected\"");
			}%>
									value="state">State</option>
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
							if (selectedSt.equals("default")) {
								out.write("<option selected=\"selected\" value=\"default\">All</option>");
							} else {
								out.write("<option value=\"default\">All</option>");
							}
							for (int j = 0; j < states.length; j++) {
								if (selectedSt.equals(states[j])) {
									out.write("<option selected=\"selected\" value=\""
											+ states[j] + "\">" + states[j] + "</option>");
								} else {
									out.write("<option value=\"" + states[j] + "\">"
											+ states[j] + "</option>");
								}
							}
							out.write("</select></TD>");
						%>

						<TD><select name="age">
								<option
									<%if (selectedAge.equals("ageAll")) {
				out.print("selected = \"selected\"");
			}%>
									value="default">All</option>
								<option
									<%if (selectedAge.equals("age0")) {
				out.print("selected = \"selected\"");
			}%>
									value="age0">12-18</option>
								<option
									<%if (selectedAge.equals("age1")) {
				out.print("selected = \"selected\"");
			}%>
									value="age1">18-45</option>
								<option
									<%if (selectedAge.equals("age2")) {
				out.print("selected = \"selected\"");
			}%>
									value="age2">45-65</option>
								<option
									<%if (selectedAge.equals("age3")) {
				out.print("selected = \"selected\"");
			}%>
									value="age3">Over 65</option>
						</select></TD>

						<TD><select name="category">
								<option value="default">All</option>
								<%
									currentUser = UserDAO.getCat(currentUser);
									System.out.println("PARSE CAT QUERY");
									boolean moreCat;
									String catId, catNm;
									int i = 0;
									while (moreCat = currentUser.rs.next()) {
										catNm = currentUser.rs.getString("name");
										catId = currentUser.rs.getString("id");

										if (selectedCat.equals(catId)) {
											out.write("<option selected = \"selected\" value=\""
													+ catId + "\">" + catNm + "</option>");
										} else {
											out.write("<option value=\"" + catId + "\">" + catNm
													+ "</option>");
										}
										i++;
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

		<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">

			<%
				String header;
				if (selectedView.equals("customer")) {
					header = "Customer";
				} else {
					header = "State";
				}
			%>
			<TD><h1>
					View by
					<%
				out.write(header);
			%>:
				</h1>
				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD><b> <%
 	out.write(header);
 %>:
					</b></TD>
					<%
						currentUser = UserDAO.products(currentUser);
						int count = 0;
						boolean moreProd;
						while (moreProd = currentUser.rs.next()) {
							currentUser.prodCount++;
						}
						UserDAO.closeConn();

						System.out.println("Products counted : " + currentUser.prodCount
								+ "#$#$%$%$#%$@#@%#@$@%$^%^&%^&^&^&&$&%%#^^^$#$^#^$#");
						currentUser = UserDAO.products(currentUser);

						String[] strArr = new String[10];

						while (count < 10 && (moreProd = currentUser.rs.next())) {
							String prodName = currentUser.rs.getString("name");
							out.write("<TD><b>"
									+ prodName.substring(0, Math.min(prodName.length(), 10))
									+ "</b></TD>");

							System.out.println("PRODUCT NAME: ");
							strArr[count] = "prod" + currentUser.rs.getString("id");
							count++;

						}
						currentUser.prodOffset = count;
						UserDAO.closeConn();
					%>


					<%
						currentUser = UserDAO.buildTemp(currentUser);
						UserDAO.closeConn();
						currentUser = UserDAO.fillTable(currentUser);
						UserDAO.closeConn();
						currentUser = UserDAO.updateTable(currentUser);
						UserDAO.closeConn();

						/*button stuff*/
						if (selectedView.equals("customer")) {
							currentUser = UserDAO.getCountUsers(currentUser);
							UserDAO.closeConn();
						}
			

						currentUser = UserDAO.getCountProds(currentUser);
						UserDAO.closeConn();
						currentUser = UserDAO.get20FromTemp(currentUser);

						boolean more = true;
						int index = 0;
						while (index < 20 && (more = currentUser.rs.next())) {
							index++;
							out.write("<TR>");
							String name;
							if (currentUser.view.equals("customer")) {
								name = currentUser.rs.getString("name");
							} else {
								name = currentUser.rs.getString("state");
							}
							out.write("<TD>" + name + "</TD>");

							for (i = 0; i < count && i < 10; i++) {

								out.write("<TD>$" + currentUser.rs.getString(strArr[i])
										+ ".00</TD>");

							}

							out.write("</TR>");
							currentUser.curUsers++;
						}
						UserDAO.closeConn();
						//currentUser = UserDAO.closeConn(currentUser);
						if (selectedView.equals("state")) {
							currentUser.totUsers = 50;
						}
					%>




				</TABLE></TD>
		</TABLE>

	</form>

	<center>

		<%
			System.out.println("^^^^^BUTTONS PRD: " + currentUser.prodTot + " - "
					+ currentUser.prodCurr);
			System.out.println("^^^^^BUTTONS VIE: " + currentUser.viewTot + " - "
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
			<input type="submit" value="Next 20 <%=selectedView%>s"
				style="height: 2em; width: 10em"><input type="hidden"
				name="st" value="3">
		</form>
		<%
			}
		%>

	</center>


</body>
</html>