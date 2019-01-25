<%@ page import="worker.DocumentDataAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Document" %>
<%@ page import="model.Member" %>
<%@ page import="worker.MemberDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String modeStr = request.getParameter("mode");
    int mode;
    if (modeStr == null) {
        mode = 0;
    } else {
        mode = Integer.parseInt(modeStr);
    }

    DocumentDataAccess dda = new DocumentDataAccess();
    ArrayList<Document> docs;
    if (mode == 0) {
        docs = dda.getDBList("docId");
    } else {
        docs = dda.getDBList("viewed");
    }

    MemberDataAccess mda = new MemberDataAccess();

    ArrayList<Member> members = mda.getDBList();
    if (members == null) members = new ArrayList<>();

%>
<html>
<head>
    <title>CowSnow <% if (mode == 0) out.println("최신글");
    else out.println("인기글"); %></title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>
<body>

<header>
    <button class="goBack" onclick="history.go(-1);">< 뒤로</button>
    <h1><% if (mode == 0) out.println("최신글");
    else out.println("인기글"); %></h1>
</header>

<div class="body" align="center">
    <div class="card">
        <table>
            <tr>
                <th>등록일</th>
                <th style="width: 60%">제목</th>
                <th>작가</th>
            </tr>
            <%
                if (docs == null || docs.isEmpty()) {
            %>
            <tr>
                <th colspan="3">데이터가 없습니다.</th>
            </tr>
            <%
            } else {
                for (Document doc : docs) {
            %>
            <tr>
                <td><%= doc.getCreated() %>
                </td>
                <td><a href="view.jsp?docId=<%= doc.getDocId() %>"><%= doc.getTitle() %>
                </a>
                </td>
                <%
                    String writer;
                    Member m1 = mda.getDB("id", doc.getId());
                    if (m1 == null) {
                        writer = "";
                    } else {
                        writer = m1.getNickname();
                    }
                %>
                <td><%= writer %>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</div>
</body>
</html>
