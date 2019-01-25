<%@ page import="worker.EncryptManager" %>
<%@ page import="worker.MemberDataAccess" %>
<%@ page import="model.Member" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-24
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    Member member = (Member) session.getAttribute("member");
%>
<html>
<head>
    <title>CowSnow: 계정</title>
</head>
<body>
</body>
<script>
    <%
        member.setUserName(request.getParameter("userName"));
        member.setNickname(request.getParameter("nickname"));

        String salt = EncryptManager.createSalt();
        String encryptedPw = EncryptManager.getHash(1000, member.getPw(), salt);
        member.setSalt(salt);
        member.setPw(encryptedPw);

        MemberDataAccess mda = new MemberDataAccess();

        Member m2 = mda.getDB("nickname", member.getNickname());
        boolean saved = false;

        if (m2 == null) {
            saved = mda.updateDB(member);
        }
    %>

    var existNickname = <%= m2 != null %>;
    var saved = <%= saved %>;

    if (existNickname) {
        alert("이미 등록된 필명입니다.");
        history.go(-1);
    } else {
        if (saved) {
            <%
                response.sendRedirect("logout.jsp");
            %>
        } else {
            alert("실패했습니다.");
            history.go(-1);
        }
    }
</script>
</html>
