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

<!-- 2) Kurs-Abfrage  -->
<sql:query var="kurse" dataSource="${db}">
    SELECT kursname,
    anzahl_organisatoren,
    vorbereitungszeit
    FROM kurs
    ORDER BY kursname;
</sql:query>

<!-- 3) Ausgabe -->
<h2>Kursübersicht</h2>
<table border="1" cellpadding="4">
    <tr>
        <th>Kursname</th>
        <th>Anzahl&nbsp;Organisatoren</th>
        <th>Vorbereitungs-<br/>zeit&nbsp;(Min)</th>
    </tr>

    <c:forEach var="row" items="${kurse.rows}">
        <tr>
            <td>${row.kursname}</td>
            <td>${row.anzahl_organisatoren}</td>
            <td>${row.vorbereitungszeit}</td>
        </tr>
    </c:forEach>
</table>
