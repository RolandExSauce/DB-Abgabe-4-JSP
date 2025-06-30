<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Optional: Restrict to Admins -->
<c:if test="${sessionScope.rolle != 'ADMIN'}">
    <p style="color:red">Zugriff verweigert. Nur für Administratoren.</p>
    <c:redirect url="${pageContext.request.contextPath}/auth/login.jsp" />
</c:if>

<section>
    <h2>Benutzerkonten</h2>

    <table>
        <thead>
        <tr><th>ID</th><th>Rolle</th><th>Name</th><th>Status</th><th>Aktion</th></tr>
        </thead>
        <tbody>
        <c:forEach var="konto" items="${kontenListe}">
            <tr>
                <td><c:out value="${konto.id}"/></td>
                <td><c:out value="${konto.rolle}"/></td>
                <td><c:out value="${konto.name}"/></td>
                <td><c:out value="${konto.aktiv ? 'aktiv' : 'gesperrt'}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${konto.aktiv}">
                            <form method="post"
                                  action="${pageContext.request.contextPath}/admin/konten/deactivate">
                                <input type="hidden" name="id" value="${konto.id}">
                                <button type="submit">Sperren</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/admin/konten/activate">
                                <input type="hidden" name="id" value="${konto.id}">
                                <button type="submit">Aktivieren</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</section>
