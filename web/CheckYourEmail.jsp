<!DOCTYPE html>
<html lang="en">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="assets/css/login.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&family=Montserrat:wght@400;500;600;700;800;900&display=swap');
        </style>
        <title>Check your mail</title>
</head>

<body>
    <div class="d-flex justify-content-center vh-100 align-items-center">
        <div style="width: 300px;height: 400px; margin-bottom: 200px;">
            <div class="d-flex justify-content-center">
                <i class="fa-regular fa-envelope my-3" style="padding: 14px; background-color: rgb(201, 242, 197); color: rgb(38, 245, 20); border-radius: 30px; font-size: 24px;"></i>
            </div>
            <h3 class="text-center mb-3">Check your email</h3>
            <p style="font-size: 14px; color: rgba(0, 0, 0, 0.6)" class="text-center my-3">We send a password reset link to your email<span style="color:rgba(0, 0, 0, 0.8); font-weight: 500;"></span></p>
            <a href="https://mail.google.com/mail/"><button class="btn btn-info w-100 mb-4" style="font-size: 14px; color: white; font-weight: 500; background-color: #51be78; border: #7f55da;">Open email web</button></a>
            <p class="text-center" style="color:rgba(0, 0, 0, 0.5); font-size: 14px; font-weight: 500;">
                <i class="fa-solid fa-arrow-left me-2"></i>
                <a href="login.jsp" style="text-decoration: none; color: rgba(0, 0, 0, 0.5); font-weight: 500;">Back to log in</a>
            </p>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>

</html>