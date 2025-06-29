<form method="post" action="login">
    <h2>Login</h2>

    <!-- four-digit part of Sozialversicherungsnummer -->
    <label>
        Zahl&nbsp;(4-digit SVNR prefix):
        <input type="number"
               name="zahl"
               required
               min="0"
               max="9999"
               pattern="\d{4}"
               title="Exactly four digits (0000-9999)">
    </label><br>

    <!-- birth-date part of Sozialversicherungsnummer -->
    <label>
        Geburtsdatum:
        <input type="date"
               name="geburtsdatum"
               required>
    </label><br>

    <input type="submit" value="Login">
</form>
