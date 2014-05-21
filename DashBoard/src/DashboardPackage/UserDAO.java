package DashboardPackage;

import java.sql.*;

public class UserDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static Statement stmt = null;

	public static UserBean closeConn(UserBean bean) {

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
			rs = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
			stmt = null;
		}
		if (currentCon != null) {
			try {
				currentCon.close();
			} catch (Exception e) {
			}
			currentCon = null;
		}

		return bean;
	}

	public static UserBean first(UserBean bean) {
		//Statement stmt = null;

		String searchQuery = "select * from THE_USER";
		System.out.println("Query: " + searchQuery);
		try {
			currentCon = ConnectionManager.getConnection();
			System.out.println("AM I HERER?????");
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(searchQuery);

			/*boolean more = rs.next();

			if (!more) {
				System.out.println("Sorry, you are not a registered user!"
						+ " Please sign up first");
				bean.setValid(false);
			} else if (more) {
				String firstName = rs.getString("USER_NAME");
				System.out.println("TEST#$#$#$#$#");
				// String lastName = rs.getString("LastName");
				System.out.println("Welcome " + firstName);
				// JspWriter out = null;
				// out.write("<h1>TESTTTTTTTT</h1>");

			}*/

			bean.setRS(rs);

		} catch (Exception ex) {
			System.out.println("Log In failed: An Exception has occurred! "
					+ ex);
		} /*
		 * finally { if (rs != null) { try { rs.close(); } catch (Exception e) {
		 * } rs = null; } if (stmt != null) { try { stmt.close(); } catch
		 * (Exception e) { } stmt = null; } if (currentCon != null) { try {
		 * currentCon.close(); } catch (Exception e) { } currentCon = null; } }
		 */
		return bean;
	}

}
