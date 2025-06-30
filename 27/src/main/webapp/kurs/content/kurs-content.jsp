<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<c:set var="kurs" value="${param.name}" />

<sql:query var="termine" dataSource="${db}">
    SELECT datum, uhrzeit, ort, platz,
    (platz - COALESCE((SELECT COUNT(*) FROM teilnehmer_reserviert_seminar
    WHERE datum = s.datum AND uhrzeit = s.uhrzeit),0)) AS frei
    FROM seminar s
    WHERE kursname = ? AND datum >= CURRENT_DATE
    ORDER BY datum, uhrzeit;
    <sql:param value="${kurs}" />
</sql:query>

<h2>Kurs: <em>${kurs}</em></h2>

<table>
    <tr><th>Datum</th><th>Uhrzeit</th><th>Ort</th><th>Freie Plaetze</th><th></th></tr>

    <c:forEach var="t" items="${termine.rows}">
        <tr>
            <td><fmt:formatDate value="${t.datum}" pattern="dd.MM.yyyy"/></td>
            <td>${t.uhrzeit}</td>
            <td>${t.ort}</td>
            <td>${t.frei}</td>
            <td>
                <c:choose>
                    <c:when test="${t.frei gt 0}">
                        <a href="${pageContext.request.contextPath}/seminar/seminarDetails.jsp?d=${t.datum}&t=${t.uhrzeit}&kurs=${kurs}">
                            Buchen
                        </a>
                    </c:when>
                    <c:otherwise>—</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>

<p>
    <a href="${pageContext.request.contextPath}/kurs/kursauswahl.jsp">
        ⇠ zurueck zur Kursliste
    </a>
</p>

