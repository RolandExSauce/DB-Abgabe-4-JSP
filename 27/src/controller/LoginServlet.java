@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int zahl = Integer.parseInt(req.getParameter("zahl"));
        String geburtsdatum = req.getParameter("geburtsdatum");

        // TODO: Optional: DB-Check ob Person existiert
        req.getSession().setAttribute("zahl", zahl);
        req.getSession().setAttribute("geburtsdatum", geburtsdatum);

        List<Kurs> kurse = DBUtil.getAlleKurse();
        req.setAttribute("kurse", kurse);
        req.getRequestDispatcher("kursauswahl.jsp").forward(req, resp);
    }
}
