<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <title>View Petition</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   </head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="/dashboard">SLPP</a>
        <div class="d-flex">
            <span class="navbar-text me-3">Welcome, ${userName}!</span>
            <a href="/logout" class="btn btn-sm btn-outline-light" style="align-self: center">Logout</a>
        </div>
    </div>
</nav>
<div class="d-flex flex-column justify-content-center align-items-center vh-100" style="background: #EEEEEE;">
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mb-4">
                <h5 class="card-header text-bg-secondary text-white">Created by ${petition.petitionCreator.fullname}</h5>
                <div class="card-body">
                    <h5 class="card-title">${petition.title}</h5>
                    <p class="card-text">${petition.content}</p>
                    <p class="card-text">Signature count: <span id="signatureCountID">${petition.signatureCount}</span></p>

                    <c:choose>
                        <c:when test="${isSigned}">
                            <p class="text-success">You have already signed this petition</p>
                        </c:when>
                        <c:when test="${isCreator}">
                            <p class="text-warning">You are the creator of this petition, so you cannot sign it</p>
                        </c:when>
                        <c:when test="${petition.status.equals(\"closed\")}">
                            <p class="text-danger">This petition is closed to signatures</p>
                        </c:when>
                        <c:otherwise>
                            <button id="signButton" class="btn btn-primary mb-3" style="display: block" onclick="signPetition(${petition.petitionID})">Click here to SIGN the petition</button>
                            <div id="signedDiv" class="alert alert-success" style="display:none">
                                <p>You have signed this petition</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
            </div>
        </div>
    </div>
    <c:choose>
    <c:when test="${empty petition.response}">
        <div class="col-md-8 text-center">
            <div class="alert alert-secondary">No response received yet</div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Received Response:</h5>
                    <p class="card-text">${petition.response}</p>
                </div>
            </div>
        </div>
    </c:otherwise>
    </c:choose>

        <div class="col-md-8 text-center">
            <button onclick="window.location.href='/listAllPetitions'" class="btn btn-secondary">Go back to list of petitions</button>
        </div>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>


<script>
    $(document).ready(function() {
    });

    function signPetition(petitionID){
        $.ajax({
            url: "/signPetition/" + petitionID,
            type: "POST",
            success: function(response) {
                if (response=="Success"){
                    $("#signButton").hide();
                    $("#signedDiv").show();
                    var signatureCount = parseInt($("#signatureCountID").text());
                    signatureCount++;
                    $("#signatureCountID").text(signatureCount);
                    alert("You have successfully signed this petition!");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error signing petition:", status, error);
                alert("An error occurred while signing the petition. Please try again.");
            }
        });
    }

</script>

</html>