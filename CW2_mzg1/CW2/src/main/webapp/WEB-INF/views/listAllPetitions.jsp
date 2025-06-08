<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <title>List of Petitions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body style="background: #EEEEEE; max-height: 10rem" >
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="/dashboard">SLPP</a>
        <div class="d-flex">
            <span class="navbar-text me-3">Welcome, ${userName}!</span>
            <a href="/logout" class="btn btn-sm btn-outline-light" style="align-self: center">Logout</a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <h2 class="text-center mb-4">List of Petitions</h2>
    <div class="text-center mb-3">
        <a href="/petition/create" class="btn btn-primary">Create new petition</a>
    </div>
<%--Model attributes are userSignedPetitions,userUnsignedPetitions, userCreatedPetitions--%>
<ul class="nav nav-tabs justify-content-center mb-3">
    <li class="nav-item">
        <a class="nav-link active" id="unsignedPetitionNav" style="cursor: pointer;" onclick="displayUnsignedPetitions()" >Unsigned Petitions</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="signedPetitionNav" onclick="displaySignedPetitions()" style="cursor: pointer;">Signed Petitions</a>
    </li>
    <li class="nav-item">
        <a class="nav-link " id="createdPetitionNav" onclick="displayCreatedPetitions()" style="cursor: pointer;">Your Created Petitions</a>
    </li>
</ul>

<div id="unsignedPetitions" style="display:block; max-height: 40rem;  justify-items: center" class = "row g-3 mt-3">
    <c:choose>
    <c:when test="${userUnsignedPetitions.size() > 0}">
    <c:forEach items="${userUnsignedPetitions}" var="petition" varStatus="itr">
        <div class="col-lg-6 col-sm-12" >
        <div class="card shadow-sm h-100">
            <c:if test="${petition.status.equals('open')}">
                <h5 class="card-header bg-success text-white">Open</h5>
            </c:if>
            <c:if test="${petition.status.equals('closed')}">
                <h5 class="card-header bg-secondary text-white">Closed</h5>
            </c:if>
            <div class="card-body">
                <h5 class="card-title">${petition.title}</h5>
                <p class="card-text">${petition.content}</p>
                <p class="card-text">Signature count: ${petition.signatureCount}</p>
                <a href="/petition/${petition.petitionID}" class="btn btn-outline-primary w-100">View</a>
            </div>
        </div>
        </div>
    </c:forEach>
    </c:when>
        <c:otherwise>
            <div style="height: 15rem;" class="d-flex align-items-center justify-content-center">
                <div class="text-center">
                    <h1>No Petitions to sign</h1>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<div id="signedPetitions" style="display:none; max-height: 40rem; justify-items: center" class = "row g-3 mt-3">
    <c:choose>
    <c:when test="${userSignedPetitions.size() > 0}">
      <c:forEach items="${userSignedPetitions}" var="petition" varStatus="itr">
        <div class="col-lg-6 col-sm-12">
            <div class="card shadow-sm h-100">
            <c:if test="${petition.status.equals('open')}">
                <h5 class="card-header bg-success text-white">Open</h5>
            </c:if>
            <c:if test="${petition.status.equals('closed')}">
                <h5 class="card-header bg-secondary text-white">Closed</h5>
            </c:if>

            <div class="card-body">
                <h5 class="card-title">${petition.title}</h5>
                <p class="card-text">${petition.content}</p>
                <p class="card-text">Signature count: ${petition.signatureCount}</p>
                <a href="/petition/${petition.petitionID}" class="btn btn-outline-secondary w-100">View</a>
            </div>
        </div>
        </div>
    </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="d-flex align-items-center justify-content-center" style="height: 15rem;">
            <div class="text-center">
                <h3>No signed petitions yet.</h3>
            </div>
        </div>
    </c:otherwise>
    </c:choose>
</div>


<div id="createdPetitions" class="row g-3" style="display:none; max-height: 40rem;  justify-items: center" class = "row g-3 mt-3">
    <c:choose>
        <c:when test="${userCreatedPetitions.size() > 0}">
            <c:forEach items="${userCreatedPetitions}" var="petition" varStatus="itr">
            <div class="col-lg-6 col-sm-12">
                <div class="card shadow-sm h-100">
                    <c:if test="${petition.status.equals('open')}">
                        <h5 class="card-header bg-success text-white">Open</h5>
                    </c:if>
                    <c:if test="${petition.status.equals('closed')}">
                        <h5 class="card-header bg-secondary text-white">Closed</h5>
                    </c:if>
                    <div class="card-body">
                        <h5 class="card-title">${petition.title}</h5>
                        <p class="card-text">${petition.content}</p>
                        <p class="card-text">Signature count: ${petition.signatureCount}</p>
                        <c:if test="${empty petition.response}">
                            <p class="card-text">Response received: No</p>
                        </c:if>
                        <c:if test="${!empty petition.response}">
                            <p class="card-text">Response received: Yes</p>
                        </c:if>
                        <a href="/petition/${petition.petitionID}" class="btn btn-outline-info w-100">View</a>
                    </div>
                </div>
            </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="d-flex align-items-center justify-content-center" style="height: 15rem;">
                <div class="text-center">
                    <h3>You have not created any petitions yet.</h3>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>


<script>

    function displayUnsignedPetitions(){
        if ($("#unsignedPetitions").css("display") == "none") {
            $("#unsignedPetitions").css("display", "block");
            $("#signedPetitions").css("display", "none");
            $("#createdPetitions").css("display", "none");
            $("#unsignedPetitionNav").addClass("active");
            $("#signedPetitionNav").removeClass("active");
            $("#createdPetitionNav").removeClass("active");
        }
    }

    function displaySignedPetitions(){
        if ($("#signedPetitions").css("display") == "none") {
            $("#signedPetitions").css("display", "block");
            $("#unsignedPetitions").css("display", "none");
            $("#createdPetitions").css("display", "none");
            $("#signedPetitionNav").addClass("active");
            $("#unsignedPetitionNav").removeClass("active");
            $("#createdPetitionNav").removeClass("active");
        }
    }

    function displayCreatedPetitions(){
        if ($("#createdPetitions").css("display") == "none") {
            $("#createdPetitions").css("display", "block");
            $("#signedPetitions").css("display", "none");
            $("#unsignedPetitions").css("display", "none");
            $("#createdPetitionNav").addClass("active");
            $("#signedPetitionNav").removeClass("active");
            $("#unsignedPetitionNav").removeClass("active");
        }
    }
</script>


</html>