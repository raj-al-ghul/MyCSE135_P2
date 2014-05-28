package DashboardPackage;

import java.sql.ResultSet;
import java.util.*;

public class UserBean {
	public boolean valid = true;
	public ResultSet rs;
	public ResultSet rsBean;
	public ResultSet prodRS;
	public ResultSet tempRS;
	public String view;
	public ResultSet rsCat;
	public ResultSet rsAllTemp;
	public ArrayList<String> strArr = new ArrayList<String>();
	public int prodIndex = 0;
	public int prodCount = 0;
	

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