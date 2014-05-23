package DashboardPackage;

import java.sql.ResultSet;

public class UserBean {
	public boolean valid;
	public ResultSet rsBean;
	public ResultSet prodRS;

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
}