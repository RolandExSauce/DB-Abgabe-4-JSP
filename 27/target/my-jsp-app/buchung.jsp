<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<sql:query dataSource="${uniDB}" var="bookings">
    SELECT * FROM buchungen WHERE kurs_id = ?
    <sql:param value="${param.kursId}"/>
</sql:query>

<table>
    <c:forEach items="${bookings.rows}" var="row">
        <tr>
            <td>${row.id}</td>
            <td>${row.teilnehmer}</td>
        </tr>
    </c:forEach>
</table>