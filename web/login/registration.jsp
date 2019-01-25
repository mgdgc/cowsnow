<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-21
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="worker.DataAccessManager" %>
<%@ page import="model.Member" %>
<%@ page import="worker.EncryptManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="worker.MemberDataAccess" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>CowSnow 회원가입</title>
</head>
<body>
</body>
<script>
    <jsp:useBean id="member" class="model.Member"/>
    <jsp:setProperty name="member" property="*"/>
    <%
        String salt = EncryptManager.createSalt();
        String encryptedPw = EncryptManager.getHash(1000, member.getPw(), salt);
        member.setSalt(salt);
        member.setPw(encryptedPw);

        MemberDataAccess mda = new MemberDataAccess();

        Member m1 = mda.getDB("email", member.getEmail());
        Member m2 = mda.getDB("nickname", member.getNickname());
        boolean saved = false;

        if (m1 == null && m2 == null) {
            System.out.println(member);
            saved = mda.insertDB(member);
        }

    %>

    var existEmail = <%= m1 != null %>;
    var existNickname = <%= m2 != null %>;
    var saved = <%= saved %>;

    if (existEmail) {
        alert("이미 등록된 email 입니다.");
        history.go(-1);
    } else {
        if (existNickname) {
            alert("이미 등록된 필명입니다.");
            history.go(-1);
        } else {
            if (saved) {
                alert("회원가입되었습니다.");
                <%
                    response.sendRedirect("login.html");
                %>
            } else {
                alert("회원가입에 실패했습니다.");
                history.go(-1);
            }
        }
    }

</script>
</html>
