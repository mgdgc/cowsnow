<%@ page import="model.Member" %>
<%@ page import="worker.MemberDataAccess" %>
<%@ page import="worker.EncryptManager" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) session.getAttribute("member");
    if (member == null) {
        response.sendRedirect("login/login.html");
    }
%>
<html>
<head>
    <title>CowSnow 계정 확인</title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>
<body>
<header>
    <h1>CowSnow 로그인</h1>
</header>

<div class="body" align="center" onsubmit="return verify();">
    <p>계정 정보 확인을 위해 비밀번호를 확인해 주세요.</p>
    <form action="../account.jsp" method="post">
        <label>
            비밀번호 확인<input type="password" name="pw">
        </label>
        <input type="submit" value="확인">
    </form>
</div>

<footer>
    CowSnow by Choi Myeong-geun
    <br><a href="http://ridsoft.xyz">RiDsoft</a> presents
    | <a href="mailto:soc06212@gmail.com">soc06212@gmail.com</a>
</footer>
</body>
</html>
