<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>Login Page</title>
</head>
<body>
	<form action="ControllerServlet">
		Please enter your username <input type="text" name="un" /><br>
		Please enter your password <input type="text" name="pw" /> <input
			type="submit" value="submit">
	</form>
	<br>
	<form>

		<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
			<TD>

				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD>Select View:</TD>
					<TD>Select State:</TD>
					<TD>Select Age:</TD>
					<TD>Select Product:</TD>
					<TD>Execute Query:</TD>
					<TR>
						<TD><select>
								<option value="owner">Owner</option>
								<option value="state">State</option>
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
								<option value="prod0">Prod0</option>
								<option value="prod1">Prod1</option>
								<option value="prod2">Prod2</option>
								<option value="prod3">Prod3</option>
						</select></TD>
						<TD><input type="submit" value="Run"></TD>
					</TR>

				</TABLE>

			</TD>

		</TABLE>

		<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
			<TD><h1>View by Owner:</h1>

				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD><b>Name:</b></TD>
					<TD><b>State:</b></TD>
					<TD><b>Total Sales:</b></TD>
					<TR>
						<TD>2nd&nbsp;Table</TD>
						<TD>2nd&nbsp;Table</TD>
						<TD>2nd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Table</TD>
					</TR>
				</TABLE>

			</TD>
		</TABLE>
	</form>
</body>
</html>