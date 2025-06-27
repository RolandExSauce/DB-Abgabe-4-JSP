@WebServlet("/buchung")
public class BuchungServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int zahl = (int) session.getAttribute("zahl");
        String geburtsdatum = (String) session.getAttribute("geburtsdatum");
        String kursname = (String) session.getAttribute("kursname");

        // Dummy Reservierung
        DBUtil.bucheKurs(zahl, geburtsdatum, kursname);
        resp.sendRedirect("bestaetigung.jsp");
    }
}
