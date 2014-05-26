package DashboardPackage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

//user.setValid(true);
/**
 * Servlet implementation class ControllerServlet
 */
@WebServlet("/ControllerServlet")
public class ControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	public static UserBean user = new UserBean();
	public static HttpSession session;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int test;

		test = Integer.parseInt(request.getParameter("st"));

		System.out.println("WORKING? " + request.getParameter("st"));
		try {
			// UserBean user = new UserBean();
			// user.setValid(true);
			// user.setUserName(request.getParameter("un"));
			// user.setPassword(request.getParameter("pw"));
			switch (test) {

			case 0: {
				System.out.println("CASE 0");
				user = UserDAO.getCat(user);
				response.sendRedirect("view.jsp");
				break;
			}
			case 1: {
				System.out.println("CASE 1");
				user = UserDAO.getCat(user); //called each time a page is refreshed
				user = UserDAO.buildTemp(user);
				user = UserDAO.name(user);
				user = UserDAO.products(user);
				user = UserDAO.viewTable(user);

				if (user.isValid()) {
					session = request.getSession(true);
					session.setAttribute("currentSessionUser", user);
					user.view = request.getParameter("view");
					
					response.sendRedirect("success.jsp");
				} else {
					response.sendRedirect("error.jsp");
				}
				break;
			}
			default: {
				System.out.println("DEFAULT");
				response.sendRedirect("view.jsp");
			}
			}

		} catch (Throwable theException) {
			System.out.println(theException);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
