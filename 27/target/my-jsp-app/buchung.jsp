<%@ page contentType="text/html; charset=UTF-8" %>

<!-- JSTL core + SQL tag-libraries -->
<%@ taglib prefix="c"   uri="jakarta.tags.core"           %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql"            %>

<!-- ── 1  Create a DataSource (connection-pool) ───────────────────────────── -->
<!-- For local dev: localhost:5435                                             -->
<!-- For Docker   : db:5432 (compose service name)                             -->
<sql:setDataSource var="db"
                   driver="org.postgresql.Driver"
                   url="jdbc:postgresql://localhost:5435/ausbildung_db"
                   user="user"
                   password="password" />

<!-- ── 2  Run the parametrised query ──────────────────────────────────────── -->
<sql:query dataSource="${db}" var="bookings">
    SELECT *
    FROM buchungen
    WHERE kurs_id = ?
    <sql:param value="${param.kursId}" />
</sql:query>

<!-- ── 3  Display the results ─────────────────────────────────────────────── -->
<table border="1">
    <tr><th>ID</th><th>Teilnehmer</th></tr>
    <c:forEach var="row" items="${bookings.rows}">
        <tr>
            <td>${row.id}</td>
            <td>${row.teilnehmer}</td>
        </tr>
    </c:forEach>
</table>
