<%@ page import="model.Member" %>
<%@ page import="worker.EncryptManager" %>
<%@ page import="worker.MemberDataAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-23
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>인증</title>
</head>
<body>
</body>
<script>
    <%
    String email = request.getParameter("email");
    String pw = request.getParameter("pw");

    MemberDataAccess mda = new MemberDataAccess();
    Member member = mda.getDB("email", email);

    if (member != null) {
        if (EncryptManager.getHash(1000, pw, member.getSalt()).equals(member.getPw())) {
            session.setAttribute("member", member);
            response.sendRedirect("../main.jsp");
        } else {
            %>
    alert("이메일 혹은 비밀번호가 올바르지 않습니다.");
    history.go(-1);
    <%
        }
    } else {
        %>
    alert("등록된 이메일 혹은 비밀번호가 없습니다.");
    history.go(-1);
    <%
    }
    %>
</script>
</html>
