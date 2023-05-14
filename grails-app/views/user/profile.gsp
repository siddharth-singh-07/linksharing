<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Profile</title>
</head>

<body>
<g:render template="/_templates/navbar" model="[page: 'profile']"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center h-100"><!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">
            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-2">
                    <div class="row align-items-center">
                        <div class="col-sm-4 col-xl-3 col-lg-4 mr-2 mt-1">
                            <img src="${assetPath(src: "${targetUser?.photo}")}" alt="User" width="95px" height="95px"/>
                        </div>

                        <div class="col-sm-8 col-xl-8 col-lg-8">
                            <div class="row">
                                <div class="col pl-0">
                                    <h3 class=""
                                        style="line-height:1em; padding-left: 15px;">${targetUser?.firstName} ${targetUser?.lastName}</h3>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col pl-0">
                                    <p class="mt-0 text-muted"
                                       style="line-height: 0.5em; padding-left: 15px;">@${targetUser?.username}</p>
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
                                    <p class="m-0">${userSubscriptionsList?.size()}</p>
                                </div>

                                <div class="col-sm-6 col-xl-6 col-lg-6">
                                    <p class="m-0">${userTopicsList?.size()}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- User info card -->

            <div class="card mt-5 mb-5 p-1" style="border-radius: 15px;">
                <h5 class="card-title m-2">Topics</h5>
                <g:if test="${session.user?.isAdmin || session.user?.username == targetUser?.username}">
                    <g:each in="${userTopicsList}" var="topicObj">
                        <div class="card-body p-2 ">
                            <div class="row">
                                <div class="col">
                                    <a href="">${topicObj?.name}</a>
                                </div>

                                <div class="col">
                                    <p class="text-muted">Subscriptions</p>
                                </div>

                                <div class="col">
                                    <p class="text-muted">Post</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                        <div id="editSeriousness_${topicObj.id}">
                                            %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                            <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                      onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                      optionKey="key"
                                                      value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                      class="form-select m-1"/>
                                            <span class="text-success d-none"
                                                  id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                            <span class="text-danger d-none"
                                                  id="seriousnessError_${topicObj?.id}">Failed</span>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <span class="d-none" id="message_${topicObj?.id}"></span>
                                    %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                    %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                        <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                    </g:else>
                                </div>

                                <div class="col" id="subscriptionCount_${topicObj?.id}">
                                    <a href="">${topicObj?.subscription?.size()}</a>
                                </div>

                                <div class="col">
                                    <a href="">${topicObj?.resource?.size()}</a>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </g:if>
                <g:else>
                    <g:each in="${userTopicsList?.findAll { it.VISIBILITY == enums.VisibilityEnum.PUBLIC }}"
                            var="topicObj">
                        <div class="card-body p-2 ">
                            <div class="row">
                                <div class="col">
                                    <a href="">${topicObj?.name}</a>
                                </div>

                                <div class="col">
                                    <p class="text-muted">Subscriptions</p>
                                </div>

                                <div class="col">
                                    <p class="text-muted">Post</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                        <div id="editSeriousness_${topicObj.id}">
                                            %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                            <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                      onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                      optionKey="key"
                                                      value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                      class="form-select m-1"/>
                                            <span class="text-success d-none"
                                                  id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                            <span class="text-danger d-none"
                                                  id="seriousnessError_${topicObj?.id}">Failed</span>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <span class="d-none" id="message_${topicObj?.id}"></span>
                                    %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                    %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                        <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                    </g:else>
                                </div>

                                <div class="col" id="subscriptionCount_${topicObj?.id}">
                                    <a href="">${topicObj?.subscription?.size()}</a>
                                </div>

                                <div class="col">
                                    <a href="">${topicObj?.resource?.size()}</a>
                                </div>
                            </div>
                        </div>
                    </g:each>

                    <g:each in="${userTopicsList}"
                            var="topicObj">
                        <g:if test="${topicObj.VISIBILITY == enums.VisibilityEnum.PRIVATE && topicObj.subscription.find { it.user.username == session.user.username }}">
                            <div class="card-body p-2 ">
                                <div class="row">
                                    <div class="col">
                                        <a href="">${topicObj?.name}</a>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Subscriptions</p>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Post</p>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj?.id}">Failed</span>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <span class="d-none" id="message_${topicObj?.id}"></span>
                                        %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                        %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                            <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                    onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                        </g:else>
                                    </div>

                                    <div class="col" id="subscriptionCount_${topicObj?.id}">
                                        <a href="">${topicObj?.subscription?.size()}</a>
                                    </div>

                                    <div class="col">
                                        <a href="">${topicObj?.resource?.size()}</a>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                    </g:each>

                </g:else>
            </div> <!-- Topics card (displays all topics created by user) -->

            <div class="card mb-5 p-1" style="border-radius: 15px;">
                <h5 class="card-title m-2">Subscriptions</h5>

                <div class="card-body p-0">
                    <g:if test="${session.user?.isAdmin || session.user?.username == targetUser?.username}">
                        <g:each in="${userSubscriptionsList}" var="topicObj">
                            <div class="card-body p-2 ">
                                <div class="row">
                                    <div class="col">
                                        <a href="">${topicObj?.name}</a>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Subscriptions</p>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Post</p>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj?.id}">Failed</span>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <span class="d-none" id="message_${topicObj?.id}"></span>
                                        %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                        %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                            <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                    onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                        </g:else>
                                    </div>

                                    <div class="col" id="subscriptionCount_${topicObj?.id}">
                                        <a href="">${topicObj?.subscription?.size()}</a>
                                    </div>

                                    <div class="col">
                                        <a href="">${topicObj?.resource?.size()}</a>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </g:if>
                    <g:else>
                        <g:each in="${userSubscriptionsList}"
                                var="topicObj">
                            <g:if test="${topicObj.subscription.find { it.user.username == session.user.username } && topicObj.VISIBILITY == enums.VisibilityEnum.PRIVATE}">
                                <div class="card-body p-2 ">
                                    <div class="row">
                                        <div class="col">
                                            <a href="">${topicObj?.name}</a>
                                        </div>

                                        <div class="col">
                                            <p class="text-muted">Subscriptions</p>
                                        </div>

                                        <div class="col">
                                            <p class="text-muted">Post</p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col">
                                            <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                                <div id="editSeriousness_${topicObj.id}">
                                                    %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                    <g:select name="seriousnessSelect"
                                                              from="${SeriousnessEnum.values()}"
                                                              onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                              optionKey="key"
                                                              value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                              class="form-select m-1"/>
                                                    <span class="text-success d-none"
                                                          id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                                    <span class="text-danger d-none"
                                                          id="seriousnessError_${topicObj?.id}">Failed</span>
                                                </div>
                                            </g:if>
                                            <g:else>
                                                <span class="d-none" id="message_${topicObj?.id}"></span>
                                            %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                            %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                                <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                        onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                            </g:else>
                                        </div>

                                        <div class="col" id="subscriptionCount_${topicObj?.id}">
                                            <a href="">${topicObj?.subscription?.size()}</a>
                                        </div>

                                        <div class="col">
                                            <a href="">${topicObj?.resource?.size()}</a>
                                        </div>
                                    </div>
                                </div>
                            </g:if>
                        </g:each>

                        <g:each in="${userSubscriptionsList.findAll { it.VISIBILITY == enums.VisibilityEnum.PUBLIC }}"
                                var="topicObj">
                            <div class="card-body p-2 ">
                                <div class="row">
                                    <div class="col">
                                        <a href="">${topicObj?.name}</a>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Subscriptions</p>
                                    </div>

                                    <div class="col">
                                        <p class="text-muted">Post</p>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <g:if test="${topicObj.subscription.find { it.user?.username == session.user?.username }}">
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                            <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj?.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj?.subscription?.find { it.user?.username == session.user?.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj?.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj?.id}">Failed</span>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <span class="d-none" id="message_${topicObj?.id}"></span>
                                        %{--                                        <span class="d-none" id="topicId_${topicObj.id}">${topicObj.id}</span>--}%
                                        %{--                                        <span class="d-none" id="username_${topicObj.id}">${session.user.username}</span>--}%
                                            <button id="subscribeBtn_${topicObj?.id}" class="pl-2 btn btn-link"
                                                    onclick="subscribe('${topicObj?.id}', '${session.user?.username}')">Subscribe</button>
                                        </g:else>
                                    </div>

                                    <div class="col" id="subscriptionCount_${topicObj?.id}">
                                        <a href="">${topicObj?.subscription?.size()}</a>
                                    </div>

                                    <div class="col">
                                        <a href="">${topicObj?.resource?.size()}</a>
                                    </div>
                                </div>
                            </div>
                        </g:each>

                    </g:else>
                </div>
            </div> <!-- Subscriptions card (displays all subscribed topics of user) -->
        </div>

        <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
            <div class="card mt-5 p-1" style="border-radius: 15px;">
                <h5 class="card-title m-2">Posts</h5>

                <div class="card-body p-0">
                    <g:if test="${session.user?.isAdmin || session.user?.username == targetUser?.username}">
                        <g:each in="${targetUser.resource}" var="resourceObj">
                            <div class="card-body p-2 overflow-auto">
                                <div class="row">
                                    <div class="col">
                                        <a href="">${resourceObj?.topic?.name}</a>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <p>${resourceObj?.description}</p>
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
                                            <a class="ml-auto" href="http://${resourceObj?.url}">View full site</a>
                                        </g:if>
                                        <g:else>
                                            <a class="ml-auto" href="">Download</a>
                                        </g:else>
                                        <a class="ml-4" href="">View post</a>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </g:if>
                    <g:else>
                        <g:each in="${targetUser.resource.findAll { it.topic.VISIBILITY == VisibilityEnum.PUBLIC }}"
                                var="resourceObj">
                            <div class="card-body p-2 overflow-auto">
                                <div class="row">
                                    <div class="col">
                                        <a href="">${resourceObj?.topic?.name}</a>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <p>${resourceObj?.description}</p>
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
                                            <a class="ml-auto" href="https://${resourceObj?.url}">View full site</a>
                                        </g:if>
                                        <g:else>
                                            <a class="ml-auto" href="">Download</a>
                                        </g:else>
                                        <a class="ml-4" href="">View post</a>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                        <g:each in="${targetUser.resource}"
                                var="resourceObj">
                            <g:if test="${resourceObj.topic.VISIBILITY == enums.VisibilityEnum.PRIVATE && resourceObj.topic.subscription.find { it.user.username == session.user.username }}">
                                <div class="card-body p-2 overflow-auto">
                                    <div class="row">
                                        <div class="col">
                                            <a href="">${resourceObj?.topic?.name}</a>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col">
                                            <p>${resourceObj?.description}</p>
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
                                                <a class="ml-auto" href="https://${resourceObj?.url}">View full site</a>
                                            </g:if>
                                            <g:else>
                                                <a class="ml-auto" href="">Download</a>
                                            </g:else>
                                            <a class="ml-4" href="">View post</a>
                                        </div>
                                    </div>
                                </div>
                            </g:if>
                        </g:each>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
</div>
<asset:javascript src="profileJS"/>
</body>
</html>