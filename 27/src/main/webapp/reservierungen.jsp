<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<sql:setDataSource var="db"
                   driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost:5435/ausbildung_db"
                   user="user"
                   password="password" />

<sql:query var="reservierungen" dataSource="${db}">
  SELECT r.reservierungs_nr,
  r.datum,
  r.uhrzeit,
  p.vorname,
  p.nachname
  FROM teilnehmer_reserviert_seminar r
  JOIN teilnehmer t ON r.kunden_nr = t.kunden_nr
  JOIN person p ON t.zahl = p.zahl AND t.geburtsdatum = p.geburtsdatum
  ORDER BY r.datum, r.uhrzeit;
</sql:query>

<h2>Seminarreservierungen</h2>
<table border="1" cellpadding="4">
  <tr>
    <th>Reservierungsnr</th>
    <th>Teilnehmer</th>
    <th>Datum</th>
    <th>Uhrzeit</th>
  </tr>

  <c:forEach var="row" items="${reservierungen.rows}">
    <tr>
      <td>${row.reservierungs_nr}</td>
      <td>${row.vorname} ${row.nachname}</td>
      <td>${row.datum}</td>
      <td>${row.uhrzeit}</td>
    </tr>
  </c:forEach>
</table>
