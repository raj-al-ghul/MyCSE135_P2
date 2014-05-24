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
	
	public static UserBean products(UserBean bean)
	{
		String productQuery = "select * from products";
		
		try {
			currentCon = ConnectionManager.getConnection();
			//System.out.println("AM I HERER?????");
			stmt = currentCon.createStatement();
			
			prodRS = stmt.executeQuery(productQuery);
			

			
			bean.setProdRS(prodRS);

		} catch (Exception ex) {
			System.out.println("Query failed: An Exception has occurred! "
					+ ex);
		}
		return bean;
	}

	public static UserBean first(UserBean bean) {
		//Statement stmt = null;

		String searchQuery = "select * from users";
		//String productQuery = "select * from PRODUCTS";
		System.out.println("Query: " + searchQuery);
		try {
			currentCon = ConnectionManager.getConnection();
			System.out.println("AM I HERER?????");
			stmt = currentCon.createStatement();
			

			rs = stmt.executeQuery(searchQuery);
			//prodRS = stmt.executeQuery(productQuery);
			

			bean.setRS(rs);
			//bean.setProdRS(prodRS);

		} catch (Exception ex) {
			System.out.println("Query failed: An Exception has occurred! "
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
