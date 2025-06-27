@WebServlet("/kurs")
public class KursServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String kursname = req.getParameter("kursname");
        req.getSession().setAttribute("kursname", kursname);
        resp.sendRedirect("buchung.jsp");
    }
}
