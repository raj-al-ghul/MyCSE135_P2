<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256" import="DashboardPackage.*"%>

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

		String selected = "default";
		if (currentUser.view != null) {
			selected = currentUser.view;
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
								<option value="default">Choose:</option>
								<option
									<%if (selected.equals("customer")) {
				out.print("selected = \"selected\"");
			}%>
									value="customer">Customer</option>
								<option
									<%if (selected.equals("state")) {
				out.print("selected = \"selected\"");
			}%>
									value="state">State</option>
						</select></TD>
						<TD><select name="state" size="1">
								<option value="ALL">All</option>
								<option value="AL">Alabama</option>
								<option value="AK">Alaska</option>
								<option value="AZ">Arizona</option>
								<option value="AR">Arkansas</option>
								<option value="CA">California</option>
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="DC">District of Columbia</option>
								<option value="FL">Florida</option>
								<option value="GA">Georgia</option>
								<option value="HI">Hawaii</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="IN">Indiana</option>
								<option value="IA">Iowa</option>
								<option value="KS">Kansas</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MD">Maryland</option>
								<option value="MA">Massachusetts</option>
								<option value="MI">Michigan</option>
								<option value="MN">Minnesota</option>
								<option value="MS">Mississippi</option>
								<option value="MO">Missouri</option>
								<option value="MT">Montana</option>
								<option value="NE">Nebraska</option>
								<option value="NV">Nevada</option>
								<option value="NH">New Hampshire</option>
								<option value="NJ">New Jersey</option>
								<option value="NM">New Mexico</option>
								<option value="NY">New York</option>
								<option value="NC">North Carolina</option>
								<option value="ND">North Dakota</option>
								<option value="OH">Ohio</option>
								<option value="OK">Oklahoma</option>
								<option value="OR">Oregon</option>
								<option value="PA">Pennsylvania</option>
								<option value="RI">Rhode Island</option>
								<option value="SC">South Carolina</option>
								<option value="SD">South Dakota</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="UT">Utah</option>
								<option value="VT">Vermont</option>
								<option value="VA">Virginia</option>
								<option value="WA">Washington</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
						</select></TD>
						<TD><select>
								<option value="ageAll">All</option>
								<option value="age0">12-18</option>
								<option value="age1">18-45</option>
								<option value="age2">45-65</option>
								<option value="age3">Over 65</option>
						</select></TD>
						<TD><select>
								<option value="prodAll">All</option>
								<%
									System.out.println("PARSE CAT QUERY");
									boolean moreCat;
									int i = 0;
									if (currentUser == null) {
										System.out.println("NULL BEAN");
									} else {
										System.out.println("NOT NULL");
										while (moreCat = currentUser.rsCat.next()) {
											out.write("<option value=\"cat"+i+"\">"
													+ currentUser.rsCat.getString("name") + "</option>");
										}
									}
								%>
								<option value="prod0">Prod0</option>
								<option value="prod1">Prod1</option>
								<option value="prod2">Prod2</option>
								<option value="prod3">Prod3</option>
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
			<TD><h1>View by Customer:</h1> <%
 	int count = 0;
 %>
				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD><b>Name:</b></TD>
					<%
						boolean moreProd;
						while (moreProd = currentUser.prodRS.next()) {
							out.write("<TD><b>" + currentUser.prodRS.getString("name")
									+ "</b></TD>");
							count++;
						}
						System.out.println("COUNT: " + count);
					%>


					<%
						boolean more;
						while (more = currentUser.rsBean.next()) {
							out.write("<TR>");
							String name = currentUser.rsBean.getString("name");
							out.write("<TD>" + name + "</TD>");

							for (i = 0; i < count; i++) {
								out.write("<TD>" + i + "</TD>");
							}

							/*out.write("<TD>" + 0 + "</TD>");
							out.write("<TD>" + 0 + "</TD>");
							out.write("<TD>" + 0 + "</TD>");
							out.write("<TD>" + 0 + "</TD>");
							out.write("<TD>" + 0 + "</TD>");*/
							out.write("</TR>");
						}

						currentUser = UserDAO.closeConn(currentUser);
					%>




				</TABLE></TD>
		</TABLE>
		<center>
			<input type="submit" value="Next 10 Products"
				style="height: 2em; width: 10em"> <input type="submit"
				value="Next 20 Names" style="height: 2em; width: 10em">
		</center>
	</form>








</body>
</html>