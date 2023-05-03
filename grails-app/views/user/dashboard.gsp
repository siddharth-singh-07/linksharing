<!doctype html>
<html lang="en">

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Dashboard</title>
</head>

<body>
<g:render template="/_templates/navbar" />
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center  h-100"> <!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">
            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-2">
                    <div class="row">
                        <div class="col-sm-4 col-xl-3 col-lg-4 mr-2">
                            <img src="${assetPath(src: 'icons/user.png')}" alt="User" width="100px"/>
                        </div>
                        <div class="col-sm-8 col-xl-8 col-lg-8">
                            <div class="row">
                                <h3 class="" style="line-height:1em; padding-left: 15px;">Test User</h3>
                            </div>
                            <div class="row">
                                <p class="mt-0 text-muted" style="line-height: 0.5em; padding-left: 15px;"> @user</p>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-xl-6 col-lg-6">
                                    <p class="m-0 text-muted">Subscriptions</p>
                                </div>
                                <div class="col-sm-6 col-xl-6 col-lg-6">
                                    <p class="m-0 text-muted">Topics</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-xl-6 col-lg-6">
                                    <p class="m-0">0</p>
                                </div>
                                <div class="col-sm-6 col-xl-6 col-lg-6">
                                    <p class="m-0">0</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mb-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h5 class="card-title mb-4">Subscriptions</h5>
                </div>
            </div>
            <div class="card mb-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h5 class="card-title mb-4">Trending Topics</h5>
                </div>
            </div>
        </div>
        <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
            <div class="card mt-5" style="border-radius: 15px;">
                <div class="card-body">
                    <h5 class="card-title mb-4">Inbox</h5>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>