<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Admin-only guard -->
<c:if test="${sessionScope.rolle != 'ADMIN'}">
    <p style="color:red">Zugriff verweigert. Nur für Administratoren.</p>
    <c:redirect url="${pageContext.request.contextPath}/auth/login.jsp" />
</c:if>

<section>
    <h2>Ausbilder</h2>

    <table>
        <thead>
        <tr><th>ID</th><th>Name</th><th>E-Mail</th><th>Aktion</th></tr>
        </thead>
        <tbody>
        <c:forEach var="trainer" items="${ausbilderListe}">
            <tr>
                <td><c:out value="${trainer.id}"/></td>
                <td><c:out value="${trainer.name}"/></td>
                <td><c:out value="${trainer.email}"/></td>
                <td>
                    <form method="post"
                          action="${pageContext.request.contextPath}/admin/ausbilder/delete">
                        <input type="hidden" name="id" value="${trainer.id}">
                        <button type="submit">Löschen</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h3>Neuen Ausbilder anlegen</h3>
    <form method="post"
          action="${pageContext.request.contextPath}/admin/ausbilder/add">
        <label>Name:
            <input name="name" required>
        </label>
        <label>E-Mail:
            <input name="email" type="email" required>
        </label>
        <button type="submit">Speichern</button>
    </form>
</section>
