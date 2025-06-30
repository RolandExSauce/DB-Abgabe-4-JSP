<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<!-- Optional: Zugriffsbeschränkung für Admin -->
<c:if test="${sessionScope.rolle != 'ADMIN'}">
    <p style="color:red">Nur für Administratoren zugaenglich.</p>
    <c:redirect url="${pageContext.request.contextPath}/auth/login.jsp"/>
</c:if>

<sql:query var="teilnehmer" dataSource="${db}">
    SELECT t.kunden_nr,
    p.vorname, p.nachname,
    CONCAT(p.straße, ' ', p.hausnummer, ', ', p.plz, ' ', p.ort) AS adresse,
    t.kennzeichnung AS lieblingsausbilder
    FROM teilnehmer t
    JOIN person p ON p.zahl = t.zahl AND p.geburtsdatum = t.geburtsdatum
    ORDER BY t.kunden_nr;
</sql:query>

<h2>Teilnehmer (Admin)</h2>

<table>
    <tr><th>Nr</th><th>Name</th><th>Adresse</th><th>Ausbilder</th></tr>
    <c:forEach var="row" items="${teilnehmer.rows}">
        <tr>
            <td>${row.kunden_nr}</td>
            <td>${row.vorname} ${row.nachname}</td>
            <td>${row.adresse}</td>
            <td>${row.lieblingsausbilder}</td>
        </tr>
    </c:forEach>
</table>
