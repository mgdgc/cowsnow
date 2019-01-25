<%@ page import="worker.CommentDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CowSnow 댓글 삭제</title>
</head>
<body>
</body>
<script>
    <%
        request.setCharacterEncoding("UTF-8");

        String docIdStr = request.getParameter("docId");
        int docId = 0;
        if (docIdStr != null) {
            docId = Integer.parseInt(docIdStr);
        }

        String commIdStr = request.getParameter("commId");
        int commId = 0;
        if (commIdStr != null) {
            commId = Integer.parseInt(commIdStr);
        } else {
            %>
    alert("댓글을 삭제하는데 실패했습니다.");
    history.go(-1);
    <%
        }

        CommentDataAccess cda = new CommentDataAccess();
        boolean result = cda.deleteDB(commId);

        if (result) {
            if (docId != 0) {
                response.sendRedirect("view.jsp?docId=" + docId);
            } else {
                response.sendRedirect("main.jsp");
            }
        }
    %>
</script>
</html>
