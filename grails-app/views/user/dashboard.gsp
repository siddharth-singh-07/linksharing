<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>
<%def count = 0%>

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Dashboard</title>
</head>

<body>
<g:render template="/_templates/navbar" />
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center h-100"> <!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">
        <div class="card mt-5 mb-5" style="border-radius: 15px;">
            <div class="card-body p-2">
                <div class="row align-items-center">
                    <div class="col-sm-4 col-xl-3 col-lg-4 mr-2 mt-1">
                        <img src="${assetPath(src: "${session.user?.photo}")}" alt="User" width="95px" height="95px"/>
                    </div>
                    <div class="col-sm-8 col-xl-8 col-lg-8">
                        <div class="row">
                            <div class="col pl-0">
                                <h3 class="" style="line-height:1em; padding-left: 15px;">${session.user?.firstName} ${session.user?.lastName}</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col pl-0">
                                <p class="mt-0 text-muted" style="line-height: 0.5em; padding-left: 15px;">@${session.user?.username}</p>
                            </div>
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
                                <p class="m-0">${userSubscriptionsList.size()}</p>
                            </div>
                            <div class="col-sm-6 col-xl-6 col-lg-6">
                                <p class="m-0">${userTopicsList.size()}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="card mt-5 mb-5" style="border-radius: 15px;">
            <h5 class="card-title m-2">Subscriptions</h5>

            <g:each in="${userSubscriptionsList}" var="topicObj">
                <g:if test="${topicObj.resource && count<5}">
                    <% count++ %>
                    <div class="card-body p-2 ">
                        <div class="row">
                            <div class="col col-auto">
                                <img src="${assetPath(src: "${topicObj.createdBy.photo}")}" width="70px" height="70px" />
                            </div>
                            <div class="col">
                                <div class="row">
                                    <div class="col pl-0">
                                        <span id="topicDisplay_${topicObj.id}">${topicObj.name}</span>
                                        <div id="topicField_${topicObj.id}" class="d-none">
                                            <span id="error_${topicObj.id}" class="text-danger small mt-2 d-none"></span>
                                            <div class="form-outline d-flex align-items-center">
                                                <input type="text" class="form-control form-control-sm mr-2" id="topicInput_${topicObj.id}" value="${topicObj.name}">
                                                <button onclick="cancelEdit('${topicObj.id}')" class="btn btn-secondary btn-sm mr-2">Cancel</button>
                                                <button onclick="saveEditTopic('${topicObj.id}')" class="btn btn-primary btn-sm mr-2">Save</button>
                                            </div>
                                        </div>
                                        <span id="success_${topicObj.id}" class="text-success small mt-2 d-none">Success</span>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col pl-0">
                                        <a  class="text-muted" href="#">@${topicObj.createdBy.username}</a>
                                    </div>
                                    <div class="col pl-0">
                                        <a class="text-muted" href="#">Subscriptions</a>
                                    </div>
                                    <div class="col pl-0">
                                        <a class="text-muted" href="#">Posts</a>
                                    </div>
                                </div>

                                <div class="row ">
                                    <div class="col pl-0">
                                        <g:form controller="subscription" action="deleteSubscription">
                                            <g:hiddenField name="topic" value="${topicObj.id}"/>
                                            <button type="submit" class="d-inline-block btn btn-link p-0" href="">Unsubscribe</button>
                                        </g:form>
                                    </div>
                                    <div class="col pl-0">
                                        <p class="text-muted mb-1">${topicObj.subscription.size()}</p>
                                    </div>
                                    <div class="col pl-0">
                                        <p class="text-muted mb-1">${topicObj.resource.size()}</p>
                                    </div>
                                </div>
                            </div>
                        </div> %{--class row--}%
                        <div class="row">

                        <div class="col">
                            <div class="form-inline flex-wrap-nowrap justify-content-end">
                                <g:form controller="subscription" action="editSeriousness" method="POST">
                                    <g:hiddenField name="topic" value="${topicObj.id}"/>
                                    <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}" onchange="this.form.submit()" optionKey="key" value="${topicObj.subscription.find { it.user.username == session.user.username }?.SERIOUSNESS}" class="form-select m-1"/>
                                </g:form>
                                <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy}">
                                    <g:form controller="topic" action="editVisibility" method="POST">
                                        <g:hiddenField name="topic" value="${topicObj.id}"/>
                                        <g:select name="visibilitySelect" from="${VisibilityEnum.values()}" onchange="this.form.submit()" optionKey="key" value="${topicObj.VISIBILITY}" class="form-select m-1"></g:select>
                                    </g:form>
                                </g:if>
                                <button type="button" class="btn btn-link p-1" data-toggle="modal" data-target="#modalSendInvitation">
                                    <a href="#">
                                        <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation" height="26em">
                                    </a>
                                </button>
                                <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy}">
                                    <button type="button" class="btn btn-link p-1" id="topicEditButton" onclick="editTopic('${topicObj.id}')">
                                        <img src="${assetPath(src: 'icons/edit.png')}" alt="Edit" height="26em">
                                    </button>
                                    <button type="button" class="btn btn-link p-1" data-toggle="modal" data-target="#modalSendInvitation">
                                        <a href="#">
                                            <img src="${assetPath(src: 'icons/delete.png')}" alt="delete" height="26em">
                                        </a>
                                    </button>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    </div>
                </g:if>
            </g:each>

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
<asset:javascript src="dashboardJS"/>
</body>
</html>