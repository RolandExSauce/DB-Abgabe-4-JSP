<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Verify DB connection -->
<sql:query var="connectionTest" dataSource="${db}">
    SELECT 1 AS test
</sql:query>

<!-- Dropdown-Ausbilderliste -->
<sql:query var="ausbilderList" dataSource="${db}">
    SELECT kennzeichnung FROM ausbilder ORDER BY kennzeichnung;
</sql:query>

<!-- GET: leeres Formular anzeigen -->
<c:if test="${empty param.submit}">
    <h2>Teilnehmer anlegen</h2>

    <form method="post" action="${pageContext.request.contextPath}/admin/add-teilnehmer.jsp">
    <label>Zahl (4-stellig):
            <input type="number" name="zahl" min="0" max="9999" required>
        </label><br>

        <label>Geburtsdatum:
            <input type="date" name="geburtsdatum" required>
        </label><br>

        <label>Vorname: <input type="text" name="vorname" required></label><br>
        <label>Nachname: <input type="text" name="nachname" required></label><br>

        <label>PLZ: <input type="text" name="plz"></label><br>
        <label>Ort: <input type="text" name="ort"></label><br>
        <label>Straße: <input type="text" name="strasse"></label><br>
        <label>Hausnr.: <input type="text" name="hausnummer"></label><br>

        <label>Ausbilder (Kennzeichnung):
            <select name="kennzeichnung" required>
                <c:forEach var="a" items="${ausbilderList.rows}">
                    <option value="${a.kennzeichnung}">${a.kennzeichnung}</option>
                </c:forEach>
            </select>
        </label><br><br>

        <input type="submit" name="submit" value="Teilnehmer erstellen">
    </form>

    <c:if test="${param.success == '1'}">
        <p style="color:green">Teilnehmer wurde erfolgreich angelegt.</p>
    </c:if>
</c:if>

<!-- POST: Verarbeite Eingabe -->
<c:if test="${not empty param.submit}">
    <c:catch var="dbException">
        <c:set var="zahlInt" value="${Integer.parseInt(param.zahl)}" />
        <fmt:parseDate value="${param.geburtsdatum}" pattern="yyyy-MM-dd" var="parsedDate" />

        <!-- Person existiert? -->
        <sql:query var="existsPerson" dataSource="${db}">
            SELECT 1 FROM person WHERE zahl = ? AND geburtsdatum = ?
            <sql:param value="${zahlInt}" />
            <sql:dateParam value="${parsedDate}" />
        </sql:query>

        <!-- Falls nicht vorhanden: einfügen -->
        <c:if test="${existsPerson.rowCount == 0}">
            <sql:update dataSource="${db}">
                INSERT INTO person (zahl, geburtsdatum, vorname, nachname, plz, ort, straße, hausnummer)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                <sql:param value="${zahlInt}" />
                <sql:dateParam value="${parsedDate}" />
                <sql:param value="${param.vorname}" />
                <sql:param value="${param.nachname}" />
                <sql:param value="${param.plz}" />
                <sql:param value="${param.ort}" />
                <sql:param value="${param.strasse}" />
                <sql:param value="${param.hausnummer}" />
            </sql:update>
        </c:if>

        <!-- Neue Kundennummer -->
        <sql:query var="nextKdn" dataSource="${db}">
            SELECT COALESCE(MAX(kunden_nr), 0) + 1 AS nr FROM teilnehmer
        </sql:query>
        <c:set var="kdn" value="${nextKdn.rows[0].nr}" />

        <!-- Teilnehmer einfügen -->
        <sql:update dataSource="${db}">
            INSERT INTO teilnehmer (zahl, geburtsdatum, kunden_nr, kennzeichnung)
            VALUES (?, ?, ?, ?)
            <sql:param value="${zahlInt}" />
            <sql:dateParam value="${parsedDate}" />
            <sql:param value="${kdn}" />
            <sql:param value="${param.kennzeichnung}" />
        </sql:update>

        <p style="color:green">
            Teilnehmer ${kdn} wurde angelegt.
            <br><a href="?success=1">Neuen Teilnehmer anlegen</a>
        </p>
    </c:catch>

    <c:if test="${not empty dbException}">
        <p style="color:red">
            Fehler beim Anlegen des Teilnehmers: ${dbException.message}
            <br>Bitte versuchen Sie es erneut.
        </p>
        <p><a href="${pageContext.request.requestURI}">Zurück zum Formular</a></p>
    </c:if>
</c:if>
