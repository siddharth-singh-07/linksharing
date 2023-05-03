<!doctype html>
<html lang="en">
<head>
    <meta name="layout" content="mymain">
    <style>
    .divider:after,
    .divider:before {
        content: "";
        flex: 1;
        height: 2px;
        background: #eee;
    }
    </style>
    <title>Link Sharing</title>
</head>

<body>
    <g:render template="/_templates/navbar"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center  h-100"> <!-- align-items-center -->
        <div class="col-md-6 col-lg-7 col-xl-7">
            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h3 class="card-title mb-4">Recent shares</h3>
                </div>
            </div>

            <div class="card mb-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h3 class="card-title mb-4">Top posts</h3>
                </div>
            </div>

        </div>
        <div class="col-md-8 col-lg-4 col-xl-4 ml-5">
            <div class="card mt-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h3 class="card-title mb-4">Sign In</h3>
                    <g:form controller="User" action="authenticateUser" method="post">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="signInUsername">Email or Username</label>
                            <g:field type="text" id="signInUsername" name="signInUsername" class="form-control form-control-md" required="true" />
                        </div>
                        <div class="form-outline mb-2">
                            <label class="form-label" for="signInPass">Password</label>
                            <g:field type="password" id="signInPass" name="signInPass" class="form-control form-control-md" required="true" />
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-4">
                            <div class="form-check mb-0">
                                <a href="#" class="text-body">Forgot password?</a>
                            </div>
                            <button type="submit" class="btn btn-outline-primary"
                                    style="padding: 0.7rem 1.7rem 0.7rem 1.7rem;">Sign In</button>
                        </div>
                    </g:form>

                </div>
            </div>

            <!--  ==================================================================== -->
            <div class="divider d-flex align-items-center my-4">
                <p class="text-center fw-bold mx-3 mb-0">OR</p>
            </div>
            <!--  ==================================================================== -->

            <div class="card mb-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h3 class="card-title mb-4">Sign Up</h3>
                    <g:form controller="User" action="registerUser" method="POST">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="firstName">First name</label>
                            <g:field type="text" name="firstName" id="firstName" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label" for="lastName">Last name</label>
                            <g:field type="text" name="lastName" id="lastName" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label" for="email">Email</label>
                            <g:field type="email" name="email" id="email" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label" for="username">Username</label>
                            <g:field type="text" name="username" id="username" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label" for="password">Password</label>
                            <g:field type="password" name="password" id="password" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-2">
                            <label class="form-label" for="passwordRe">Confirm Password</label>
                            <g:field type="password" name="passwordRe" id="passwordRe" class="form-control form-control-md" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label" for="photo">Photo</label>
                            <g:field type="file" name="photo" id="photo" class="form-control" />
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-4">
                            <div>
                            </div>
                            <!-- <button type="button" class="btn btn-outline-primary btn-lg"
                                    style="padding-left: 2.5rem; padding-right: 2.5rem;">SignUp</button> -->

                            <button type="submit" class="btn btn-outline-primary"
                                    style="padding: 0.7rem 1.7rem 0.7rem 1.7rem;">Sign Up</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>