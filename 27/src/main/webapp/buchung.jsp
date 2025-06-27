<%@ page session="true" %>
<h2>Buchung bestätigen</h2>
<p>Benutzer: <%= session.getAttribute("zahl") %></p>
<p>Geburtsdatum: <%= session.getAttribute("geburtsdatum") %></p>
<p>Gewählter Kurs: <%= session.getAttribute("kursname") %></p>

<form method="post" action="buchung">
    <input type="submit" value="Jetzt buchen">
</form>
