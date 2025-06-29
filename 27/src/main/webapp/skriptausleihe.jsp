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
<h2>Skript ausleihen</h2>
<form action="verarbeiteAusleihe.jsp" method="post">
    Inventarnummer: <input type="text" name="inventar_nr" /><br/>
    Ausleiher: <br/>
    Angestellten-Nr (Organisator): <input type="text" name="angestellten_nr" /><br/>
    Kennzeichnung (Ausbilder): <input type="text" name="kennzeichnung" /><br/>
    <input type="submit" value="Ausleihen" />
</form>
