<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<c:set var="inventarNr" value="${param.inventarNr}" />
<c:set var="rolle" value="${sessionScope.rolle}" />
<c:set var="angestelltenNr" value="${sessionScope.angestelltenNr}" />
<c:set var="kennzeichnung" value="${sessionScope.kennzeichnung}" />

<h2>Skriptausleihe</h2>

<c:choose>
    <c:when test="${rolle eq 'AUSBILDER'}">
        <sql:update dataSource="${db}">
            INSERT INTO organisator_oder_ausbilder_entleiht_skript
            (kennzeichnung, inventar_nr)
            VALUES (?, ?);
            <sql:param value="${kennzeichnung}" />
            <sql:param value="${inventarNr}" />
        </sql:update>
    </c:when>

    <c:when test="${rolle eq 'ORGANISATOR'}">
        <sql:update dataSource="${db}">
            INSERT INTO organisator_oder_ausbilder_entleiht_skript
            (angestellten_nr, inventar_nr)
            VALUES (?, ?);
            <sql:param value="${angestelltenNr}" />
            <sql:param value="${inventarNr}" />
        </sql:update>
    </c:when>

    <c:otherwise>
        <p style="color:red">Unzureichende Berechtigung.</p>
        <c:redirect url="${pageContext.request.contextPath}/skript/skripte.jsp"/>
    </c:otherwise>
</c:choose>

<p style="color:green">Skript erfolgreich ausgeliehen.</p>
<p><a href="${pageContext.request.contextPath}/skript/skripte.jsp">⇠ Zurueck zur Uebersicht</a></p>
