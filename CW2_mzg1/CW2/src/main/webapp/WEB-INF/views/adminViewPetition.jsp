<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <title>Admin View Petition</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body style="background: #EEEEEE;">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark ">
    <div class="container-fluid">
        <a class="navbar-brand" href="/dashboard">SLPP</a>
        <div class="d-flex">
            <span class="navbar-text me-3">Welcome, ${userName}!</span>
            <a href="/logout" class="btn btn-sm btn-outline-light" style="align-self: center">Logout</a>
        </div>
    </div>
</nav>
<div class="d-flex flex-column justify-content-center align-items-center vh-100">
<div class="container ">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mb-4">
                <h5 class="card-header text-bg-secondary text-white">Created by ${petition.petitionCreator.fullname}</h5>
                <div class="card-body">
                    <h5 class="card-title">${petition.title}</h5>
                    <p class="card-text">${petition.content}</p>
                    <p class="card-text">Signature count: <span id="signatureCountID">${petition.signatureCount}</span></p>
                </div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty petition.response}">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <button type="button" id="responseButton" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#writeResponseModal">
                        Write Response
                    </button>
                </div>
            </div>
            <div class="row justify-content-center" id="responseDiv" style="display: none;">
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Response has already been given:</h5>
                            <p id="responseDivText" class="card-text">${petition.response}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Response has already been given:</h5>
                            <p class="card-text">${petition.response}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <button onclick="window.location.href='/admin/petitionsCommitteeDashboard'" class="btn btn-secondary">
                Go back to list of petitions
            </button>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="writeResponseModal" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Write the response</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <textarea class="form-control" id="responseText" rows="3" placeholder="Write your response here..."></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="sendCompletedResponseButton" onclick="sendCompletedResponse()" class="btn btn-primary">Send</button>
            </div>
        </div>
    </div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    function sendCompletedResponse(){
        const responseText = $('#responseText').val();
        const petitionID = ${petition.petitionID};
        $.ajax({
            url: "/admin/petition/" + petitionID + "/sendResponse",
            type: "POST",
            data: {
                responseText: responseText,
            },
            success: function (response) {
                console.log("Response is: " + response);
                if(response == "Success"){
                    $('#writeResponseModal').modal('hide');
                    $('#responseButton').hide();
                    $('#responseDiv').show();
                    $('#responseDivText').text(responseText);
                }
            }
        });
    }
</script>

</body>
</html>
