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

		if(bean == null)
		{
			System.out.println("nul bean");
		}
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			System.out.println("CAT QUERY: " + str);
			catRS = stmt.executeQuery(str);

			bean.setCatRS(catRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean getData(UserBean bean, String name, String product) {
		StringBuilder query = new StringBuilder();
		query.append("SELECT t.pid, t.sum(t.total) FROM temp_table t WHERE temp_table.name = '"
				+ name + "' AND temp_table.pid = " + product);
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
		StringBuilder productQuery = new StringBuilder();
		productQuery.append("select * from products");

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();

			ResultSet prod = stmt.executeQuery(productQuery.toString());

			boolean more;

			StringBuilder strB = new StringBuilder();
			strB.append("DROP TABLE IF EXISTS temp; ");
			strB.append("CREATE TABLE temp ( id SERIAL PRIMARY KEY, name TEXT, state TEXT, total FLOAT, age INTEGER ");
			while (more = prod.next()) {
				System.out.println("in while");
				strB.append(", " + prod.getString("id") + " FLOAT ");
			}

			strB.append(" )");
			String str = strB.toString();

			stmt.executeUpdate(str);
			System.out.println("TABLE CREATED");

			// bean.setProdRS(prodRS);

		} catch (Exception ex) {
			System.out
					.println("Query failed: An Exception has occurred! " + ex);
		}

		return bean;
	}

	public static UserBean insertTemp(UserBean bean) {

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
