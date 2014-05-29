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
	private static Connection totalsCon;
	private static Statement totalSTMT;
	private static ResultSet totalRS;

	public static UserBean buildTemp(UserBean bean) {
		// prodString = new StringBuilder();
		prodString.append("");
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products where 1 = 1 "
				+ bean.genCat());// cat
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
		String users;
		if (bean.view.equals("customer")) {
			users = "SELECT * FROM users where 1 = 1 " + bean.genState()
					+ bean.genAge();// state, age
		} else {
			users = "SELECT states.name, states.id, states.name as state FROM states where 1 = 1"
					+ bean.genStatesState();
		}

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
				System.out.println("TEMP STRING: " + temp);
				// stmt.executeUpdate(temp);
				insertPlaceHolder(temp);
				bean.totUsers++;
				// bean = updateTable(bean);

			}
			System.out.println("Total users: " + bean.totUsers
					+ " &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
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
		// System.out.println("QUERY: " + temp);
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

	public static String getTotals(UserBean bean, String name) {
		String users;
		String total = "0";
		if (bean.view.equals("customer")) {

			users = "select users.name, sum(sales.price * sales.quantity) as totals "
					+ "from sales, users, products "
					+ "where sales.uid = users.id "
					+ "and sales.pid = products.id "
					+ "and users.name = '"
					+ name
					+ "' "
					+ bean.genAge()
					+ bean.genState()
					+ bean.genCat()
					+ " group by users.name order by users.name";
			// + bean.genAge() + bean.genState() + bean.genCat()
		} else {
			users = "select states.name, sum(sales.price * sales.quantity) as totals "
					+ "from users, states, sales, products "
					+ "where sales.uid = users.id "
					+ "and sales.pid = products.id "
					+ "and users.state = states.name "
					+ "and states.name = '"
					+ name
					+ "' "
					+ bean.genAge()
					+ bean.genState()
					+ bean.genCat()
					+ " group by states.name order by states.name";
		}
		/*
		 * private static Connection updateTableCon; private static Statement
		 * updateTableSTMT; private static ResultSet updateTableRS;
		 */
		try {
			updateTableCon = ConnectionManager.getConnection();
			totalSTMT = updateTableCon.createStatement();
			System.out.println(users);
			totalRS = totalSTMT.executeQuery(users);

			boolean more;

			while (more = totalRS.next()) {
				total = totalRS.getString("totals");

			}
			// bean.rsTotal = totalRS;

		} catch (Exception ex) {
			System.out
					.println("get totals Query failed: An Exception has occurred! "
							+ ex);
		}
		return total;
	}

	public static UserBean updateTable(UserBean bean) {
		// state, age, cat(id),
		String users;
		if (bean.view.equals("customer")) {
			users = "select users.name, users.id as uid, sales.pid, sum(sales.price * sales.quantity) "
					+ "from sales, products, users "
					+ "where sales.pid = products.id and sales.uid = users.id "
					+ bean.genState()
					+ bean.genCat()
					+ bean.genAge()
					+ " group by users.name, users.id, sales.pid";
			/*
			 * users =
			 * "select users.name, sales.uid, sales.pid, sum(sales.quantity * sales.price) "
			 * + "from sales, users, products " +
			 * "where users.id = sales.uid "// add var + bean.genAge() +
			 * bean.genState() + bean.genCat() +
			 * "group by users.name, sales.uid, sales.pid";
			 */
		} else {
			users = "select users.state as name, states.id as uid, sales.pid, sum(sales.price * sales.quantity) "
					+ "from users, sales, products, states "
					+ "where sales.uid = users.id "
					+ "and users.state = states.name "
					+ bean.genState()
					+ bean.genCat()
					+ bean.genAge()
					+ "group by users.state, states.id, sales.pid";

			/*
			 * users =
			 * "select users.state as name, states.id as uid, sales.pid, sum(sales.quantity * sales.price) "
			 * + "from users, sales, products " + "where sales.uid = users.id "
			 * + bean.genAge() + bean.genCat() + bean.genState() +
			 * "group by users.state, states.id, sales.pid";
			 */
			
		}
		System.out.println(users);
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
				String sum = updateTableRS.getString("sum");
//System.out.println("WHY???????????????????????????????"+updateTableRS.getString("sum"));
				if( !(bean.view.equals("customer")) )
				{
					sum = sum.substring(0, sum.length()-1);
				}
				temp = "UPDATE temp SET prod" + updateTableRS.getString("pid")
						+ " = " + sum
						+ " WHERE uid = " + updateTableRS.getString("uid");

				System.out.println(temp);
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
		String viewBy;
		if (bean.view.equals("customer")) {
			viewBy = "name";
		} else {
			viewBy = "state";
		}

		String query = "SELECT * FROM temp order by " + viewBy + " offset "
				+ next20 + " limit 20";

		System.out.println("Query: " + query);
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(query);
			next20 = next20 + 20;

			bean.rs = rs;

		} catch (Exception ex) {
			System.out
					.println("Get20 From Temp Query failed: An Exception has occurred! "
							+ ex);
		}
		// closeConn();

		return bean;
	}

	// ////////////////////////////////////////////////////////////////////////////////////////////////////
	public static UserBean products(UserBean bean) {
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products where 1 = 1 "
				+ bean.genCat()); // cat

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

	public static UserBean getCountProds(UserBean bean) {
		String str = "select count(*) from products where 1 =1 "
				+ bean.genCat();
		System.out.println("IN CAT QUERY");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			System.out.println("CAT QUERY: " + str);
			rs = stmt.executeQuery(str);
			System.out.println("RETURN RS CAT");
			// bean.setCatRS(rs);

			if (rs != null) {
				rs.next();
				bean.prodTot = Integer.parseInt(rs.getString("count"));
			}

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean getCountUsers(UserBean bean) {
		String str = "select count(temp.id) from temp";
		System.out.println("IN CAT QUERY");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			System.out.println("CAT QUERY: " + str);
			rs = stmt.executeQuery(str);
			System.out.println("RETURN RS CAT");
			// bean.setCatRS(rs);

			if (rs != null) {
				rs.next();
				bean.viewTot = Integer.parseInt(rs.getString("count"));
			}

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	/*
	 * private static Connection updateTableCon; private static Statement
	 * updateTableSTMT; private static ResultSet updateTableRS;
	 */
	public static void closeTotCon() {
		if (updateTableRS != null) {
			try {
				updateTableRS.close();
			} catch (Exception e) {
			}
			updateTableRS = null;
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
