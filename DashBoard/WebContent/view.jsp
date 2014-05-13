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

		<select>
			<option value="owner">Owner</option>
			<option value="state">State</option>
		</select><br>

		<TABLE BORDER="3" CELLPADDING="10" CELLSPACING="10">
			<TD>

				<TABLE BORDER="3" CELLPADDING="3" CELLSPACING="3">
					<TD>2nd                 Table</TD>
					<TD>2nd                 Table</TD>
					<TR>
						<TD>2nd&nbsp;Table</TD>
						<TD>2nd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Table</TD>
					</TR>
				</TABLE>

			</TD>
			<TD>The cell next to this one has a smaller table inside of it,
				a table inside a table.</TD>
		</TABLE>

	</form>
</body>
</html>