<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%@ include file="/WEB-INF/common/header.jspf" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<%-- Erwartet d=yyyy-MM-dd  t=HH:mm:ss  kurs=KURSNAME --%>
<c:set var="datum"   value="${param.d}" />
<c:set var="uhrzeit" value="${param.t}" />
<c:set var="kurs"    value="${param.kurs}" />

<sql:query var="sem" dataSource="${db}">
    SELECT *
    FROM seminar
    WHERE datum   = ?
    AND uhrzeit = ?;
    <sql:param value="${datum}" />
    <sql:param value="${uhrzeit}" />
</sql:query>

<c:set var="seminar" value="${sem.rows[0]}" />

<h2>Seminar-Details</h2>

<ul>
    <li>Kurs: <strong>${kurs}</strong></li>
    <li>Datum: <strong>${seminar.datum}</strong></li>
    <li>Uhrzeit: <strong>${seminar.uhrzeit}</strong></li>
    <li>Ort: <strong>${seminar.ort}</strong></li>
    <li>Plätze: <strong>${seminar.platz}</strong></li>
</ul>

<!-- ===================================== -->
<!--  Buchungsformular                     -->
<!-- ===================================== -->

<c:if test="${empty param.book}">
    <h3>Buchen</h3>
    <form method="post" action="">
        <input type="hidden" name="book" value="1"/>
        <input type="hidden" name="d"    value="${datum}"/>
        <input type="hidden" name="t"    value="${uhrzeit}"/>
        <input type="submit" value="Platz reservieren">
    </form>
</c:if>

<!-- ===================================== -->
<!--  POST: Buchung speichern              -->
<!-- ===================================== -->
<c:if test="${param.book == '1'}">

    <!-- 1. Kunden_Nr aus Session holen -->
    <c:set var="kdn" value="${sessionScope.kundenNr}" />

    <!-- 2. Neue Reservierungsnummer generieren -->
    <sql:query var="nextRes" dataSource="${db}">
        SELECT COALESCE(MAX(reservierungs_nr),0)+1 AS nr
        FROM teilnehmer_reserviert_seminar;
    </sql:query>
    <c:set var="resNr" value="${nextRes.rows[0].nr}" />

    <!-- 3. INSERT -->
    <sql:update dataSource="${db}">
        INSERT INTO teilnehmer_reserviert_seminar
        (reservierungs_nr, kunden_nr, datum, uhrzeit)
        VALUES (?, ?, ?, ?);
        <sql:param value="${resNr}" />
        <sql:param value="${kdn}"  />
        <sql:param value="${datum}" />
        <sql:param value="${uhrzeit}" />
    </sql:update>

    <p style="color:green">
        Reservierung erfolgreich!<br>
        Ihre Nummer: <strong>${resNr}</strong>
    </p>

    <p>
        <a href="${pageContext.request.contextPath}/seminar?kurs=${kurs}">
            ⇠ Zurück zur Terminliste
        </a>
    </p>
</c:if>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
