<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
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

<div class="content-wrapper">
    <h2>Skriptuebersicht</h2>

    <div class="table-responsive">
        <table>
            <thead>
            <tr>
                <th>Inventar-Nr</th>
                <th>Skript-Nr</th>
                <th>Autor</th>
                <th>Kurs</th>
                <th>Status</th>
                <th>Aktion</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${skripte.rows}">
                <tr>
                    <td>${row.inventarnummer}</td>
                    <td>${row.skript_nummer}</td>
                    <td>${row.autor}</td>
                    <td>${row.kursname}</td>
                    <td>
                            <span class="status-badge ${row.status eq 'verfügbar' ? 'available' : 'borrowed'}">
                                    ${row.status}
                            </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${row.status eq 'verfügbar' && sessionScope.rolle eq 'ADMIN'}">
                                <form method="post" action="${pageContext.request.contextPath}/skript/ausleihen">
                                    <input type="hidden" name="inventarNr" value="${row.inventarnummer}" />
                                    <button type="submit" class="btn-action">Ausleihen</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span class="no-action">—</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>