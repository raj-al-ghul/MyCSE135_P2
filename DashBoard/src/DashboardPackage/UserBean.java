package DashboardPackage;

import java.sql.ResultSet;

public class UserBean {
	public boolean valid;
	public ResultSet rsBean;

	public void setRS(ResultSet rs) {
		rsBean = rs;
	}
	
	public ResultSet getRS()
	{
		return rsBean;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean newValid) {
		valid = newValid;
	}
}