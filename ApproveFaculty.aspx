<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveFaculty.aspx.cs" Inherits="MOOCs.ApproveFaculty" %>

<!DOCTYPE html>
<html>
<head>
    <title>Waiting for Approval</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">

<div class="card shadow p-4 text-center" style="max-width:420px;">
    <h4 class="text-warning">
        <i class="fa fa-hourglass-half"></i> Approval Pending
    </h4>
    <p class="mt-3">
        Your faculty account is still under review.<br />
        Please wait for the administrator to approve your account.
    </p>

    <a href="Login.aspx" class="btn btn-primary mt-3">Back to Login</a>
</div>

</body>
</html>