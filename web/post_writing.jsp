<%@ page import="model.Document" %>
<%@ page import="model.Member" %>
<%@ page import="worker.DataAccessManager" %>
<%@ page import="worker.DocumentDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 00:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CowSnow 등록</title>
</head>
<body>
</body>
<script>
    <%
    request.setCharacterEncoding("UTF-8");
    Member member = (Member) session.getAttribute("member");

    if (member == null) {
        %>
        alert("로그인해주세요.");
        history.go(-1);
    <%
    } else {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String docIdStr = request.getParameter("docId");
        int docId;
        if (docIdStr == null) {
            docId = 0;
        } else {
            docId = Integer.parseInt(docIdStr);
        }
        boolean release = request.getParameter("release").equals("true");
        boolean edit = request.getParameter("edit").equals("true");

        Document doc = new Document(member.getId(), title, content, release);
        doc.setDocId(docId);

        DocumentDataAccess dda = new DocumentDataAccess();
        boolean result;
        if (edit) {
            result = dda.updateDB(doc, docId);
        } else {
            result = dda.insertDB(doc);
        }

        if (result) {
            %>
    alert("저장되었습니다.");
    window.location = "main.jsp";
    <%
        } else {
            %>
    alert("저장에 실패했습니다.");
    <%
        }

    }
%>
</script>
</html>
