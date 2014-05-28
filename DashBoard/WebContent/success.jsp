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
						</select></TD> value="state">State
						</option>
						</select>
						</TD>
						<TD><select name="state" size="1">
								<option
									<%if (selectedSt.equals("default")) {
				out.print("selected = \"selected\"");
			}%>
									value="default">All</option>
								<option
									<%if (selectedSt.equals("AL")) {
				out.print("selected = \"selected\"");
			}%>
									value="AL">Alabama</option>
								<option
									<%if (selectedSt.equals("AK")) {
				out.print("selected = \"selected\"");
			}%>
									value="AK">Alaska</option>
								<option
									<%if (selectedSt.equals("AZ")) {
				out.print("selected = \"selected\"");
			}%>
									value="AZ">Arizona</option>
								<option
									<%if (selectedSt.equals("AR")) {
				out.print("selected = \"selected\"");
			}%>
									value="AR">Arkansas</option>
								<option
									<%if (selectedSt.equals("CA")) {
				out.print("selected = \"selected\"");
			}%>
									value="CA">California</option>
								<option
									<%if (selectedSt.equals("C0")) {
				out.print("selected = \"selected\"");
			}%>
									value="CO">Colorado</option>
								<option
									<%if (selectedSt.equals("CT")) {
				out.print("selected = \"selected\"");
			}%>
									value="CT">Connecticut</option>
								<option
									<%if (selectedSt.equals("DE")) {
				out.print("selected = \"selected\"");
			}%>
									value="DE">Delaware</option>
								<option
									<%if (selectedSt.equals("DC")) {
				out.print("selected = \"selected\"");
			}%>
									value="DC">District of Columbia</option>
								<option
									<%if (selectedSt.equals("FL")) {
				out.print("selected = \"selected\"");
			}%>
									value="FL">Florida</option>
								<option
									<%if (selectedSt.equals("GA")) {
				out.print("selected = \"selected\"");
			}%>
									value="GA">Georgia</option>
								<option
									<%if (selectedSt.equals("HI")) {
				out.print("selected = \"selected\"");
			}%>
									value="HI">Hawaii</option>
								<option
									<%if (selectedSt.equals("ID")) {
				out.print("selected = \"selected\"");
			}%>
									value="ID">Idaho</option>
								<option
									<%if (selectedSt.equals("IL")) {
				out.print("selected = \"selected\"");
			}%>
									value="IL">Illinois</option>
								<option
									<%if (selectedSt.equals("IN")) {
				out.print("selected = \"selected\"");
			}%>
									value="IN">Indiana</option>
								<option
									<%if (selectedSt.equals("IA")) {
				out.print("selected = \"selected\"");
			}%>
									value="IA">Iowa</option>
								<option
									<%if (selectedSt.equals("KS")) {
				out.print("selected = \"selected\"");
			}%>
									value="KS">Kansas</option>
								<option
									<%if (selectedSt.equals("KY")) {
				out.print("selected = \"selected\"");
			}%>
									value="KY">Kentucky</option>
								<option
									<%if (selectedSt.equals("LA")) {
				out.print("selected = \"selected\"");
			}%>
									value="LA">Louisiana</option>
								<option
									<%if (selectedSt.equals("ME")) {
				out.print("selected = \"selected\"");
			}%>
									value="ME">Maine</option>
								<option
									<%if (selectedSt.equals("MD")) {
				out.print("selected = \"selected\"");
			}%>
									value="MD">Maryland</option>
								<option
									<%if (selectedSt.equals("MA")) {
				out.print("selected = \"selected\"");
			}%>
									value="MA">Massachusetts</option>
								<option
									<%if (selectedSt.equals("MI")) {
				out.print("selected = \"selected\"");
			}%>
									value="MI">Michigan</option>
								<option
									<%if (selectedSt.equals("MN")) {
				out.print("selected = \"selected\"");
			}%>
									value="MN">Minnesota</option>
								<option
									<%if (selectedSt.equals("MS")) {
				out.print("selected = \"selected\"");
			}%>
									value="MS">Mississippi</option>
								<option
									<%if (selectedSt.equals("MO")) {
				out.print("selected = \"selected\"");
			}%>
									value="MO">Missouri</option>
								<option
									<%if (selectedSt.equals("MT")) {
				out.print("selected = \"selected\"");
			}%>
									value="MT">Montana</option>
								<option
									<%if (selectedSt.equals("NE")) {
				out.print("selected = \"selected\"");
			}%>
									value="NE">Nebraska</option>
								<option
									<%if (selectedSt.equals("NV")) {
				out.print("selected = \"selected\"");
			}%>
									value="NV">Nevada</option>
								<option
									<%if (selectedSt.equals("NH")) {
				out.print("selected = \"selected\"");
			}%>
									value="NH">New Hampshire</option>
								<option
									<%if (selectedSt.equals("NJ")) {
				out.print("selected = \"selected\"");
			}%>
									value="NJ">New Jersey</option>
								<option
									<%if (selectedSt.equals("NM")) {
				out.print("selected = \"selected\"");
			}%>
									value="NM">New Mexico</option>
								<option
									<%if (selectedSt.equals("NY")) {
				out.print("selected = \"selected\"");
			}%>
									value="NY">New York</option>
								<option
									<%if (selectedSt.equals("NC")) {
				out.print("selected = \"selected\"");
			}%>
									value="NC">North Carolina</option>
								<option
									<%if (selectedSt.equals("ND")) {
				out.print("selected = \"selected\"");
			}%>
									value="ND">North Dakota</option>
								<option
									<%if (selectedSt.equals("OH")) {
				out.print("selected = \"selected\"");
			}%>
									value="OH">Ohio</option>
								<option
									<%if (selectedSt.equals("OK")) {
				out.print("selected = \"selected\"");
			}%>
									value="OK">Oklahoma</option>
								<option
									<%if (selectedSt.equals("OR")) {
				out.print("selected = \"selected\"");
			}%>
									value="OR">Oregon</option>
								<option
									<%if (selectedSt.equals("PA")) {
				out.print("selected = \"selected\"");
			}%>
									value="PA">Pennsylvania</option>
								<option
									<%if (selectedSt.equals("RI")) {
				out.print("selected = \"selected\"");
			}%>
									value="RI">Rhode Island</option>
								<option
									<%if (selectedSt.equals("SC")) {
				out.print("selected = \"selected\"");
			}%>
									value="SC">South Carolina</option>
								<option
									<%if (selectedSt.equals("SD")) {
				out.print("selected = \"selected\"");
			}%>
									value="SD">South Dakota</option>
								<option
									<%if (selectedSt.equals("TN")) {
				out.print("selected = \"selected\"");
			}%>
									value="TN">Tennessee</option>
								<option
									<%if (selectedSt.equals("TX")) {
				out.print("selected = \"selected\"");
			}%>
									value="TX">Texas</option>
								<option
									<%if (selectedSt.equals("UT")) {
				out.print("selected = \"selected\"");
			}%>
									value="UT">Utah</option>
								<option
									<%if (selectedSt.equals("VT")) {
				out.print("selected = \"selected\"");
			}%>
									value="VT">Vermont</option>
								<option
									<%if (selectedSt.equals("VA")) {
				out.print("selected = \"selected\"");
			}%>
									value="VA">Virginia</option>
								<option
									<%if (selectedSt.equals("WA")) {
				out.print("selected = \"selected\"");
			}%>
									value="WA">Washington</option>
								<option
									<%if (selectedSt.equals("WV")) {
				out.print("selected = \"selected\"");
			}%>
									value="WV">West Virginia</option>
								<option
									<%if (selectedSt.equals("WI")) {
				out.print("selected = \"selected\"");
			}%>
									value="WI">Wisconsin</option>
								<option
									<%if (selectedSt.equals("WY")) {
				out.print("selected = \"selected\"");
			}%>
									value="WY">Wyoming</option>
						</select></TD>

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
									String cat;
									int i = 0;
									while (moreCat = currentUser.rs.next()) {
										cat = currentUser.rs.getString("name");
										if (selectedCat.equals(cat)) {
											out.write("<option selected = \"selected\" value=\"" + cat
													+ "\">" + cat + "</option>");
										} else {
											out.write("<option value=\"" + cat + "\">" + cat
													+ "</option>");
										}
										i++;
									}
									UserDAO.closeConn();
									currentUser.makeStrings();
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
							out.write("<TD><b>" + currentUser.rs.getString("name")
									+ "</b></TD>");

							strArr[count] = "prod" + currentUser.rs.getString("id");
							count++;

						}
						UserDAO.closeConn();
					%>


					<%
						currentUser = UserDAO.buildTemp(currentUser);
						UserDAO.closeConn();
						currentUser = UserDAO.fillTable(currentUser);
						UserDAO.closeConn();
						currentUser = UserDAO.updateTable(currentUser);
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

	</form>

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