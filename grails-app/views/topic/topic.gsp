<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Topic</title>
</head>

<body>
<g:render template="/_templates/navbar" model="[page: 'topicShow']"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center h-100"><!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">
            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-2 ">
                    <h6 class="card-title m-2">Topic: ${topicObj.name}</h6>

                    <div class="p-2">
                        <div class="row">
                            <div class="col col-auto">
                                <img src="${assetPath(src: "${topicObj.createdBy.photo}")}" width="75px"
                                     height="75px"/>
                            </div>

                            <div class="col">
                                <div class="row">
                                    <div class="col pl-0">
                                        <span>${topicObj.name}</span>
                                        <span class="text-muted">(${topicObj.VISIBILITY})</span>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col pl-0">
                                        <a class="text-muted" href="#">@${topicObj.createdBy.username}</a>
                                    </div>

                                    <div class="col pl-0">
                                        <p class="text-muted">Subscriptions</p>
                                    </div>

                                    <div class="col pl-0">
                                        <p class="text-muted">Posts</p>
                                    </div>
                                </div>

                                <div class="row ">
                                    <div class="col pl-0">
                                        <g:if test="${topicObj.subscription.find { it.user.username == session.user.username }}">
                                            <g:if test="${topicObj.createdBy.username != session.user.username}">
                                                <g:form controller="subscription" action="deleteSubscription">
                                                    <g:hiddenField name="topic" value="${topicObj.id}"/>
                                                    <button type="submit"
                                                            class="d-inline-block btn btn-link p-0">Unsubscribe</button>
                                                </g:form>
                                            </g:if>
                                        </g:if>
                                        <g:else>
                                            <span class="d-none" id="message_${topicObj.id}"></span>
                                            <button id="subscribeBtn_${topicObj.id}" class="pl-2 btn btn-link"
                                                    onclick="subscribe('${topicObj.id}', '${session.user?.username}')">Subscribe</button>
                                        </g:else>
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
                                <div class="form-inline flex-wrap-nowrap justify-content-end pr-5">
                                    <div id="editSeriousness_${topicObj.id}">
                                        <g:if test="${topicObj.subscription.find { it.user.username == session.user.username }}">
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                    <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect_${topicObj.id}"
                                                          from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj.subscription.find { it.user.username == session.user.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj.id}">Failed</span>
                                            </div>
                                        </g:if>
                                    </div>
                                    <g:if test="${topicObj.subscription.find { it.user.username == session.user.username }}">
                                        <button type="button" class="btn btn-link p-1" data-toggle="modal"
                                                data-target="#modalSendInvitation">
                                            <a href="#">
                                                <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation"
                                                     height="26em">
                                            </a>
                                        </button>
                                    </g:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- topic show card-->

            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-2 ">
                    <h6 class="card-title m-2">Users: ${topicObj.name}</h6>
                    <g:each in="${topicObj.subscription}" var="subscriptionObj">
                        <div class="p-2">
                            <div class="row">
                                <div class="col col-auto">
                                    <a href="/user/profile?user=${subscriptionObj.user.username}"><img
                                            src="${assetPath(src: "${subscriptionObj.user.photo}")}" width="75px"
                                            height="75px"/></a>
                                </div>

                                <div class="col">
                                    <div class="row">
                                        <div class="col pl-0">
                                            <span>${subscriptionObj.user.firstName} ${subscriptionObj.user.lastName}</span>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col pl-0">
                                            <a class="text-muted" href="#">@${subscriptionObj.user.username}</a>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col pl-0">
                                            <a class="text-muted" href="#">Subscriptions</a>
                                        </div>

                                        <div class="col pl-0">
                                            <a class="text-muted" href="#">Posts</a>
                                        </div>
                                    </div>

                                    <div class="row ">
                                        <div class="col pl-0">
                                            <p class="text-muted mb-1">${subscriptionObj.user.subscription.size()}</p>
                                        </div>

                                        <div class="col pl-0">
                                            <p class="text-muted mb-1">${subscriptionObj.user.resource.size()}</p>
                                        </div>
                                    </div>
                                </div>
                            </div> %{--class row--}%
                        </div>
                    </g:each>
                </div>
            </div> <!-- Users card-->
        </div>

        <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
            <div class="card mt-5" style="border-radius: 15px;">
                <div class="card-body p-2 m-2">
                    <h5 class="card-title mb-4">Posts: ${topicObj.name}</h5>
                    <g:each in="${topicObj.resource}" var="resourceObj">
                        <div class="p-1 pb-3" id="div_${resourceObj.id}">
                            <div class="row">
                                <div class="col pb-2">
                                    <span>${resourceObj.createdBy.firstName} ${resourceObj.createdBy.lastName}</span>
                                    <span class="text-muted pl-2">@${resourceObj.createdBy.username}</span>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    <p>${resourceObj.description}</p>
                                </div>
                            </div>

                            <div class="row d-flex">
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
                                </div> <!-- facebook/Twitter icons -->
                                <div class="col d-flex">
                                    <g:if test="${resourceObj instanceof linksharing.LinkResource}">
                                        <a class="ml-auto "
                                           href="http://${resourceObj.url}">View full site</a>
                                    </g:if>
                                    <g:else>
                                        <g:link class="ml-auto mr-2 btn btn-link p-0" controller="resource"
                                                action="downloadResource"
                                                params='[resourceId: resourceObj.id]'>Download</g:link>
                                    </g:else>
                                <g:if test="${readingItemList.find{ it.user.username == session.user.username && it.resource.id == resourceObj.id && it.isRead==false}}">
                                    <% def currReadingItem = readingItemList.find{ it.user.username == session.user.username && it.resource.id == resourceObj.id} %>
                                    <button id="markReadBtn" class="ml-4 btn btn-link p-0"
                                            onclick="markRead(${currReadingItem.id})">Mark as read</button>
                                </g:if>
                                    <a class="ml-4" href="/resource/viewPost?id=${resourceObj.id}">View post</a>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
    </div>
</div>
<asset:javascript src="topicJS"/>
</body>
</html>