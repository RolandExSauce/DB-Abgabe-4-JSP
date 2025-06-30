<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<!-- Kunden-Nr aus der Session -->
<c:set var="kdn" value="${sessionScope.kundenNr}" />

<c:if test="${empty kdn}">
    <p style="color:red">Keine Kunden-Nr in Session – bitte neu anmelden.</p>
    <c:redirect url="${pageContext.request.contextPath}/auth/login.jsp"/>
</c:if>

<!-- Zukünftige Reservierungen abrufen -->
<sql:query var="buchungen" dataSource="${db}">
    SELECT r.reservierungs_nr, s.datum, s.uhrzeit, s.ort, k.kursname
    FROM teilnehmer_reserviert_seminar r
    JOIN seminar s ON s.datum = r.datum AND s.uhrzeit = r.uhrzeit
    JOIN kurs k ON k.kursname = s.kursname
    WHERE r.kunden_nr = ? AND s.datum >= CURRENT_DATE
    ORDER BY s.datum, s.uhrzeit;
    <sql:param value="${kdn}" />
</sql:query>

<h2>Meine Reservierungen</h2>

<c:if test="${param.storno == 'ok'}">
    <p style="color:green">Reservierung wurde storniert.</p>
</c:if>

<c:choose>
    <c:when test="${buchungen.rowCount == 0}">
        <p>Keine zukünftigen Buchungen.</p>
    </c:when>

    <c:otherwise>
        <table border="1" cellpadding="4">
            <tr>
                <th>Kurs</th>
                <th>Datum</th>
                <th>Uhrzeit</th>
                <th>Ort</th>
                <th>Aktion</th>
            </tr>

            <c:forEach var="row" items="${buchungen.rows}">
                <tr>
                    <td>${row.kursname}</td>
                    <td><fmt:formatDate value="${row.datum}" pattern="dd.MM.yyyy" /></td>
                    <td>${row.uhrzeit}</td>
                    <td>${row.ort}</td>
                    <td>
                        <form method="post" action="">
                            <input type="hidden" name="cancel" value="1"/>
                            <input type="hidden" name="resNr" value="${row.reservierungs_nr}"/>
                            <input type="submit" value="Stornieren">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

<!-- Storno durchführen -->
<c:if test="${param.cancel == '1'}">
    <sql:update dataSource="${db}">
        DELETE FROM teilnehmer_reserviert_seminar
        WHERE reservierungs_nr = ? AND kunden_nr = ?;
        <sql:param value="${param.resNr}" />
        <sql:param value="${kdn}" />
    </sql:update>
    <c:redirect url="${pageContext.request.contextPath}/reserve/reservierungen.jsp?storno=ok"/>
</c:if>
