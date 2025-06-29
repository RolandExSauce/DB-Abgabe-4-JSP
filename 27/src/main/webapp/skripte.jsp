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

<sql:query var="skripte" dataSource="${db}">
    SELECT s.inventarnummer, st.nummer, st.autor, st.kursname
    FROM skript s
    JOIN skriptentyp st ON s.nummer = st.nummer
    ORDER BY s.inventarnummer;
</sql:query>

<h2>Skripte</h2>
<table border="1">
    <tr><th>Inventarnummer</th><th>Skript-Typ</th><th>Autor</th><th>Kurs</th></tr>
    <c:forEach var="row" items="${skripte.rows}">
        <tr>
            <td>${row.inventarnummer}</td>
            <td>${row.nummer}</td>
            <td>${row.autor}</td>
            <td>${row.kursname}</td>
        </tr>
    </c:forEach>
</table>
