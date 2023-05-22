<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>
<% def count = 0 %>

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<g:render template="/_templates/navbar" model="[page: 'dashboard']"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center h-100"><!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">
            <div class="card mt-5 mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body p-2">
                    <div class="row align-items-center">
                        <div class="col-sm-4 col-xl-3 col-lg-4 mr-2 mt-1">
                            <a href="/user/profile?user=${session.user.username}"><img
                                    src="${assetPath(src: "${session.user?.photo}")}" alt="User" width="95px"
                                    height="95px"/></a>
                        </div>

                        <div class="col-sm-8 col-xl-8 col-lg-8">
                            <div class="row">
                                <div class="col pl-0">
                                    <h3 class=""
                                        style="line-height:1em; padding-left: 15px;">${session.user?.firstName} ${session.user?.lastName}</h3>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col pl-0">
                                    <p class="mt-0 text-muted"
                                       style="line-height: 0.5em; padding-left: 15px;">@${session.user?.username}</p>
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
            </div> <!-- User information card-->

            <div class="modal fade" id="modalViewSubs" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Subscriptions</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span>&times;</span>
                            </button>
                        </div>

                        <div class="container ">
                            <ul class="list-group m-4 align-content-center">
                                <g:if test="${userSubscriptionsList.isEmpty()}">
                                    <span class="text-muted">Nothing to show</span>
                                </g:if>
                                <g:else>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <strong>Topic</strong>
                                        <strong>Posts</strong>
                                    </li>
                                <g:each in="${userSubscriptionsList}" var="topicObj">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <a class="text-dark"
                                           href="/topic/showTopic?id=${topicObj.id}">${topicObj.name}</a>
                                        <span class="badge badge-primary badge-pill">${topicObj.resource.size()}</span>
                                    </li>
                                </g:each>
                                </g:else>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-5 mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body p-2 ">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title m-2 pb-2 d-inline">Subscriptions</h5>
                        <button class="btn btn-link ml-auto" data-toggle="modal"
                                data-target="#modalViewSubs">View all</button>
                    </div>

                    <g:each in="${userSubscriptionsList}" var="topicObj">
                        <g:if test="${topicObj && (topicObj.resource && count < 5)}">
                            <% count++ %>
                            <div class="p-2 myContent">
                                <div class="row">
                                    <div class="col col-auto">
                                        <a href="/user/profile?user=${topicObj.createdBy.username}"><img
                                                src="${assetPath(src: "${topicObj.createdBy.photo}")}" width="70px"
                                                height="70px"/></a>
                                    </div>

                                    <div class="col">
                                        <div class="row">
                                            <div class="col pl-0">
                                                <a id="topicDisplay_${topicObj.id}"
                                                   href="/topic/showTopic?id=${topicObj.id}">${topicObj.name}</a>

                                                <div id="topicField_${topicObj.id}" class="d-none">
                                                    <span id="error_${topicObj.id}"
                                                          class="text-danger small mt-2 d-none"></span>

                                                    <div class="form-outline d-flex align-items-center">
                                                        <input type="text" class="form-control form-control-sm mr-2"
                                                               maxlength="254" id="topicInput_${topicObj.id}"
                                                               value="${topicObj.name}">
                                                        <button onclick="cancelEdit('${topicObj.id}')"
                                                                class="btn btn-secondary btn-sm mr-2">Cancel</button>
                                                        <button onclick="saveEditTopic('${topicObj.id}')"
                                                                class="btn btn-primary btn-sm mr-2">Save</button>
                                                    </div>
                                                </div>
                                                <span id="success_${topicObj?.id}"
                                                      class="text-success small mt-2 d-none">Success</span>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col pl-0">
                                                <p class="text-muted">@${topicObj?.createdBy?.username}</p>
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
                                                    <button type="submit" class="d-inline-block btn btn-link p-0"
                                                            href="">Unsubscribe</button>
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
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                    <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj.subscription.find { it.user.username == session.user.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj.id}">Failed</span>
                                            </div>

                                            <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy.username}">
                                                <div id="editVisibility_${topicObj.id}">
                                                    %{--                                        <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                    <g:select name="visibilitySelect" from="${VisibilityEnum.values()}"
                                                              onchange="updateVisibility('${topicObj.id}', this.value)"
                                                              optionKey="key" value="${topicObj.VISIBILITY}"
                                                              class="form-select m-1"></g:select>
                                                    <span class="text-success d-none"
                                                          id="visibilitySuccess_${topicObj.id}">Success</span>
                                                    <span class="text-danger d-none"
                                                          id="visibilityError_${topicObj.id}">Failed</span>
                                                </div>

                                            </g:if>

                                            <button type="button" class="btn btn-link p-1" data-toggle="modal"
                                                    data-target="#modalSendInvitation">
                                                <a href="#">
                                                    <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation"
                                                         height="26em">
                                                </a>
                                            </button>
                                            <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy.username}">
                                                <button type="button" class="btn btn-link p-1" id="topicEditButton"
                                                        onclick="editTopic('${topicObj.id}')">
                                                    <img src="${assetPath(src: 'icons/edit.png')}" alt="Edit"
                                                         height="26em">
                                                </button>
                                                <button type="button" class="btn btn-link p-1"
                                                        onclick="deleteTopic('${topicObj.id}')">
                                                    <img src="${assetPath(src: 'icons/delete.png')}" alt="delete"
                                                         height="26em">
                                                </button>
                                            </g:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                    </g:each>

                    <g:each in="${userSubscriptionsList}" var="topicObj">
                        <g:if test="${topicObj && (!topicObj.resource && count < 5)}">
                            <% count++ %>
                            <div class="p-2 myContent">
                                <div class="row">
                                    <div class="col col-auto">
                                        <a href="/user/profile?user=${topicObj.createdBy.username}"><img
                                                src="${assetPath(src: "${topicObj.createdBy.photo}")}" width="70px"
                                                height="70px"/></a>
                                    </div>

                                    <div class="col">
                                        <div class="row">
                                            <div class="col pl-0">
                                                <a id="topicDisplay_${topicObj.id}"
                                                   href="/topic/showTopic?id=${topicObj.id}">${topicObj.name}</a>

                                                <div id="topicField_${topicObj.id}" class="d-none">
                                                    <span id="error_${topicObj.id}"
                                                          class="text-danger small mt-2 d-none"></span>

                                                    <div class="form-outline d-flex align-items-center">
                                                        <input type="text" class="form-control form-control-sm mr-2"
                                                               maxlength="254" id="topicInput_${topicObj.id}"
                                                               value="${topicObj.name}">
                                                        <button onclick="cancelEdit('${topicObj.id}')"
                                                                class="btn btn-secondary btn-sm mr-2">Cancel</button>
                                                        <button onclick="saveEditTopic('${topicObj.id}')"
                                                                class="btn btn-primary btn-sm mr-2">Save</button>
                                                    </div>
                                                </div>
                                                <span id="success_${topicObj.id}"
                                                      class="text-success small mt-2 d-none">Success</span>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col pl-0">
                                                <p class="text-muted">@${topicObj.createdBy.username}</p>
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
                                                    <button type="submit" class="d-inline-block btn btn-link p-0"
                                                            href="">Unsubscribe</button>
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
                                            <div id="editSeriousness_${topicObj.id}">
                                                %{--                                    <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                <g:select name="seriousnessSelect" from="${SeriousnessEnum.values()}"
                                                          onchange="updateSeriousness('${topicObj.id}', this.value)"
                                                          optionKey="key"
                                                          value="${topicObj.subscription.find { it.user.username == session.user.username }?.SERIOUSNESS}"
                                                          class="form-select m-1"/>
                                                <span class="text-success d-none"
                                                      id="seriousnessSuccess_${topicObj.id}">Success</span>
                                                <span class="text-danger d-none"
                                                      id="seriousnessError_${topicObj.id}">Failed</span>
                                            </div>
                                            <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy.username}">
                                                <div id="editVisibility_${topicObj.id}">
                                                    %{--                                        <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                    <g:select name="visibilitySelect" from="${VisibilityEnum.values()}"
                                                              onchange="updateVisibility('${topicObj.id}', this.value)"
                                                              optionKey="key" value="${topicObj.VISIBILITY}"
                                                              class="form-select m-1"></g:select>
                                                    <span class="text-success d-none"
                                                          id="visibilitySuccess_${topicObj.id}">Success</span>
                                                    <span class="text-danger d-none"
                                                          id="visibilityError_${topicObj.id}">Failed</span>
                                                </div>
                                            </g:if>
                                            <button type="button" class="btn btn-link p-1" data-toggle="modal"
                                                    data-target="#modalSendInvitation">
                                                <a href="#">
                                                    <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation"
                                                         height="26em">
                                                </a>
                                            </button>
                                            <g:if test="${session.user.isAdmin || session.user.username == topicObj.createdBy.username}">
                                                <button type="button" class="btn btn-link p-1" id="topicEditButton"
                                                        onclick="editTopic('${topicObj.id}')">
                                                    <img src="${assetPath(src: 'icons/edit.png')}" alt="Edit"
                                                         height="26em">
                                                </button>
                                                <button type="button" class="btn btn-link p-1"
                                                        onclick="deleteTopic('${topicObj.id}')">
                                                    <img src="${assetPath(src: 'icons/delete.png')}" alt="delete"
                                                         height="26em">
                                                </button>
                                            </g:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:if>
                    </g:each>
                </div>
            </div> <!-- Subscription card-->

            <div class="card mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body p-2">
                    <h5 class="card-title m-2 mb-4">Trending Topics</h5>
                    <% def trendingCount = 0 %>
                    <g:each in="${trendingTopicsList}" var="obj">
                        <div class="p-2 myContent">
                            <g:if test="${obj && (obj[1].VISIBILITY == VisibilityEnum.PUBLIC || (obj[1].VISIBILITY == VisibilityEnum.PRIVATE && (obj[1].subscription.find { it.user.username == session.user.username } || session.user.isAdmin)))}">
                                <g:if test="${trendingCount < 5}">
                                    <% trendingCount++ %>
                                    <div class="row">
                                        <div class="col col-auto">
                                            <a href="/user/profile?user=${obj[1].createdBy.username}"><img
                                                    src="${assetPath(src: "${obj[1].createdBy.photo}")}" width="70px"
                                                    height="70px"/></a>
                                        </div>

                                        <div class="col">
                                            <div class="row">
                                                <div class="col pl-0">
                                                    <a id="trendingTopicDisplay_${obj[1].id}"
                                                       href="/topic/showTopic?id=${obj[1].id}">${obj[1].name}</a>

                                                    <div id="trendingTopicField_${obj[1].id}" class="d-none">
                                                        <span id="trendingError_${obj[1].id}"
                                                              class="text-danger small mt-2 d-none"></span>

                                                        <div class="form-outline d-flex align-items-center">
                                                            <input type="text" class="form-control form-control-sm mr-2"
                                                                   id="trendingTopicInput_${obj[1].id}"
                                                                   value="${obj[1].name}" maxlength="254">
                                                            <button onclick="trendingCancelEdit('${obj[1].id}')"
                                                                    class="btn btn-secondary btn-sm mr-2">Cancel</button>
                                                            <button onclick="trendingSaveEditTopic('${obj[1].id}')"
                                                                    class="btn btn-primary btn-sm mr-2">Save</button>
                                                        </div>
                                                    </div>
                                                    <span id="trendingSuccess_${obj[1].id}"
                                                          class="text-success small mt-2 d-none">Success</span>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col pl-0">
                                                    <p class="text-muted">@${obj[1].createdBy.username}</p>
                                                </div>

                                                <div class="col pl-0">
                                                    <a class="text-muted" href="#">Subscriptions</a>
                                                </div>

                                                <div class="col pl-0">
                                                    <a class="text-muted" href="#">Posts</a>
                                                </div>
                                            </div>

                                            <div class="row ">
                                                <div class="col pl-0 mr-4">
                                                    <g:if test="${obj[1].subscription.find { it.user.username == session.user.username }}">
                                                        <g:form controller="subscription" action="deleteSubscription">
                                                            <g:hiddenField name="topic" value="${obj[1].id}"/>
                                                            <button type="submit"
                                                                    class="d-inline-block btn btn-link p-0">Unsubscribe</button>
                                                        </g:form>
                                                    </g:if>
                                                    <g:else>
                                                        <span class="d-none" id="message_${obj[1].id}"></span>
                                                        <button id="subscribeBtn_${obj[1].id}" class="pl-2 btn btn-link"
                                                                onclick="subscribe('${obj[1].id}', '${session.user?.username}')">Subscribe</button>
                                                    </g:else>
                                                </div>

                                                <div class="col pl-0 mr-2">
                                                    <p id="subscriptionCount_${obj[1].id}"
                                                       class="text-muted mb-1">${obj[1].subscription.size()}</p>
                                                </div>

                                                <div class="col pl-0">
                                                    <p class="text-muted mb-1">${obj[1].resource.size()}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div> %{--class row--}%
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-inline flex-wrap-nowrap justify-content-end">
                                                <g:if test="${obj[1].subscription.find { it.user.username == session.user.username }}">
                                                    <div id="editSeriousness_${obj[1].id}">
                                                        %{--                                    <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                        <g:select name="trendingSeriousnessSelect"
                                                                  from="${SeriousnessEnum.values()}"
                                                                  onchange="trendingUpdateSeriousness('${obj[1].id}', this.value)"
                                                                  optionKey="key"
                                                                  value="${obj[1].subscription.find { it.user.username == session.user.username }?.SERIOUSNESS}"
                                                                  class="form-select m-1"/>
                                                        <span class="text-success d-none"
                                                              id="trendingSeriousnessSuccess_${obj[1].id}">Success</span>
                                                        <span class="text-danger d-none"
                                                              id="trendingSeriousnessError_${obj[1].id}">Failed</span>
                                                    </div>
                                                </g:if>
                                                <g:if test="${session.user.isAdmin || session.user.username == obj[1].createdBy.username}">
                                                    <div id="editVisibility_${obj[1].id}">
                                                        %{--                                        <g:hiddenField name="topic" value="${topicObj.id}" />--}%
                                                        <g:select name="trendingVisibilitySelect"
                                                                  from="${VisibilityEnum.values()}"
                                                                  onchange="trendingUpdateVisibility('${obj[1].id}', this.value)"
                                                                  optionKey="key" value="${obj[1].VISIBILITY}"
                                                                  class="form-select m-1"></g:select>
                                                        <span class="text-success d-none"
                                                              id="trendingVisibilitySuccess_${obj[1].id}">Success</span>
                                                        <span class="text-danger d-none"
                                                              id="trendingVisibilityError_${obj[1].id}">Failed</span>
                                                    </div>

                                                </g:if>
                                                <g:if test="${obj[1].subscription.find { it.user.username == session.user.username }}">
                                                    <button type="button" class="btn btn-link p-1" data-toggle="modal"
                                                            data-target="#modalSendInvitation">
                                                        <a href="#">
                                                            <img src="${assetPath(src: 'icons/mail.png')}"
                                                                 alt="Send Invitation"
                                                                 height="26em">
                                                        </a>
                                                    </button>
                                                </g:if>
                                                <g:if test="${session.user?.isAdmin || session.user?.username == obj[1]?.createdBy?.username}">
                                                    <button type="button" class="btn btn-link p-1"
                                                            id="trendingTopicEditButton"
                                                            onclick="trendingEditTopic('${obj[1]?.id}')">
                                                        <img src="${assetPath(src: 'icons/edit.png')}" alt="Edit"
                                                             height="26em">
                                                    </button>
                                                    <button type="button" class="btn btn-link p-1"
                                                            onclick="deleteTopic('${obj[1]?.id}')">
                                                        <img src="${assetPath(src: 'icons/delete.png')}" alt="delete"
                                                             height="26em">
                                                    </button>
                                                </g:if>
                                            </div>
                                        </div>
                                    </div>
                                </g:if>
                            </g:if>
                        </div>
                    </g:each>
                </div>
            </div> <!-- Trending Topics Card -->
        </div>

        <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
            <div class="card mt-5 mb-5 bg-light" style="border-radius: 15px;">
                <div class="card-body p-2 m-2">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title m-2 pb-2 d-inline">Inbox</h5>
                        <g:field type="search" class="form-control ml-auto w-25" placeholder="Search"
                                 name="inboxSearchQuery"
                                 id="inboxSearchInput"></g:field>
                    </div>

                    <div class="userInbox">
                        <g:render template="/_templates/inbox"
                                  model="['paginatedReadingItemList': paginatedReadingItemList]"/>
                    </div>
                </div>
                <% int pageCount = allReadingItemList.size() / 10
                pageCount = Math.max(pageCount, 1)
                if ((allReadingItemList.size() % 10 > 0) && allReadingItemList.size() > 10) {
                    pageCount++
                }
                %>
                <g:if test="${!allReadingItemList.isEmpty()}">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <g:each in="${1..pageCount}" var="num" status="i">
                                <li class="page-item"><a class="page-link" href="#">${num}</a>
                                </li>
                            </g:each>
                        </ul>
                    </nav>
                </g:if>
            </div>

        </div>
    </div>
</div>

<asset:javascript src="dashboardJS"/>
</body>
</html>