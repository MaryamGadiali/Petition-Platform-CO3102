<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://unpkg.com/html5-qrcode"></script>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="d-flex flex-column justify-content-center align-items-center vh-100" style="background: #EEEEEE;" >
<h1 class="mb-4 p-3" >Shangri-La Petition Platform</h1>
<div class="card shadow p-4 mb-2 " style= "width: 100%; max-width: 30rem; height: 100%; max-height: 30rem">
    <h2 class="text-center mb-4">Register</h2>
<form:form action="/register" method="post" autocomplete="off" class="overflow-y-scroll" modelAttribute="user">

        <div class="mb-3">
        <form:label class="form-label" path="userEmail">Email:</form:label>
        <form:input path="userEmail" id="userEmail" type="email" class="form-control" placeholder="Enter email" onkeyup="userEmailCheck()" onchange="userEmailCheck()" required="true"/>
            <div class="alert alert-danger" id="userEmailError" style="display: none" role="alert"> </div>
        </div>

        <div class="mb-3">
        <form:label class="form-label" path="fullname">Full Name:</form:label>
        <form:input path="fullname" id="fullname" type="text" class="form-control" placeholder="Enter your full name" required="true"/>
        <form:errors path="fullname" cssClass="error"/>
        </div>

        <div class="mb-3">
        <form:label class="form-label" path="dateOfBirth">Date of Birth:</form:label>
        <form:input path="dateOfBirth" id="dateOfBirth" type="date" class="form-control" required="true"/>
        </div>

        <div class="mb-3">
        <form:label class="form-label" path="passwordHash">Password:</form:label>
        <form:input path="passwordHash" id="passwordHash" type="password" class="form-control" placeholder="Enter a secure password" required="true"/>
        <form:errors path="passwordHash" cssClass="error"/>
        </div>

        <div class="mb-3">
        <form:label class="form-label" path="bioID">Bio ID:</form:label>
        <form:input path="bioID" id="bioID" type="text" class="form-control" onkeyup="checkBioID()" onchange="checkBioID()" placeholder="Enter your BioID or scan your BioID QR Code below" required="true"/>
            <div class="alert alert-danger" id="errorBioIDMessage" style="display: none" role="alert"> </div>
            <div class="alert alert-success" id="successBioIDMessage" style="display: none" role="alert">
                Valid BioID
            </div>
        </div>

    <%--QR code section--%>
    <div class="mb-3">
        <label id="bioIDInstr">Scan the BioID QrCode</label>
        <div id="bioIdQRScanner"></div>
    </div>
    <button id="submit" type="submit" class="btn btn-primary" disabled>Register</button>
    <p class="mt-2 mb-4 text-muted">After successful registration, you will be redirected to the login page</p>
</form:form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
<script>
    $(document).ready(function () {
    });

    $('#userEmail, #bioID, #bioIdQRScanner' ).on('keyup change focus input', function () {
        checkForm();
    });

    function checkBioID() {
        $.ajax({
            url: "/checkBioID",
            type: "POST",
            data: {
                bioIDCode: $('#bioID').val()
            },
            success: function (response) {
                if (response == "Valid") {
                    $('#errorBioIDMessage').text("").hide();
                    $('#successBioIDMessage').text("Valid BioID").show();
                    $('#bioIDInstr').hide();
                    html5QrcodeScanner.clear();
                    checkForm();
                } else if (response == "BioID already used") {
                    $('#errorBioIDMessage').text("BioID already used").show();
                    checkForm();
                    $('#successBioIDMessage').text("").hide();
                    html5QrcodeScanner.clear().then(_ => {
                        html5QrcodeScanner.render(onScanSuccess);
                    }).catch(error => {
                        console.error("Failed to clear the scanner. Error: ", error);
                    });
                } else if (response == "No match") {
                    $('#errorBioIDMessage').text("BioID does not exist").show();
                    $('#successBioIDMessage').text("").hide();
                    checkForm();
                    html5QrcodeScanner.clear().then(_ => {
                        html5QrcodeScanner.render(onScanSuccess);
                    }).catch(error => {
                        console.error("Failed to clear the scanner. Error: ", error);
                    });
                }
            },
        })
    }


    //QR code section
    function onScanSuccess(decodeText, decodeResult) {
        $('#bioID').val(decodeText);
        checkBioID();
    }

    function onScanError(errorMessage) {
        alert("Something went wrong. The error message is "+errorMessage);
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "bioIdQRScanner",
        { fps: 10, qrbox: 250 }
    );
    html5QrcodeScanner.render(onScanSuccess);




    //If all elements with alert-danger class have no text, then allow form submission
    $('.alert-danger').change(function(){
        if ($('.alert-danger').text() == ""){
            $('#submit').prop('disabled', false);
        }
    });


    function checkForm(){
        if (($('#userEmailError').text() == "") && ($('#errorBioIDMessage').text() == "")){
            $('#submit').prop('disabled', false);
        }
        else{
            $('#submit').prop('disabled', true);
        }
    }

    //dynamic ajax check on checkEmail endpoint
    function userEmailCheck(){
        $.ajax({
            url: "/checkEmail",
            type: "POST",
            data: {
                email: $('#userEmail').val()
            },
            success: function (response) {
                if (response == "Email already in use") {
                    $('#userEmailError').show();
                    $('#userEmailError').text("Email already used");
                    checkForm();

                } else if (response == "No match") {
                    $('#userEmailError').text("").hide();
                    checkForm();
                }
            },
        })
    }

</script>


</html>


