<%@ page import="model.Member" %>
<%@ page import="model.Document" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="worker.DocumentDataAccess" %>
<%@ page import="worker.MemberDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-15
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    Member member = (Member) session.getAttribute("member");
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>CowSnow</title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>

<body>
<header>
    <button id="btnNav"><img id="btnNavImg" src="${pageContext.request.contextPath}/res/1x/baseline_menu_white_36dp.png"
                             draggable="false"></button>
    <h1>CowSnow</h1>
</header>
<nav id="nav" hidden>
    <ul>
        <%
            if (member == null) {
        %>
        <li><a href="login/login.html" style="text-decoration: none; color: white;">로그인</a></li>
        <%
        } else {
        %>
        <li><a href="login/check_pw.jsp" style="text-decoration: none; color: white;">계정</a></li>
        <li><a href="login/logout.jsp" style="text-decoration: none; color: white;">로그아웃</a></li>
        <%
            }
        %>
        <li><a href="list_all.jsp?mode=0" style="text-decoration: none; color: white;">최신 글 보기</a></li>
        <li><a href="list_all.jsp?mode=1" style="text-decoration: none; color: white;">인기 글 보기</a></li>
    </ul>
</nav>
<div class="body" align="center">
    <h3 style="font-weight: normal;"><a style="color: black;" href="list_all.jsp?mode=0">최신순</a></h3>
    <div class="card">
        <table>
            <tr>
                <th>등록일</th>
                <th>제목</th>
                <th>작가</th>
            </tr>
            <%
                DocumentDataAccess dda = new DocumentDataAccess();
                MemberDataAccess mda = new MemberDataAccess();

                ArrayList<Member> members = mda.getDBList();
                if (members == null) members = new ArrayList<>();

                ArrayList<Document> docs = dda.getDBList();
                if (docs == null || docs.isEmpty()) {
            %>
            <tr>
                <th colspan="3">데이터가 없습니다.</th>
            </tr>
            <%
            } else {
                int index = 0;
                for (Document doc : docs) {
                    if (index++ >= 5) {
                        break;
                    }
            %>
            <tr>
            <td><%= doc.getCreated() %>
            </td>
                <td><a href="view.jsp?docId=<%= doc.getDocId() %>"><%= doc.getTitle() %></a>
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

    <h3 style="font-weight: normal;"><a style="color: black;" href="list_all.jsp?mode=1">인기순</a></h3>
    <div class="card">
        <table>
            <tr>
                <th>조회수</th>
                <th>제목</th>
                <th>작가</th>
            </tr>
            <%
                ArrayList<Document> sorted = Document.sortByMostViewed(docs);
                if (sorted == null || sorted.isEmpty()) {
            %>
            <tr>
                <th colspan="3">데이터가 없습니다.</th>
            </tr>
            <%
            } else {
                int index = 0;
                for (Document doc : sorted) {
                    if (index++ >= 5) {
                        break;
                    }
            %>
            <tr>
            <td><%= doc.getViewed() %>
            </td>
                <td><a href="view.jsp?docId=<%= doc.getDocId() %>"><%= doc.getTitle() %></a>
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

<div>
    <button class="actionButton" id="actionBtn">
        <img class="actionButtonSrc" src="${pageContext.request.contextPath}/res/2x/btn_write.png"
             draggable="false">
    </button>
</div>
</body>
<script>
    var nav = document.getElementById("nav");
    var btnNav = document.getElementById("btnNav");
    var imgNav = document.getElementById("btnNavImg");
    var btnWrite = document.getElementById("actionBtn");

    var navOpen = false;
    btnNav.addEventListener("click", function () {
        if (navOpen) {
            nav.setAttribute("hidden", "");
            imgNav.setAttribute("src", "${pageContext.request.contextPath}/res/1x/baseline_menu_white_36dp.png");
        } else {
            nav.removeAttribute("hidden");
            imgNav.setAttribute("src", "${pageContext.request.contextPath}/res/1x/baseline_close_white_36dp.png");
        }
        navOpen = !navOpen;
    });

    btnWrite.addEventListener("click", function () {
        <%
            if (member == null) {
                %>
        alert("글을 작성하려면 로그인을 해주세요.");
        <%
            } else {
                %>
        window.location = "write.jsp";
        <%
            }
        %>
    });
</script>
</html>
