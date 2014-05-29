package DashboardPackage;

import java.sql.ResultSet;
import java.util.*;

public class UserBean {
	public boolean valid = true;
	public ResultSet rs;
	public ResultSet rsBean;
	public ResultSet prodRS;
	public ResultSet tempRS;
	public ResultSet rsCat;
	public ResultSet rsAllTemp;
	public ArrayList<String> strArr = new ArrayList<String>();
	public int prodIndex = 0;
	public int prodCount = 0;

	public String view = "customer";
	public String state = "default";
	public String age = "default";
	public String category = "default";

	public int prodTot = 15;
	public int viewTot = 25;

	public int prodOffset = 0;

	public int prodCurr = 0;
	public int viewCurr = 0;
	public int totUsers = 0;
	public int curUsers = 0;

	public String genState() {
		String str = "";

		if (!this.state.equals("default")) {
			str += " AND state = " + this.state;
		}

		return str;
	}

	public String genAge() {
		String str = "";

		if (this.age.equals("age0")) {
			str += " AND age BETWEEN 12 AND 18";
		}

		else if (this.age.equals("age1")) {
			str += " AND age BETWEEN 18 AND 45";
		}

		else if (this.age.equals("age2")) {
			str += " AND age BETWEEN 45 AND 65";
		}

		else if (this.age.equals("age3")) {
			str += " AND age > 65";
		}
		return str;
	}

	public String genCat() {
		String str = "";

		if (!this.category.equals("default")) {
			str += " AND category = " + this.category;
		}
		return str;
	}

	public String makeStrings() {
		String str = "";

		if (!this.state.equals("default")) {
			str += " AND state = " + this.state;
		}

		if (this.age.equals("age0")) {
			str += " AND age BETWEEN 12 AND 18";
		}

		else if (this.age.equals("age1")) {
			str += " AND age BETWEEN 18 AND 45";
		}

		else if (this.age.equals("age2")) {
			str += " AND age BETWEEN 45 AND 65";
		}

		else if (this.age.equals("age3")) {
			str += " AND age > 65";
		}

		if (!this.category.equals("default")) {
			str += " AND category = " + this.category;
		}

		System.out.println("============>>>>>>>>>" + str);

		return str;
	}

	public UserBean() {
		System.out.println("BEAN CALLED");
	}

	public void setTempRS(ResultSet rs) {
		tempRS = rs;
	}

	public void setProdRS(ResultSet rs) {
		prodRS = rs;
	}

	public ResultSet getProdRS() {
		return prodRS;
	}

	public void setRS(ResultSet rs) {
		rsBean = rs;
	}

	public ResultSet getRS() {
		return rsBean;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean newValid) {
		valid = newValid;
	}

	public void setCatRS(ResultSet catRS) {
		System.out.println("SAVING RS CAT");
		rsCat = catRS;

	}

	public void setAllTempRS(ResultSet rs) {
		rsAllTemp = rs;

	}
}