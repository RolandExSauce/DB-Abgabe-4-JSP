<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%@ include file="/WEB-INF/common/header.jspf" %>
<%@ include file="/WEB-INF/common/datasource.jspf" %>

<sql:query var="skripte" dataSource="${db}">
    SELECT s.inventarnummer,
    st.nummer AS skript_nummer,
    st.autor,
    st.kursname,
    CASE
    WHEN oae.inventar_nr IS NOT NULL THEN 'verliehen'
    ELSE 'verfügbar'
    END AS status
    FROM skript s
    JOIN skriptentyp st ON s.nummer = st.nummer
    LEFT JOIN organisator_oder_ausbilder_entleiht_skript oae
    ON oae.inventar_nr = s.inventarnummer
    ORDER BY s.inventarnummer;
</sql:query>

<h2>Skriptübersicht</h2>

<table border="1" cellpadding="4">
    <tr>
        <th>Inventar-Nr</th>
        <th>Skript-Nr</th>
        <th>Autor</th>
        <th>Kurs</th>
        <th>Status</th>
        <th>Aktion</th>
    </tr>

    <c:forEach var="row" items="${skripte.rows}">
        <tr>
            <td>${row.inventarnummer}</td>
            <td>${row.skript_nummer}</td>
            <td>${row.autor}</td>
            <td>${row.kursname}</td>
            <td>${row.status}</td>
            <td>
                <c:if test="${row.status eq 'verfügbar'}">
                    <form method="post" action="skriptausleihe.jsp">
                        <input type="hidden" name="inventarNr" value="${row.inventarnummer}" />
                        <input type="submit" value="Ausleihen">
                    </form>
                </c:if>
                <c:if test="${row.status eq 'verliehen'}">
                    —
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/common/footer.jspf" %>
