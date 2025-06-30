<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Time" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    String t = request.getParameter("t");
    Time parsedTime = null;
    if (t != null && !t.isEmpty()) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm[:ss]");
            LocalTime localTime = LocalTime.parse(t, formatter);
            parsedTime = Time.valueOf(localTime);
        } catch (Exception e) {
            throw new ServletException("Invalid time format: " + t + ". Expected HH:mm or HH:mm:ss");
        }
    }
    request.setAttribute("parsedTime", parsedTime);
%>

<!-- Erwartete Parameter -->
<c:set var="datum" value="${param.d}" />
<c:set var="uhrzeit" value="${param.t}" />
<c:set var="kurs" value="${param.kurs}" />

<!-- Seminarinformationen abrufen -->
<sql:query var="sem" dataSource="${db}">
    SELECT * FROM seminar
    WHERE datum = ? AND uhrzeit = ?;
    <sql:dateParam value="${param.d}" />
    <sql:param value="${parsedTime}" />
</sql:query>

<c:set var="seminar" value="${sem.rows[0]}" />

<h2>Seminar-Details</h2>

<c:if test="${sem.rowCount == 0}">
    <p style="color:red">Kein passendes Seminar gefunden (Datum/Uhrzeit nicht vorhanden).</p>
</c:if>


<c:if test="${sem.rowCount > 0}">
    <c:set var="seminar" value="${sem.rows[0]}" />

    <ul>
        <li>Kurs: <strong>${kurs}</strong></li>
        <li>Datum: <strong>${seminar.datum}</strong></li>
        <li>Uhrzeit: <strong>${seminar.uhrzeit}</strong></li>
        <li>Ort: <strong>${seminar.ort}</strong></li>
        <li>Plaetze: <strong>${seminar.platz}</strong></li>
    </ul>
</c:if>


<!-- Buchungsformular -->
<c:if test="${empty param.book}">
    <h3>Buchen</h3>
    <form method="post" action="">
        <input type="hidden" name="book" value="1"/>
        <input type="hidden" name="d" value="${datum}"/>
        <input type="hidden" name="t" value="${uhrzeit}"/>
        <input type="submit" value="Platz reservieren">
    </form>
</c:if>

<!-- Reservierung durchführen -->
<c:if test="${param.book == '1'}">
    <c:set var="kdn" value="${sessionScope.kundenNr}" />

    <sql:query var="nextRes" dataSource="${db}">
        SELECT COALESCE(MAX(reservierungs_nr), 0) + 1 AS nr
        FROM teilnehmer_reserviert_seminar;
    </sql:query>
    <c:set var="resNr" value="${nextRes.rows[0].nr}" />

    <sql:update dataSource="${db}">
        INSERT INTO teilnehmer_reserviert_seminar
        (reservierungs_nr, kunden_nr, datum, uhrzeit)
        VALUES (?, ?, ?, ?);
        <sql:param value="${resNr}" />
        <sql:param value="${kdn}" />
        <sql:dateParam  value="${datum}" />
        <sql:param value="${parsedTime}" />
    </sql:update>

    <p style="color:green">
        Reservierung erfolgreich!<br>
        Ihre Nummer: <strong>${resNr}</strong>
    </p>

    <p>
        <a href="${pageContext.request.contextPath}/seminar?kurs=${kurs}">
            ⇠ Zurueck zur Terminliste
        </a>
    </p>
</c:if>
