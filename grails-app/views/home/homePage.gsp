<!doctype html>
<html lang="en">
<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing</title>
    <style>
    /*.divider:after,*/
    /*.divider:before {*/
    /*    content: "";*/
    /*    flex: 1;*/
    /*    height: 2px;*/
    /*    background: #eee;*/
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<g:render template="/_templates/navbar"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center  h-100"><!-- align-items-center -->
        <div class="col-md-6 col-lg-7 col-xl-7">
            <div class="card mt-5 mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body">
                    <h4 class="card-title mb-4">Recent shares</h4>
                    <g:each in="${recentSharesList}">
                        <div class="card mb-3" style="border-radius: 15px;">
                            <div class="card-body p-2 row align-items-center">
                                <div class="col-auto">
                                    <a href="/user/profile?user=${it.createdBy.username}"><img
                                            src="${assetPath(src: "${it?.createdBy?.photo}")}" width="95px"
                                            height="95px"/></a>
                                </div>

                                <div class="col">
                                    <div class="row d-flex">
                                        <div class="col col-auto">
                                            <h5 class="">${it?.createdBy?.firstName} ${it?.createdBy?.lastName}</h5>
                                        </div>

                                        <div class="col col-auto">
                                            <p class="text-muted">@${it?.createdBy?.username}</p>
                                        </div>

                                        <div class="col d-flex">
                                            <div class="ml-auto mr-5"><a class="justify-content-end"
                                                                         href="/topic/showTopic?id=${it?.topic?.id}">${it?.topic?.name}</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col">
                                            <p>
                                                ${it?.description?.take(150)}
                                            </p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col col-auto mr-auto">
                                            <a class="mr-2" href="https://facebook.com">
                                                <img src="${assetPath(src: 'icons/facebook-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                            <a class="mr-2" href="https://twitter.com">
                                                <img src="${assetPath(src: 'icons/twitter-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                            <a href="https://google.com">
                                                <img src="${assetPath(src: 'icons/google-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                        </div>

                                        <div class="col d-flex">
                                            <div class="ml-auto mr-3"><a class="justify-content-end"
                                                                         href="/resource/viewPublicPost?id=${it?.id}">View
                                                post</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

            <div class="card mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body">
                    <h4 class="card-title mb-4">Top posts</h4>

                    <g:each in="${topPostsList}" var="obj">
                        <div class="card mb-3" style="border-radius: 15px;">
                            <div class="card-body p-2 row align-items-center">
                                <div class="col-auto">
                                    <a href="/user/profile?user=${obj[1].createdBy.username}"><img
                                            src="${assetPath(src: "${obj[1]?.createdBy?.photo}")}" width="95px"
                                            height="95px"/></a>
                                </div>

                                <div class="col">
                                    <div class="row d-flex">
                                        <div class="col col-auto">
                                            <h5 class="">${obj[1]?.createdBy?.firstName} ${obj[1]?.createdBy?.lastName}</h5>
                                        </div>

                                        <div class="col col-auto">
                                            <p class="text-muted">@${obj[1]?.createdBy?.username}</p>
                                        </div>

                                        <div class="col d-flex">
                                            <div class="ml-auto mr-5"><a class="justify-content-end"
                                                                         href="/topic/showTopic?id=${obj[1].topic.id}">${obj[1].topic.name}</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col">
                                            <p>
                                                ${obj[1]?.description?.take(150)}
                                            </p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col col-auto mr-auto">
                                            <a class="mr-2" href="https://facebook.com">
                                                <img src="${assetPath(src: 'icons/facebook-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                            <a class="mr-2" href="https://twitter.com">
                                                <img src="${assetPath(src: 'icons/twitter-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                            <a href="https://google.com">
                                                <img src="${assetPath(src: 'icons/google-logo.png')}" height="20px"
                                                     width="20px" alt="facebook">
                                            </a>
                                        </div>

                                        <div class="col d-flex">
                                            <div class="ml-auto mr-3"><a class="justify-content-end"
                                                                         href="/resource/viewPublicPost?id=${obj[1]?.id}">View
                                                post</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

        </div>

        <div class="col-md-8 col-lg-4 col-xl-4 ml-5">
            <div class="card mt-5 mb-4 bg-light" style="border-radius: 15px;">
                <div class="card-body">
                    <h4 class="card-title my">Sign In</h4>
                    <g:form controller="User" action="authenticateUser" method="post">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="signInUsername">Email or Username</label>
                            <g:field type="text" id="signInUsername" value="${user?.username}" name="signInUsername"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-2">
                            <label class="form-label" for="signInPass">Password</label>
                            <g:field type="password" id="signInPass" name="signInPass"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-4">
                            <div class="form-check mb-0">
                                <button type="button" class="btn btn-link" data-toggle="modal"
                                        data-target="#modalForgotPassword">Forgot password?</button>
                            </div>
                            <button type="submit" class="btn btn-outline-primary"
                                    style="padding: 0.7rem 1.7rem 0.7rem 1.7rem;">Sign In</button>
                        </div>
                    </g:form>
                </div>
            </div>

            <!--  ==================================================================== -->
            %{--            <div class="divider d-flex align-items-center my-4">--}%
            %{--                <p class="text-center fw-bold mx-3 mb-0">OR</p>--}%
            %{--            </div>--}%
            <!--  ==================================================================== -->

            <div class="card mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body">
                    <h4 class="card-title">Sign Up</h4>
                    <g:uploadForm controller="User" action="registerUser" method="POST" id="signUpForm">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="firstName">First name</label>
                            <g:field type="text" name="firstName" id="firstName" value="${newUser?.firstName}"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="lastName">Last name</label>
                            <g:field type="text" name="lastName" id="lastName" value="${newUser?.lastName}"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="email">Email</label>
                            <g:field type="email" name="email" id="email" value="${newUser?.email}"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="username">Username</label>
                            <g:field type="text" name="username" id="username" value="${newUser?.username}"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-3 ">
                            <label class="form-label" for="password">Password</label>
                            <g:field type="password" name="password" id="password"
                                     class="form-control form-control-md" required="true" maxlength="254"/>
                        </div>

                        <div class="form-outline mb-2">
                            <label class="form-label" for="cnfPassword">Confirm Password</label>
                            <span id="pswdText" class="text-danger d-none">Password does not match</span>
                            <g:field type="password" onkeyup="checkPass()" class="form-control" id="cnfPassword"
                                     name="cnfPassword" required="true" maxlength="254"></g:field>
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="photo">Photo</label>
                            <g:field type="file" name="photo" id="photo" class="form-control" accept=".jpg, .jpeg, .png"/>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-4">
                            <div>
                            </div>

                            <button type="submit" id="btnSubmit" onclick="return validateFile();" class="btn btn-outline-primary"
                                    style="padding: 0.7rem 1.7rem 0.7rem 1.7rem;">Sign Up</button>
                        </div>
                    </g:uploadForm>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalForgotPassword" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Forgot Password</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body" id="forgotPasswordModalBody">
                <div class="form-outline mb-3" id="oneEmail">
                    <label class="form-label" for="forgotPasswordEmail">Email/Username</label>
                    <g:field type="text" id="forgotPasswordEmail" name="forgotPasswordEmail"
                             class="form-control form-control-md" maxlength="254"/>
                </div>

                <div class="form-outline mb-3 d-none" id="twoKey">
                    <label class="form-label" for="forgotPasswordKey">Enter key sent on your registered email</label>
                    <input type="password" id="forgotPasswordKey" name="forgotPasswordKey"
                           class="form-control form-control-md" required maxlength="254">
                </div>

                <div class="form-outline mb-3 d-none" id="twoPass">
                    <label class="form-label" for="forgotPasswordNewPass">New Password</label>
                    <input type="password" id="forgotPasswordNewPass" name="forgotPasswordNewPass"
                           class="form-control form-control-md" required maxlength="254">
                </div>

                <div class="modal-footer" id="oneButtons">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" onclick="forgotPassword()" class="btn btn-primary">Next</button>
                </div>

                <div class="modal-footer d-none" id="twoButtons">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" onclick="setNewPassword()" class="btn btn-primary">Reset Password</button>
                </div>
            </div>
        </div>
    </div>
</div>
<asset:javascript src="homePageJS"/>
</body>
</html>