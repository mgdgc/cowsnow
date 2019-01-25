<%@ page import="model.Member" %>
<%@ page import="worker.DocumentDataAccess" %>
<%@ page import="model.Document" %>
<%@ page import="worker.MemberDataAccess" %>
<%@ page import="worker.CommentDataAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Comment" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    int docId = Integer.parseInt(request.getParameter("docId"));

    DocumentDataAccess dda = new DocumentDataAccess();
    Document document = dda.getDB(docId);

    Member member = (Member) session.getAttribute("member");

    MemberDataAccess mda = new MemberDataAccess();
    Member writerMember = mda.getDB("id", document.getId());

    boolean released = document.isReleased();
    boolean login = member != null && member.getId() == document.getId();
    if (released) {
        document.setViewed(document.getViewed() + 1);
        dda.updateDB(document, docId);
    } else {
        if (login) {
            document.setViewed(document.getViewed() + 1);
            dda.updateDB(document, docId);
        }
    }


    String writer = "";
    if (writerMember != null) {
        writer = writerMember.getNickname();
    }

%>
<html>

<head>
    <title><%= document.getTitle() %>
    </title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>

<body>

<header>
    <button class="goBack" onclick="history.go(-1);">< 뒤로</button>
    <h1><%= document.getTitle() %>
    </h1>
</header>

<div class="body">
    <div class="info"><%= document.getCreated()%> | 작성자 <%= writer %> | 조회수 <%= document.getViewed() %>
    </div>
    <article>
        <%= document.getContent() %>
    </article>
    <%
        if (login) {
    %>
    <div align="right">
        <button style="margin-right: 24px;" id="btnEdit">수정</button>
    </div>
    <%
        }
    %>
    <br>
    <h3 style="margin-left: 18px;">댓글</h3>
    <div class="commentary" align="center">
        <table style="width:90%;">
            <tr>
                <th>시간</th>
                <th style="width: 70%">내용</th>
                <th></th>
            </tr>
            <%
                CommentDataAccess cda = new CommentDataAccess();
                ArrayList<Comment> comments = cda.getDBList(docId);
                if (comments != null) {
                    for (Comment comm : comments) {
                        boolean ownComment = member != null && comm.getId() == member.getId();
            %>
            <tr>
                <td><%= comm.getCreated() %>
                </td>
                <td colspan="<%if (ownComment) out.println(1); else out.println(2); %>"><%= comm.getContent() %>
                </td>
                <%
                    if (ownComment) {
                        %>
                <td><button onclick="if (confirm('댓글을 삭제하시겠습니까?')) proceedRegistration({commId: <%= comm.getCommId() %>, docId: <%= docId %>}, 'delete_comment.jsp');">댓글 삭제</button></td>
                <%
                    }
                %>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="3">댓글이 없습니다.</td>
            </tr>
            <%
                }
            %>
            <tr>
                <td colspan="2"><input style="width: 80%;" type="text" id="txtContent" placeholder="댓글을 입력하세요."></td>
                <td>
                    <button id="btnSubmit" onclick="">등록</button>
                </td>
            </tr>
        </table>
    </div>
    <br><br><br><br>

</div>

</body>
<script>
    var released = <%= released %>;
    var login = <%= login %>;
    if (!login && !released) {
        alert("비공개 게시글입니다.");
        history.go(-1);
    }

    var btnEdit = document.getElementById("btnEdit");
    var btnSubmit = document.getElementById("btnSubmit");
    btnSubmit.addEventListener("click", function () {
        <%
            if (member == null) {
                %>
        alert("로그인이 필요합니다.");
        <%
            } else {
        %>
        var content = document.getElementById("txtContent").value;
        proceedRegistration({
            id: "<%= member.getId() %>",
            content: content,
            docId: <%= docId %>
        }, "post_comment.jsp");
        <%
            }
        %>
    });

    btnEdit.addEventListener("click", function () {
        proceedRegistration({
            edit: true,
            docId: <%= docId %>
        }, "write.jsp");
    });

    function proceedRegistration(params, url) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", url);

        for (var key in params) {
            if (params.hasOwnProperty(key)) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", key);
                hiddenField.setAttribute("value", params[key]);

                form.appendChild(hiddenField);
            }
        }

        document.body.appendChild(form);
        form.submit();
    }

</script>

</html>
