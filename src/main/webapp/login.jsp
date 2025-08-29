<%--
  Created by IntelliJ IDEA.
  User: Enigma
  Date: 29/08/2025
  Time: 8:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="vh-100 overflow-hidden">
    <main class="h-100 d-flex justify-content-center align-items-center">
        <div class="w-25 rounded shadow p-3">
            <h2 class="text-center">Login</h2>
            <form id="loginForm" class="w-100">
                <div class="mb-3">
                    <label for="userId" class="form-label">User ID</label>
                    <input class="form-control" type="text" id="userId" name="userId" required>
                    <div class="invalid-feedback">User ID is required</div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input class="form-control" type="password" id="password" name="password" required>
                    <div class="invalid-feedback">Password is required</div>
                </div>

                <button class="btn btn-primary w-100" type="submit">Sign in</button>
            </form>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js" integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        $(function(){
            $("#loginForm").on("submit", function(e) {
                e.preventDefault()

                const loginFormEl = $("#loginForm")
                const userId = $("#userId").val()
                const password = $("#password").val()

                console.log(userId, password)

                loginFormEl.addClass("was-validated")

                if(loginFormEl[0].checkValidity()){
                    $.ajax({
                        url: "<%=ctx%>/auth/login",
                        method: "POST",
                        data: {
                            userId,
                            password
                        },
                        dataType: "json",
                        success: function(res) {
                            if (!res.success) {
                                showAlert(res.message)
                            } else {
                                window.location.href = "<%=ctx%>/"
                            }
                        },
                        error: function() {
                            showAlert("Internal Server Error")
                        }
                    })
                }
            })

            function showAlert(message){
                const contentHtml = `
                <div class="alert alert-danger alert-dismissible" role="alert">
                    <div>\${message}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="close"></button>
                </div>
                `

                $("#loginForm").prepend(contentHtml)
            }
        })
    </script>
</body>
</html>
