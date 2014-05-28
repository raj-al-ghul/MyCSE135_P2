package DashboardPackage;

import java.sql.*;

/*select * from users join sales on users.id = sales.uid;*/

/*select users.name, sales.uid, sales.pid, count(sales.pid) from sales, users  
 *where users.id = sales.uid 
 *group by users.name, uid, pid;*/

public class UserDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static ResultSet prodRS = null;
	static ResultSet tempRS = null;
	static Statement stmt = null;
	static ResultSet catRS = null;
	static ResultSet allTempRS = null;
	private static StringBuilder prodString = new StringBuilder();
	private static int prodCount = 0;
	private static int next10 = 0;

	//public static void closeConn()
	
	
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

	public static UserBean getCat(UserBean bean) {
		String str = "select * from categories";
		System.out.println("IN CAT QUERY");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			System.out.println("CAT QUERY: " + str);
			catRS = stmt.executeQuery(str);
			System.out.println("RETURN RS CAT");
			bean.setCatRS(catRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean products(UserBean bean) {
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			prodRS = stmt.executeQuery(productQuery.toString());

			bean.setProdRS(prodRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}
		return bean;
	}

	public static UserBean viewTable(UserBean bean) {
		StringBuilder query = new StringBuilder();
		query.append("DROP TABLE IF EXISTS temp_table; "
				+ "CREATE TABLE temp_table AS "
				+ "(select users.name, sales.uid, sales.pid, sum(sales.quantity * sales.price) AS total "
				+ "from sales, users " + "where users.id = sales.uid "
				+ "group by users.name, uid, pid)");

		System.out.println("Query: " + query);
		try {
			currentCon = ConnectionManager.getConnection();

			stmt = currentCon.createStatement();

			stmt.executeUpdate(query.toString());
			// prodRS = stmt.executeQuery(productQuery);
			// tempRS = stmt.executeQuery("SELECT * FROM temp_table");

			// bean.setTempRS(tempRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean buildTemp(UserBean bean) {
		//prodString = new StringBuilder();
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products");
		System.out.println(productQuery.toString());
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			ResultSet prod = stmt.executeQuery(productQuery.toString());

			boolean more;

			StringBuilder strB = new StringBuilder();
			strB.append("DROP TABLE IF EXISTS temp; ");
			strB.append("CREATE TABLE temp ( id SERIAL PRIMARY KEY, name TEXT, uid INTEGER, state TEXT ");
			while (more = prod.next()) {
				System.out.println("strB :");
				String product = prod.getString("id");
				System.out.println("product " + product);
				prodString.append(", prod" + product);
				//System.out.println("String: " + prodString.toString());
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
			bean = fillTable(bean);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	private static UserBean fillTable(UserBean bean) {

		String users = "SELECT * FROM users";
		StringBuilder query = new StringBuilder();
		query.append("INSERT INTO temp(name, uid, state " + prodString
				+ " ) VALUES( ");
		prodString.delete(0, prodString.length());
		String tempStr = query.toString();
		System.out.println("QUERY: " + tempStr);
		try {
			// name, uid, state, n*products
			Connection currentConTemp = ConnectionManager.getConnection();
			Statement stmtTemp = currentConTemp.createStatement();

			ResultSet result = stmtTemp.executeQuery(users);

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
				System.out.println(temp);
				stmt.executeUpdate(temp);
				System.out.println("TABLE UPDATED");

				bean = updateTable(bean);

			}
			prodCount = 0;

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	private static UserBean updateTable(UserBean bean) {

		String users = "select users.name, sales.uid, sales.pid, sum(sales.quantity * sales.price) "
				+ "from sales, users "
				+ "where users.id = sales.uid "
				+ "group by users.name, uid, pid;";

		/*
		 * query = "UPDATE temp SET prod" + getString("pid") + " = " +
		 * getString("sum") + " WHERE uid = " + getString("uid");
		 */
		try {

			Connection currentConTemp = ConnectionManager.getConnection();
			Statement stmtTemp = currentConTemp.createStatement();

			ResultSet result = stmtTemp.executeQuery(users);

			boolean more;

			while (more = result.next()) {
				String temp = new String();

				temp = "UPDATE temp SET prod" + result.getString("pid") + " = "
						+ result.getString("sum") + " WHERE uid = "
						+ result.getString("uid");

				System.out.println(temp);
				stmt.executeUpdate(temp);
				System.out.println("TABLE UPDATED");

				bean = getAllTemp(bean);

			}

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	
	public static UserBean getAllTemp(UserBean bean) {

		String query = "SELECT * FROM temp order by name offset " + next10 + " limit 10";
		System.out.println("Query: " + query);
		try {
			currentCon = ConnectionManager.getConnection();
			System.out.println("IN GET ALL TEMP");
			stmt = currentCon.createStatement();

			allTempRS = stmt.executeQuery(query);
			next10 = next10 + 10;
			// prodRS = stmt.executeQuery(productQuery);

			bean.setAllTempRS(allTempRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean get10Again(UserBean bean)
	{
		return bean;
	}
	public static UserBean name(UserBean bean) {
		// Statement stmt = null;

		String searchQuery = "select * from users";
		// String productQuery = "select * from PRODUCTS";
		System.out.println("Query: " + searchQuery);
		try {
			currentCon = ConnectionManager.getConnection();
			System.out.println("AM I HERER?????");
			stmt = currentCon.createStatement();

			rs = stmt.executeQuery(searchQuery);
			// prodRS = stmt.executeQuery(productQuery);

			bean.setRS(rs);
			// bean.setProdRS(prodRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		} /*
		 * finally { if (rs != null) { try { rs.close(); } catch (Exception e) {
		 * } rs = null; } if (stmt != null) { try { stmt.close(); } catch
		 * (Exception e) { } stmt = null; } if (currentCon != null) { try {
		 * currentCon.close(); } catch (Exception e) { } currentCon = null; } }
		 */
		return bean;
	}

}
