<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<!-- Kursname aus Parameter -->
<c:set var="kursname" value="${param.kurs}" />

<c:if test="${empty kursname}">
    <p style="color:red">Kein Kurs angegeben.</p>
    <c:redirect url="${pageContext.request.contextPath}/kursauswahl"/>
</c:if>

<sql:query var="seminare" dataSource="${db}">
    SELECT s.datum, s.uhrzeit, s.ort, s.platz,
    (s.platz - COALESCE((SELECT COUNT(*) FROM teilnehmer_reserviert_seminar r
    WHERE r.datum = s.datum AND r.uhrzeit = s.uhrzeit), 0)) AS freie_plaetze
    FROM seminar s
    WHERE s.kursname = ?
    AND s.datum >= CURRENT_DATE
    ORDER BY s.datum, s.uhrzeit;
    <sql:param value="${kursname}" />
</sql:query>

<h2>Seminare für <em>${kursname}</em></h2>

<table border="1" cellpadding="4">
    <tr>
        <th>Datum</th>
        <th>Uhrzeit</th>
        <th>Ort</th>
        <th>Freie&nbsp;Plätze</th>
        <th>Aktion</th>
    </tr>

    <c:forEach var="row" items="${seminare.rows}">
        <tr>
            <td><fmt:formatDate value="${row.datum}" pattern="dd.MM.yyyy" /></td>
            <td>${row.uhrzeit}</td>
            <td>${row.ort}</td>
            <td>${row.freie_plaetze}</td>
            <td>
                <c:choose>
                    <c:when test="${row.freie_plaetze gt 0}">
                        <a href="${pageContext.request.contextPath}/seminarDetails?d=${row.datum}&t=${row.uhrzeit}&kurs=${kursname}">
                            Details&nbsp;/&nbsp;Buchen
                        </a>
                    </c:when>
                    <c:otherwise>
                        Ausgebucht
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

<p><a href="${pageContext.request.contextPath}/kursauswahl">⇠ Zur Kursübersicht</a></p>
