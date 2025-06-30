<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
    <%-- User NOT logged in --%>
    <c:when test="${empty sessionScope.rolle}">
        <p style="color:red">Zugriff verweigert. Bitte zuerst <a href="${pageContext.request.contextPath}/auth/login.jsp">einloggen</a>.</p>
    </c:when>

    <%-- Teilnehmer view --%>
    <c:when test="${sessionScope.rolle == 'TEILNEHMER'}">
        <h2>Willkommen, Teilnehmer ${sessionScope.kdn}!</h2>
        <p><a href="${pageContext.request.contextPath}/kurs/kurs.jsp">Kurse anzeigen</a></p>
        <p><a href="${pageContext.request.contextPath}/reserve/reservierungen.jsp">Meine Reservierungen</a></p>
    </c:when>

    <%-- Admin view --%>
    <c:when test="${sessionScope.rolle == 'ADMIN'}">
        <h2>Admin-Dashboard</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/teilnehmer.jsp">Teilnehmer anlegen</a></li>
            <li><a href="${pageContext.request.contextPath}/kurs/kurse.jsp">Kurse verwalten</a></li>
        </ul>
    </c:when>

    <%-- Unknown --%>
    <c:otherwise>
        <p>Unbekannte Rolle. Zugriff verweigert.</p>
    </c:otherwise>
</c:choose>