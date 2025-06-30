<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%@ include file="/WEB-INF/common/header.jspf" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<c:choose>
  <%-- 1) Login-Form anzeigen --%>
  <c:when test="${empty param.login}">
    <h2>Login</h2>

    <form method="post" action="">
      <input type="hidden" name="login" value="1"/>

      <label>Zahl (4-stellig):
        <input type="number" name="zahl" min="0" max="9999"
               required pattern="\d{4}" title="0000-9999">
      </label><br>

      <label>Geburtsdatum:
        <input type="date" name="geburtsdatum" required>
      </label><br><br>

      <input type="submit" value="Login">
    </form>

    <p style="margin-top:1rem">
      Noch kein Konto? &nbsp;
      <a href="${pageContext.request.contextPath}/admin/teilnehmer.jsp">
      (Admin) Teilnehmer anlegen
      </a>
    </p>
  </c:when>

  <%-- 2) Login-Verarbeitung --%>
  <c:otherwise>
    <c:set var="zahl" value="${param.zahl}" />
    <c:set var="geburtsdatum" value="${param.geburtsdatum}" />

    <%-- Teilnehmer-Login --%>
    <sql:query var="teilnehmer" dataSource="${db}">
      SELECT kunden_nr, kennzeichnung
      FROM teilnehmer
      WHERE zahl = ? AND geburtsdatum = ?
      <sql:param value="${zahl}" />
      <sql:param value="${geburtsdatum}" />
    </sql:query>

    <%-- Ausbilder-Login --%>
    <sql:query var="ausbilder" dataSource="${db}">
      SELECT kennzeichnung
      FROM ausbilder
      WHERE zahl = ? AND geburtsdatum = ?
      <sql:param value="${zahl}" />
      <sql:param value="${geburtsdatum}" />
    </sql:query>

    <c:choose>
      <%-- Teilnehmer gefunden --%>
      <c:when test="${teilnehmer.rowCount == 1}">
        <c:set var="rolle" value="TEILNEHMER" scope="session" />
        <c:set var="kdn" value="${teilnehmer.rows[0].kunden_nr}" scope="session" />
        <c:set var="kennzeichnung" value="${teilnehmer.rows[0].kennzeichnung}" scope="session" />
        <c:set var="zahl" value="${zahl}" scope="session" />
        <c:set var="geburtsdatum" value="${geburtsdatum}" scope="session" />
        <c:redirect url="${pageContext.request.contextPath}/dashboard/welcome.jsp" />
      </c:when>

      <%-- Ausbilder/Admin gefunden --%>
      <c:when test="${ausbilder.rowCount == 1}">
        <c:set var="rolle" value="ADMIN" scope="session" />
        <c:set var="kennzeichnung" value="${ausbilder.rows[0].kennzeichnung}" scope="session" />
        <c:set var="zahl" value="${zahl}" scope="session" />
        <c:set var="geburtsdatum" value="${geburtsdatum}" scope="session" />
        <c:redirect url="${pageContext.request.contextPath}/dashboard/welcome.jsp" />
      </c:when>

      <%-- Kein Benutzer gefunden --%>
      <c:otherwise>
        <p style="color:red">Kein Benutzer gefunden – bitte nochmals versuchen.</p>
        <p><a href="login.jsp">Zurueck zum Login</a></p>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/common/footer.jspf" %>