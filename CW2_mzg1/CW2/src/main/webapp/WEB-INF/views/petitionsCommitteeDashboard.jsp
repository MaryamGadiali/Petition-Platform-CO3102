<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <title>Petitions Committee Dashboard</title>
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
<%--Model attribute is signatureThreshold and allPetitions--%>
<div class="container mt-4" style="justify-items: center">
    <h1 class="text-center mb-4">Petitions Committee Dashboard</h1>
<!-- Signature threshold section -->
    <div class="card mb-4 col-lg-6 col-sm-12" style="max-width: fit-content">
        <div class="card-body" >
            <h5 class="card-title">Signature Threshold</h5>
            <div class="row align-items-center">
                <div class="col-auto">
                    <input type="text" id="signatureThreshold" name="signatureThreshold" value="${signatureThreshold}"
                           class="form-control form-control-sm" disabled>
                </div>
                <div class="mt-3">
                    <button id="editButton" class="btn btn-sm btn-primary" onclick="editSignatureThreshold()">Edit</button>
                    <button id="saveButton" class="btn btn-sm btn-success" onclick="saveSignatureThreshold()" style="display: none;">Save</button>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Nav tabs -->
<ul class="nav nav-tabs justify-content-center mb-3">
    <li class="nav-item">
        <a class="nav-link active" id="statisticsNav" onclick="showStatistics()" style="cursor: pointer;">Statistics</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="overThresholdNav" onclick="displayOverThresholdPetitions()" style="cursor: pointer;">Over Threshold Petitions</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="allPetitionNav" onclick="displayAllPetitions()" style="cursor: pointer;">All Petitions</a>
    </li>
</ul>


<!-- Over Threshold petitions section -->
<div id="overThresholdPetitions" style="display:none; max-height: 40rem;  justify-items: center" class = "row g-3 mt-3">
<c:choose>
    <c:when test="${allPetitions.size() > 0}">
        <c:set var="hasOverThresholdPetitions" value="false" />
        <c:forEach items="${allPetitions}" var="petition" varStatus="itr">
            <c:if test="${petition.signatureCount >= petition.signatureThreshold}">
                <c:set var="hasOverThresholdPetitions" value="true" />
                <div class="col-lg-6 col-sm-12" >
                <div class="card shadow-sm h-100">
                    <c:if test="${petition.status.equals('open')}">
                    <div class="card-header bg-success text-white">Open</div>
                    </c:if>
                    <c:if test="${petition.status.equals('closed')}">
                    <div class="card-header bg-secondary text-white">Closed</div>
                    </c:if>
                <div class="card-body">
                <h5 class="card-title">${petition.title}</h5>
                <p class="card-text">${petition.content}</p>
                <p class="card-text">Signature count: ${petition.signatureCount}</p>
                <a href="/admin/petition/${petition.petitionID}" class="btn btn-outline-primary">View</a>
                </div>
                </div>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${!hasOverThresholdPetitions}">
            <div class="alert alert-warning text-center" role="alert">
            There are no over threshold petitions to display at this time.
            </div>
        </c:if>
    </c:when>
    <c:otherwise>
        <div class="alert alert-warning text-center" role="alert">
        There are no over threshold petitions to display at this time.
        </div>
    </c:otherwise>
</c:choose>
</div>

<!--All petitions-->
<div id="allPetitions" style="display:none; max-height: 40rem;  justify-items: center" class = "row g-3 mt-3">
<c:choose>
    <c:when test="${allPetitions.size() > 0}">
        <c:forEach items="${allPetitions}" var="petition" varStatus="itr">
        <div class="col-lg-6 col-sm-12" >
        <div class="card shadow-sm h-100">
                <c:if test="${petition.status.equals('open')}">
                <div class="card-header bg-success text-white">Open</div>
                </c:if>
                <c:if test="${petition.status.equals('closed')}">
                <div class="card-header bg-secondary text-white">Closed</div>
                </c:if>

            <div class="card-body">
            <h5 class="card-title">${petition.title}</h5>
            <p class="card-text">${petition.content}</p>
            <p class="card-text">Signature count: ${petition.signatureCount}</p>
            <a href="petition/${petition.petitionID}" class="btn btn-outline-secondary">View</a>
            </div>
            </div>
        </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="alert alert-warning text-center" role="alert">
        No petitions to show.
        </div>
    </c:otherwise>
</c:choose>
</div>

<!--Statistics-->
<div id="statistics" style="display:block; max-height: 40rem;  justify-items: center" class = "row g-3 mt-3">
    <div class="row">
        <div class="col-md-6 mb-4">
            <canvas id="topPetitionsBySignatures" style="width:100%;max-width:700px"></canvas>
        </div>
        <div class="col-md-6 mb-4">
            <canvas id="cumulativeGrowthOfPetitions" style="width:100%;max-width:700px"></canvas>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <canvas id="openPetitionStatus" style="width:100%;max-width:700px"></canvas>
        </div>
    </div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>

<script>

    function editSignatureThreshold(){
        $("#signatureThreshold").prop("disabled", false);
        $("#editButton").hide();
        $("#saveButton").show();
    }

    function saveSignatureThreshold(){
        const newSignatureThreshold = $("#signatureThreshold").val();
        $.ajax({
            url: "/admin/updateSignatureThresholdValue",
            type: "POST",
            data: {
                newSignatureThreshold: newSignatureThreshold
            },
            success: function(response){
                console.log("Response is "+response);
                if(response == "Success"){
                    $("#signatureThreshold").prop("disabled", true);
                    $("#editButton").show();
                    $("#saveButton").hide();
                    location.reload();
                }
            }
        })
    }

    function displayOverThresholdPetitions(){
        if ($("#overThresholdPetitions").css("display") == "none") {
            $("#overThresholdPetitions").css("display", "block");
            $("#allPetitions").css("display", "none");
            $("#statistics").css("display", "none");
            $("#overThresholdNav").addClass("active");
            $("#allPetitionNav").removeClass("active");
            $("#statisticsNav").removeClass("active");
        }
    }

    function displayAllPetitions(){
        if ($("#allPetitions").css("display", "none")) {
            $("#allPetitions").css("display", "block");
            $("#overThresholdPetitions").css("display", "none");
            $("#statistics").css("display", "none");
            $("#allPetitionNav").addClass("active");
            $("#overThresholdNav").removeClass("active");
            $("#statisticsNav").removeClass("active");
        }
    }

    function showStatistics(){
        if ($("#statistics").css("display") == "none") {
            $("#statistics").css("display", "block");
            $("#overThresholdPetitions").css("display", "none");
            $("#allPetitions").css("display", "none");
            $("#statisticsNav").addClass("active");
            $("#overThresholdNav").removeClass("active");
            $("#allPetitionNav").removeClass("active");
        }
    }


    //Statistics

    //top5OpenPetitions
    var yValues = [];
    var xValues = [];
    <c:forEach items="${top5OpenPetitions}" var="petition">
    yValues.push("${petition.title}");
    xValues.push(${petition.signatureCount});
    </c:forEach>

    var barColors = ["#4e73df", "#1cc88a", "#36b9cc", "#f6c23e", "#e74a3b"];
    new Chart("topPetitionsBySignatures", {
        type: "horizontalBar",
        data: {
            labels: yValues,
            datasets: [{
                backgroundColor: barColors,
                data: xValues
            }]
        },
        options: {
            legend: {display: false},
            title: {
                display: true,
                text: "Top 5 open petitions"
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Signature Count'
                    }
                }],
            }
        }
    });


    //CumulativeGrowthOfPetitions
    var yValues = [];
    var xValues = [];
    <c:forEach items="${allPetitions}" var="petition">
    yValues.push((yValues.length > 0 ? yValues[yValues.length - 1] : 0) + ${petition.signatureCount});
    xValues.push("${petition.petitionID}");
    </c:forEach>
    new Chart("cumulativeGrowthOfPetitions", {
        type: "line",
        data: {
            labels: xValues,
            datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "rgba(0,0,255,1.0)",
                borderColor: "rgba(0,0,255,0.1)",
                data: yValues
            }]
        },
        options: {
            title: {
                display: true,
                text: "Signature participation over time"
            },
            legend: {display: false},
            scales: {
                xAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Petition ID'
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Cumulative Signatures'
                    }
                }]
            }
        }
    });

    //openPetitionStatus
    var xValues = ["Over Threshold", "Under Threshold"];
    var yValues = ["${openPetitionsAboveThreshold}", "${openPetitionsBelowThreshold}"];
    new Chart("openPetitionStatus", {
        type: "pie",
        data: {
            labels: xValues,
            datasets: [{
                backgroundColor: barColors,
                data: yValues
            }]
        },
        options: {
            title: {
                display: true,
                text: "Status of open petitions"
            }
        }
    });

</script>
</html>
