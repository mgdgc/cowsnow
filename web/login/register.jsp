<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2018-12-15
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Member" %>
<%@ page import="worker.EncryptManager" %>
<!DOCTYPE HTML>
<html lang="ko">

<head>
    <title>CowSnow 회원가입</title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1" rel="stylesheet">
</head>

<body>
<header>
    <h1>CowSnow 회원가입</h1>
</header>

<div class="body" align="center">
    <p>서비스 이용을 위해 회원가입을 해 주세요.</p>
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
            <td><input type="email" id="email"></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" id="pw"></td>
        </tr>
        <tr>
            <th>비밀번호 확인</th>
            <td><input type="password" id="pwCheck"></td>
        </tr>
        <tr>
            <th>개인정보처리방침<br>
                <button onclick="window.location='user_policy.html'; target='_blank';">보기</button>
            </th>
            <td><input type="checkbox" id="userPolicy">
                <label for="userPolicy">약관을 읽고 동의합니다</label>
            </td>
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
<script type="text/javascript">

    btnComplete.addEventListener('click', function () {
        if (verify()) {
            var confirmed = confirm("회원가입을 하시겠습니까?");
            if (confirmed) {
                var btnComplete = document.getElementById("btnComplete");
                var userName = document.getElementById("userName").value.trim();
                var nickname = document.getElementById("nickname").value.trim();
                var email = document.getElementById("email").value.trim();
                var pw = document.getElementById("pw").value.trim();
                var pwCheck = document.getElementById("pwCheck").value.trim();
                var userPolicy = document.getElementById("userPolicy").checked;

                proceedRegistration({
                    userName: userName,
                    nickname: nickname,
                    email: email,
                    pw: pw
                });
            } else {
                alert("취소되었습니다.");
            }
        }
    });

    function verify() {
        var btnComplete = document.getElementById("btnComplete");
        var userName = document.getElementById("userName").value.trim();
        var nickname = document.getElementById("nickname").value.trim();
        var email = document.getElementById("email").value.trim();
        var pw = document.getElementById("pw").value.trim();
        var pwCheck = document.getElementById("pwCheck").value.trim();
        var userPolicy = document.getElementById("userPolicy").checked;

        if (userName.length === 0) {
            alert("이름을 입력해 주세요.");
            return false;
        }

        if (nickname.length === 0) {
            alert("필명을 입력해 주세요.");
            return false;
        }

        if (email.length === 0) {
            alert("이메일을 입력해 주세요.");
            return false;
        }

        if (pw.length === 0) {
            alert("비밀번호를 입력해 주세요.");
            return false;
        }

        if (pwCheck.length === 0) {
            alert("비밀번호 확인을 위해 한번 더 입력해 주세요.");
            return false;
        } else {
            if (pw !== pwCheck) {
                alert("비밀번호를 다시 확인해주세요.");
                return false;
            }
        }

        if (!userPolicy) {
            alert("죄송합니다. 개인정보처리방침에 동의하셔야 회원가입이 가능합니다.");
            return false;
        }

        return true;
    }

    function proceedRegistration(params) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "registration.jsp");

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

