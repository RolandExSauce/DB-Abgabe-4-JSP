<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<sql:query var="kurse" dataSource="${db}">
    SELECT kursname, anzahl_organisatoren, vorbereitungszeit
    FROM kurs
    ORDER BY kursname;
</sql:query>

<h2>Kursuebersicht</h2>

<table>
    <tr>
        <th>Kurs</th>
        <th>Organisatoren</th>
        <th>Vorbereitungszeit&nbsp;(Min)</th>
    </tr>

    <c:forEach var="k" items="${kurse.rows}">
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/kurs/kurs.jsp?name=${k.kursname}">
                        ${k.kursname}
                </a>
            </td>
            <td>${k.anzahl_organisatoren}</td>
            <td>${k.vorbereitungszeit}</td>
        </tr>
    </c:forEach>
</table>
