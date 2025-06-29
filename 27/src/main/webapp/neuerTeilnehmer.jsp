<%@ page contentType="text/html; charset=UTF-8" %>

<!-- JSTL-Bibliotheken -->
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"  %>

<!-- 1) DataSource – passt für lokalen Jetty (5435)            -->
<!--    Für Compose später einfach localhost → db ändern       -->

<sql:setDataSource var="db"
                   driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost:5435/ausbildung_db"
                   user="user"
                   password="password" />

<%@ page contentType="text/html; charset=UTF-8" %>
<h2>Neuen Teilnehmer hinzufügen</h2>
<form action="hinzufuegenTeilnehmer.jsp" method="post">
    Sozialversicherungs-Zahl: <input type="text" name="zahl" /><br/>
    Geburtsdatum (YYYY-MM-DD): <input type="text" name="geburtsdatum" /><br/>
    Kunden-Nr: <input type="text" name="kundennr" /><br/>
    Lieblingsausbilder-Kennzeichnung: <input type="text" name="kennzeichnung" /><br/>
    <input type="submit" value="Hinzufügen" />
</form>
