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
		session = request.getSession(true);
		session.setAttribute("currentSessionUser", user);
		int test;

		test = Integer.parseInt(request.getParameter("st"));

		System.out.println("WORKING? " + request.getParameter("st"));
		try {
			session = request.getSession(true);
			session.setAttribute("currentSessionUser", user);

			switch (test) {

			case 0: {
				System.out.println("CASE 0");
				//user = UserDAO.getCat(user);
				user.prodCurr = 0;
				user.viewCurr = 0;
				response.sendRedirect("view.jsp");
				break;
			}
			case 1: {
				System.out.println("CASE 1");
				UserDAO.next20 = 0;
				//user = UserDAO.getCat(user); // called each time a page is
												// refreshed
				// user = UserDAO.products(user);
				// user = UserDAO.buildTemp(user);
				// user = UserDAO.getAllTemp(user);

				// user = UserDAO.viewTable(user);

				if (user.isValid()) {

					user.view = request.getParameter("view");
					user.state = request.getParameter("state");
					user.age = request.getParameter("age");
					user.category = request.getParameter("category");

					user.prodCurr = 10;
					user.viewCurr = 20;

					response.sendRedirect("success.jsp");
				} else {
					response.sendRedirect("error.jsp");
				}
				break;
			}
			case 2: {
				// user = UserDAO.products(user);
				// user = UserDAO.getAllTemp(user);
				user.prodCurr += 10;
				response.sendRedirect("Next10.jsp");
				break;
			}
			case 3: {
				// user = UserDAO.products(user);
				user.viewCurr += 20;
				user.prodCurr = 10;
				response.sendRedirect("Next20.jsp");
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
