<%@ page import="worker.CommentDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>CowSnow 댓글 등록</title>
</head>
<body>
</body>
<script>
    <jsp:useBean id="comment" class="model.Comment"/>
    <jsp:setProperty name="comment" property="*"/>
    <%
        int docId = Integer.parseInt(request.getParameter("docId"));
        CommentDataAccess cda = new CommentDataAccess();
        boolean success = cda.insertDB(comment);
    %>

    var success = <%= success %>;
    var docId = <%= docId %>;

    if (success) {
        <%
        response.sendRedirect("view.jsp?docId=" + docId);
        %>
    } else {
        alert("댓글 저장에 실패했습니다.");
    }
</script>
</html>
