<%@ page import="model.Member" %>
<%@ page import="worker.EncryptManager" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-23
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) session.getAttribute("member");
    if (member == null) response.sendRedirect("login/login.html");

    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>CowSnow: 계정</title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>
<body>
<header>
    <h1>CowSnow 개인정보 수정</h1>
</header>

<div class="body" align="center">
    <p>개인정보를 수정한 후 완료 버튼을 눌러주세요.</p>
    <table>
        <tr>
            <th>이름</th>
            <td><input type="text" id="userName"></td>
        </tr>
        <tr>
            <th>필명</th>
            <td><input type="text" id="nickname"></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><input type="email" id="email" style="color: gray;" readonly></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" id="pw"></td>
        </tr>
        <tr>
            <th>비밀번호 확인</th>
            <td><input type="password" id="pwCheck"></td>
        </tr>
    </table>
    <button id="btnComplete">완료</button>
</div>

<footer>
    CowSnow by Choi Myeong-geun
    <br><a href="http://ridsoft.xyz">RiDsoft</a> presents
    | <a href="mailto:soc06212@gmail.com">soc06212@gmail.com</a>
</footer>
</body>
<script>

    <%
        String pw = request.getParameter("pw");
        String hash = EncryptManager.getHash(1000, pw, member.getSalt());
        if (!member.getPw().equals(hash)) {
            %>
    alert("비밀번호가 다릅니다.");
    history.go(-1);
    <%
        } else {
            %>
    var userName = document.getElementById("userName");
    var nickname = document.getElementById("nickname");
    var email = document.getElementById("email");
    var pw = document.getElementById("pw");
    var pwCheck = document.getElementById("pwCheck");
    var btnComplete = document.getElementById("btnComplete");

    userName.value = "<%= member.getUserName() %>";
    nickname.value = "<%= member.getNickname() %>";
    email.value = "<%= member.getEmail() %>";

    btnComplete.addEventListener("click", function () {
        if (verify()) {
            proceedRegistration({
                userName: userName.value,
                nickname: nickname.value,
                pw: pw.value
            });
        }
    });

    function verify() {
        if (userName.value.length === 0) {
            alert("이름을 입력해 주세요.");
            return false;
        }

        if (nickname.value.length === 0) {
            alert("필명을 입력해 주세요.");
            return false;
        }

        if (email.value.length === 0) {
            alert("이메일을 입력해 주세요.");
            return false;
        }

        if (pw.value.length === 0) {
            alert("비밀번호를 입력해 주세요.");
            return false;
        }

        if (pwCheck.value.length === 0) {
            alert("비밀번호 확인을 위해 한번 더 입력해 주세요.");
            return false;
        } else {
            if (pw.value !== pwCheck.value) {
                alert("비밀번호를 다시 확인해주세요.");
                return false;
            }
        }

        return true;
    }

    function proceedRegistration(params) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "login/update_account.jsp");

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

    <%
        }
    %>

</script>
</html>
