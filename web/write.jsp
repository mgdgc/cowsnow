<%@ page import="model.Document" %>
<%@ page import="worker.DocumentDataAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    DocumentDataAccess dda = new DocumentDataAccess();
    Document document = null;

    String editStr = request.getParameter("edit");
    boolean edit;
    if (editStr == null) {
        edit = false;
    } else {
        edit = Boolean.parseBoolean(editStr);
        document = dda.getDB(Integer.parseInt(request.getParameter("docId")));
    }
%>
<html>

<head>
    <title>CowSnow <% if (edit) out.println("글 수정");
    else out.println("글 작성");%></title>
    <meta charset="utf-8">
    <meta userName="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Gothic+A1:200,400" rel="stylesheet">
</head>

<body>
<header>
    <h1><% if (edit) out.println("글 수정");
    else out.println("글 작성");%></h1>
</header>
<div class="body" align="center">
    <input id="txtTitle" type="text" placeholder="제목">
    <textarea id="txtContent" placeholder="내용 입력"></textarea>
    <br><br><input type="checkbox" id="doNotRelease"><label for="doNotRelease">비공개로 게시</label>
    <br><br>
    <button id="submitWriting">저장</button>
</div>
</body>
<script>
    var btnSubmit = document.getElementById("submitWriting");
    var cbDoNotRelease = document.getElementById("doNotRelease");
    var txtTitle = document.getElementById("txtTitle");
    var txtContent = document.getElementById("txtContent");

    <%
        if (edit) {
            %>
    txtTitle.value = "<%= document.getTitle() %>";
    txtContent.value = "<%= document.getContent() %>";
    cbDoNotRelease.checked = <%= !document.isReleased() %>;
    <%
        }
    %>

    btnSubmit.addEventListener("click", function () {
        var title = txtTitle.value;
        var content = txtContent.value;

        if (title.length === 0) {
            alert("제목을 입력해 주세요.");
        } else {
            if (content.length === 0) {
                alert("내용을 입력해 주세요.");
            } else {
                var confirmed = confirm("등록하시겠습니까?\n등록한 이후에는 글을 삭제할 수 없으며, 비공개만 가능합니다.");
                if (confirmed) {
                    proceedRegistration({
                        title: title,
                        content: content,
                        release: !cbDoNotRelease.checked,
                        edit: <%= edit %>
                        <%
                        if (document != null && edit) out.println(", docId: " + document.getDocId());
                        %>
                    });
                }
            }
        }
    });

    function proceedRegistration(params) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "post_writing.jsp");

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
