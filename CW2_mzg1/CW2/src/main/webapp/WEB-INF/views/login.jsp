<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="d-flex flex-column justify-content-center align-items-center vh-100" style="background: #EEEEEE;" >
<h1 class="mb-4 p-3" >Shangri-La Petition Platform</h1>
<div class="card shadow p-4 mb-2" style= "width: 100%; max-width: 30rem; height: 100%; max-height: 30rem">
<h2 class="text-center mb-4">Login</h2>
<form action="/login" method="post" >
    <div class="mb-3">
        <label for="userEmail" class="form-label">Username:</label>
        <input type="email" id="userEmail" name="username" class="form-control" placeholder="Enter email" required>
    </div>

    <div class="mb-3">
        <label for="passwordHash" class="form-label">Password:</label>
        <input type="password" id="passwordHash" name="password" placeholder="Enter password" class="form-control" required>
    </div>

    <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me">
        <label class="form-check-label" for="remember-me">Remember me</label>
    </div>
    <div>
        <button class="btn btn-primary" type="submit">Login</button>
    </div>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger mb-2 mt-2" role="alert">
            Incorrect username or password
        </div>
    </c:if>
</form>
    <p class="mt-2 mb-4">If you don't have a username or password, please <a href="/register">register here</a>.</p>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

<script>


</script>
</html>