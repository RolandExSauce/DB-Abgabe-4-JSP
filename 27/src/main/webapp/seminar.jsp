<%@ page contentType="text/html; charset=UTF-8" %>

<!-- JSTL-Bibliotheken -->
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"  %>

<!-- Datenbankverbindung -->
<sql:setDataSource var="db"
                   driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost:5435/ausbildung_db"
                   user="user"
                   password="password" />

<!-- Seminar-Abfrage -->
<sql:query var="seminare" dataSource="${db}">
    SELECT datum,
    uhrzeit,
    ort,
    straße,
    haus_nr,
    platz,
    kursname
    FROM seminar
    ORDER BY datum, uhrzeit;
</sql:query>

<!-- Ausgabe -->
<h2>Seminarübersicht</h2>
<table border="1" cellpadding="4">
    <tr>
        <th>Datum</th>
        <th>Uhrzeit</th>
        <th>Ort</th>
        <th>Straße</th>
        <th>Haus-Nr</th>
        <th>Plätze</th>
        <th>Kursname</th>
    </tr>

    <c:forEach var="row" items="${seminare.rows}">
        <tr>
            <td>${row.datum}</td>
            <td>${row.uhrzeit}</td>
            <td>${row.ort}</td>
            <td>${row.straße}</td>
            <td>${row.haus_nr}</td>
            <td>${row.platz}</td>
            <td>${row.kursname}</td>
        </tr>
    </c:forEach>
</table>
