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

<sql:query var="konten" dataSource="${db}">
  SELECT g.konto_nr, g.kontostand, b.name AS bankname, a.angestellten_nr
  FROM gehaltskonto g
  JOIN bank b ON g.bankleitzahl = b.bankleitzahl
  JOIN angestellter a ON g.angestellten_nr = a.angestellten_nr;
</sql:query>

<h2>Gehaltskonten</h2>
<table border="1">
  <tr><th>Konto-Nr</th><th>Kontostand</th><th>Bank</th><th>Angestellten-Nr</th></tr>
  <c:forEach var="row" items="${konten.rows}">
    <tr>
      <td>${row.konto_nr}</td>
      <td>${row.kontostand}</td>
      <td>${row.bankname}</td>
      <td>${row.angestellten_nr}</td>
    </tr>
  </c:forEach>
</table>
