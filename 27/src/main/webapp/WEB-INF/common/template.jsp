<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <title><c:out value="${param.pageTitle}"/></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jspf"/>
<main>
  <!-- Dynamic content goes here -->
  <jsp:include page="${param.contentPage}" />
</main>
<jsp:include page="/WEB-INF/common/footer.jspf"/>
</body>
</html>