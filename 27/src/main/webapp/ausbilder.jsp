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

<sql:query var="ausbilder" dataSource="${db}">
  SELECT a.kennzeichnung, a.einstellungsdatum, p.vorname, p.nachname
  FROM ausbilder a
  JOIN angestellter ag ON a.angestellten_nr = ag.angestellten_nr
  JOIN person p ON ag.zahl = p.zahl AND ag.geburtsdatum = p.geburtsdatum;
</sql:query>

<h2>Ausbilderliste</h2>
<table border="1">
  <tr><th>Kennzeichnung</th><th>Name</th><th>Einstellungsdatum</th></tr>
  <c:forEach var="row" items="${ausbilder.rows}">
    <tr>
      <td>${row.kennzeichnung}</td>
      <td>${row.vorname} ${row.nachname}</td>
      <td>${row.einstellungsdatum}</td>
    </tr>
  </c:forEach>
</table>
