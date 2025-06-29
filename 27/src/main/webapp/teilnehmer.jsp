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
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<jsp:include page="WEB-INF/datasource.jspf" />

<sql:query var="teilnehmer" dataSource="${db}">
    SELECT t.kunden_nr, p.vorname, p.nachname, p.plz, p.ort, p.straße, p.hausnummer, t.kennzeichnung AS lieblingsausbilder
    FROM teilnehmer t
    JOIN person p ON t.zahl = p.zahl AND t.geburtsdatum = p.geburtsdatum
    ORDER BY t.kunden_nr;
</sql:query>

<h2>Teilnehmerübersicht</h2>
<table border="1">
    <tr>
        <th>Kundennr</th><th>Name</th><th>Adresse</th><th>Lieblingsausbilder</th>
    </tr>
    <c:forEach var="row" items="${teilnehmer.rows}">
        <tr>
            <td>${row.kunden_nr}</td>
            <td>${row.vorname} ${row.nachname}</td>
            <td>${row.straße} ${row.hausnummer}, ${row.plz} ${row.ort}</td>
            <td>${row.lieblingsausbilder}</td>
        </tr>
    </c:forEach>
</table>
