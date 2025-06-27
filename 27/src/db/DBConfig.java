public class DBConfig {
    static final String URL = "jdbc:mysql://localhost:3306/deinprojekt";
    static final String USER = "root";
    static final String PASS = "pass";

    public static Connection getConn() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public static List<Kurs> getAlleKurse() {
        List<Kurs> list = new ArrayList<>();
        try (Connection con = getConn();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM Kurs");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Kurs(rs.getString("Kursname")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void bucheKurs(int zahl, String geburtsdatum, String kursname) {
        try (Connection con = getConn()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Reservierung (KundenNr, Kursname, Datum, Uhrzeit) VALUES (?, ?, CURDATE(), CURTIME())"
            );
            // Nur Platzhalter – Du brauchst evtl. KundenNr lookup!
            ps.setInt(1, zahl);
            ps.setString(2, kursname);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
