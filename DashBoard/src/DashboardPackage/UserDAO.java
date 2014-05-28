package DashboardPackage;

import java.sql.*;

public class UserDAO {

	private static ResultSet rs;
	private static Statement stmt;
	private static Connection currentCon;
	private static StringBuilder prodString = new StringBuilder();
	private static int prodCount;

	// /////////////////
	private static Connection currentConTemp;
	private static Statement stmtTemp;
	private static ResultSet result;
	// ////////////////
	// /////////////////
	private static Connection updateTableCon;
	private static Statement updateTableSTMT;
	private static ResultSet updateTableRS;
	public static int next20 = 0;

	// //////////////////////

	public static UserBean buildTemp(UserBean bean) {
		// prodString = new StringBuilder();
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products");
		System.out.println(productQuery.toString());
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(productQuery.toString());

			boolean more;

			StringBuilder strB = new StringBuilder();
			strB.append("DROP TABLE IF EXISTS temp; ");
			strB.append("CREATE TABLE temp ( id SERIAL PRIMARY KEY, name TEXT, uid INTEGER, state TEXT ");
			while (more = rs.next()) {
				System.out.println("strB :");
				String product = rs.getString("id");
				System.out.println("product " + product);
				prodString.append(", prod" + product);
				// System.out.println("String: " + prodString.toString());
				// prodString is used later in fillTable
				strB.append(", prod" + product + " FLOAT ");
				prodCount++;
			}

			strB.append(" )");
			String str = strB.toString();
			System.out.println("Query: " + str);

			stmt.executeUpdate(str);
			System.out.println("TABLE CREATED");

			// bean.setProdRS(prodRS);
			// bean = fillTable(bean);

		} catch (Exception ex) {
			System.out
					.println("Build Temp Query failed: An Exception has occurred! "
							+ ex);
		}

		return bean;
	}

	// ////////////////////////////////////////////////////////////////////////////////////////////////
	public static UserBean fillTable(UserBean bean) {

		// get all the users, and insert into the table one at a time with 0's.
		String users = "SELECT * FROM users";
		StringBuilder query = new StringBuilder();
		query.append("INSERT INTO temp(name, uid, state " + prodString
				+ " ) VALUES( ");
		prodString.delete(0, prodString.length());
		String tempStr = query.toString();
		System.out.println("QUERY: " + tempStr);
		try {
			// name, uid, state, n*products
			currentConTemp = ConnectionManager.getConnection();
			stmtTemp = currentConTemp.createStatement();

			result = stmtTemp.executeQuery(users);

			boolean more;

			while (more = result.next()) {
				String temp = new String();
				temp = tempStr;
				temp = temp
						+ ("'" + result.getString("name") + "', "
								+ result.getString("id") + ", '"
								+ result.getString("state") + "' ");
				for (int i = 0; i < prodCount; i++) {
					temp = temp + ", 0.0";
				}
				// prodCount = 0;
				temp = temp + ")";

				// stmt.executeUpdate(temp);
				insertPlaceHolder(temp);

				// bean = updateTable(bean);

			}
			prodCount = 0;

		} catch (Exception ex) {
			System.out
					.println("Fill Table Query failed: An Exception has occurred! "
							+ ex);
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (Exception e) {
				}
				result = null;
			}
			if (stmtTemp != null) {
				try {
					stmtTemp.close();
				} catch (Exception e) {
				}
				stmtTemp = null;
			}
			if (currentConTemp != null) {
				try {
					currentConTemp.close();
				} catch (Exception e) {
				}
				currentConTemp = null;
			}
		}

		return bean;
	}

	private static void insertPlaceHolder(String temp) {

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			stmt.executeUpdate(temp);

			// bean.setCatRS(rs);
		} catch (Exception ex) {
			System.out
					.println("Insert Place Holder Query failed: An Exception has occurred! "
							+ ex);
		}
		closeConn();
	}

	public static UserBean updateTable(UserBean bean) {

		String users = "select users.name, sales.uid, sales.pid, sum(sales.quantity * sales.price) "
				+ "from sales, users "
				+ "where users.id = sales.uid "
				+ "group by users.name, uid, pid;";

		/*
		 * query = "UPDATE temp SET prod" + getString("pid") + " = " +
		 * getString("sum") + " WHERE uid = " + getString("uid");
		 */
		try {

			updateTableCon = ConnectionManager.getConnection();
			updateTableSTMT = updateTableCon.createStatement();

			updateTableRS = updateTableSTMT.executeQuery(users);

			boolean more;

			while (more = updateTableRS.next()) {
				String temp = new String();

				temp = "UPDATE temp SET prod" + updateTableRS.getString("pid")
						+ " = " + updateTableRS.getString("sum")
						+ " WHERE uid = " + updateTableRS.getString("uid");

				// System.out.println(temp);
				// stmt.executeUpdate(temp);
				// System.out.println("TABLE UPDATED");
				executeTableUpdate(temp);
				// bean = getAllTemp(bean);

			}

		} catch (Exception ex) {
			System.out
					.println("Update Table Query failed: An Exception has occurred! "
							+ ex);
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (Exception e) {
				}
				result = null;
			}
			if (updateTableSTMT != null) {
				try {
					updateTableSTMT.close();
				} catch (Exception e) {
				}
				updateTableSTMT = null;
			}
			if (updateTableCon != null) {
				try {
					updateTableCon.close();
				} catch (Exception e) {
				}
				updateTableCon = null;
			}
		}

		return bean;
	}

	public static void executeTableUpdate(String str) {
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			stmt.executeUpdate(str);

			// bean.setCatRS(rs);
		} catch (Exception ex) {
			System.out
					.println("Execute Table Update Query failed: An Exception has occurred! "
							+ ex);
		}
		closeConn();
	}

	public static UserBean get20FromTemp(UserBean bean) {

		String query = "SELECT * FROM temp order by name offset " + next20
				+ " limit 20";
		
		System.out.println("Query: " + query);
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(query);
			next20 = next20 + 20;

			bean.rs = rs;

		} catch (Exception ex) {
			System.out
					.println("Get20 From Temp Query failed: An Exception has occurred! " + ex);
		}
		//closeConn();
		
		return bean;
	}

	// ////////////////////////////////////////////////////////////////////////////////////////////////////
	public static UserBean products(UserBean bean) {
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(productQuery.toString());

			// bean.setProdRS(rs);
			bean.rs = rs;

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean getCat(UserBean bean) {
		String str = "select * from categories";
		System.out.println("IN CAT QUERY");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			System.out.println("CAT QUERY: " + str);
			rs = stmt.executeQuery(str);
			System.out.println("RETURN RS CAT");
			// bean.setCatRS(rs);
			bean.rs = rs;

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static void closeConn() {

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

	}

}// end class
