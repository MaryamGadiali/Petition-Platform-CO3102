<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <title>Create a petition</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body style="background: #EEEEEE;">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="/dashboard">SLPP</a>
        <div class="d-flex">
            <span class="navbar-text me-3">Welcome, ${userName}!</span>
            <a href="/logout" class="btn btn-sm btn-outline-light" style="align-self: center">Logout</a>
        </div>
    </div>
</nav>
 <div class="container mt-5 col-sm-12 col-lg-6 p-4">
        <div class="card shadow">
            <div class="card-header">
                <h2>Create a new Petition</h2>
            </div>
            <div class="card-body">
                <form:form action="/petition/save" method="post" modelAttribute="petition">
                    <div class="mb-3">
                        <form:label path="title" class="form-label">Title:</form:label>
                        <form:input path="title" class="form-control" placeholder="Enter a petition title" required="required"/>
                        <form:errors path="title" cssClass="error"/>
                    </div>
                    <div class="mb-3">
                        <form:label path="content" class="form-label">Content:</form:label>
                        <form:textarea path="content" class="form-control" placeholder="Enter details about the petition" required="required"/>
                        <form:errors path="content" cssClass="error"/>
                    </div>
                    <div class="d-flex justify-content-between">
                        <a href="/listAllPetitions" class="btn btn-primary">Back</a>
                        <input type="submit" value="Add" class="btn btn-success"/>
                    </div>
                </form:form>
            </div>
        </div>
    </div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>