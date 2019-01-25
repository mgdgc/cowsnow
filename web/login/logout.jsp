<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃</title>
</head>
<body>
<%
    session.setAttribute("member", null);
    response.sendRedirect("../main.jsp");
%>
</body>
</html>
