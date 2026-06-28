<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User dashboard.aspx.cs" Inherits="MOOCs.User_dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        .bg-light {
            flex: 1;
            width: 100%;
        }
        .profile-sidebar {
            background-color: #001f54;
        }
        .nav-pills .nav-link {
            color: #fff;
            border-radius: 10px;
            padding: 12px 20px;
            margin: 4px 0;
            transition: all 0.3s ease;
        }
        .nav-pills .nav-link:hover {
            background-color: rgba(255,255,255,0.2);
        }
        .nav-pills .nav-link.active {
            background-color: #fff;
            color: #4158D0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-header {
            background-color: #001f54;
            height: 200px;
            border-radius: 15px;
        }
        .profile-pic {
            width: 120px;
            height: 120px;
            border: 4px solid #fff;
            margin-top: -60px;
            background-color: #fff;
        }
        .activity-item {
            border-left: 2px solid #e9ecef;
            padding-left: 20px;
            position: relative;
        }
        .activity-item::before {
            content: '';
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #4158D0;
            position: absolute;
            left: -7px;
            top: 5px;
        }
        @media (max-width: 991px) {
            .profile-header {
                height: 150px;
            }
            .profile-pic {
                width: 100px;
                height: 100px;
                margin-top: -50px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data" class="h-100">
        <div class="bg-light min-vh-100">
            <div class="container-fluid py-5">
                <div class="row">
                    <!-- Profile Header -->
                    <div class="col-12 mb-4 text-center">
                        <div class="profile-header position-relative mb-4">
                            <div class="position-absolute top-0 end-0 p-3">
                                <asp:Button ID="btnEditCover" runat="server" Text="Edit Cover" CssClass="btn btn-light" />
                            </div>
                        </div>

                        <!-- Profile Picture Upload -->
                        <div class="position-relative d-inline-block">
                            <asp:Image ID="imgProfilePic" runat="server" CssClass="rounded-circle profile-pic mb-2" />
                            <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="d-none"
                                onchange="document.getElementById('<%= btnHiddenUpload.ClientID %>').click();" />
                            <button type="button" class="btn btn-primary btn-sm position-absolute bottom-0 end-0 rounded-circle"
                                onclick="document.getElementById('<%= fuProfilePic.ClientID %>').click();">📷</button>
                            <asp:Button ID="btnHiddenUpload" runat="server" CssClass="d-none" OnClick="btnUploadPic_Click" />
                        </div>

                        <asp:Label ID="lblUploadMessage" runat="server" CssClass="text-success d-block mt-2"></asp:Label>
                        <h3 class="mt-3 mb-1"><asp:Label ID="lblFullName" runat="server" Text="Your Name"></asp:Label></h3>
                        <p class="text-muted mb-3"><asp:Label ID="lblRole" runat="server" Text="Your Role"></asp:Label></p>
                    </div>

                    <!-- Main Content -->
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <!-- Sidebar -->
                                    <div class="col-lg-3 border-end mb-4 mb-lg-0">
                                        <div class="p-4 profile-sidebar h-100">
                                            <div class="nav flex-column nav-pills" id="profileTabs" role="tablist">
                                              <a class="nav-link active" data-bs-toggle="pill" href="#personalInfo" role="tab">
                                                 <i class="fas fa-user me-2"></i> Personal Info </a>
                                              <a class="nav-link" data-bs-toggle="pill" href="#courses" role="tab">
                                                 <i class="fas fa-lock me-2"></i> Courses </a>
                                              <a class="nav-link" data-bs-toggle="pill" href="#modules" role="tab">
                                                 <i class="fas fa-bell me-2"></i> Module </a>
                                              <a class="nav-link" data-bs-toggle="pill" href="#certificates" role="tab">
                                                 <i class="fas fa-credit-card me-2"></i> Certificate </a>
                                              <a class="nav-link" data-bs-toggle="pill" href="#activity" role="tab">
                                                 <i class="fas fa-chart-line me-2"></i> Activity  </a>
                                             <a class="nav-link mt-3 text-danger" href="login.aspx">
                                                 <i class="fas fa-sign-out-alt me-2"></i> Logout
                                              </a>

                                    </div>
                                        </div>
                                    </div>

                                    <!-- Tab Content -->
                                    <div class="col-lg-9">
                                        <div class="tab-content p-4" id="profileTabContent">
                                            <!-- Personal Info -->
                                            <div class="tab-pane fade show active" id="personalInfo" role="tabpanel">
                                                <h4>Personal Information</h4>
                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <label class="form-label">First Name</label>
                                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Last Name</label>
                                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Email</label>
                                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Phone</label>
                                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label">Bio</label>
                                                        <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="mt-3">
                                                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save Changes" OnClick="btnSave_Click" />
                                                    <asp:Label ID="lblMessage" runat="server" CssClass="text-success ms-3"></asp:Label>
                                                </div>
                                            </div>

                                            <!-- Courses -->
                                            <div class="tab-pane fade" id="courses" role="tabpanel">
                                                <h4>Courses</h4>
                                                <p>Show user courses here...</p>
                                            </div>

                                            <!-- Modules -->
                                            <div class="tab-pane fade" id="modules" role="tabpanel">
                                                <h4>Modules</h4>
                                                <p>Show enrolled modules here...</p>
                                            </div>

                                            <!-- Certificates -->
                                            <div class="tab-pane fade" id="certificates" role="tabpanel">
                                                <h4>Certificates</h4>
                                                <p>Show user certificates here...</p>
                                            </div>

                                            <!-- Activity -->
                                            <div class="tab-pane fade" id="activity" role="tabpanel">
                                                <h4>Activity</h4>
                                                <div class="activity-item mb-3">
                                                    <h6 class="mb-1">Updated profile</h6>
                                                    <p class="text-muted small mb-0">Just now</p>
                                                </div>
                                                <div class="activity-item">
                                                    <h6 class="mb-1">Changed password</h6>
                                                    <p class="text-muted small mb-0">Yesterday</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- End Tab Content -->
                                </div>
                            </div>
                        </div>
                    </div><!-- End Main -->
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>