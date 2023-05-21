<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>

<head>
    <meta name="layout" content="mymain">
    <title>Link Sharing - Search</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<g:render template="/_templates/navbar" model="[page: 'dashboard']"/>
<div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center h-100"><!-- align-items-center -->
        <div class="col-md-4 col-lg-4 col-xl-4">

            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-3">
                    <h5 class="card-title m-2 mb-4">Trending Topics</h5>
                    <% def trendingCount = 0 %>
                    <g:each in="${trendingTopicsList}" var="obj">
                        <g:if test="${obj && (obj[1].VISIBILITY == VisibilityEnum.PUBLIC || (session.user && obj[1].VISIBILITY == VisibilityEnum.PRIVATE && (obj[1].subscription.find { it.user.username == session.user?.username } || session.user?.isAdmin)))}">
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
                                                <g:if test="${session.user}">
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
                                                </g:if>
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
                                <g:if test="${session.user}">
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
                                                <button type="button" class="btn btn-link p-1" data-toggle="modal"
                                                        data-target="#modalSendInvitation">
                                                    <a href="#">
                                                        <img src="${assetPath(src: 'icons/mail.png')}"
                                                             alt="Send Invitation"
                                                             height="26em">
                                                    </a>
                                                </button>
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
                        </g:if>
                    </g:each>
                </div>
            </div> <!-- Trending Topics Card -->

            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-3 ">
                    <h5 class="card-title m-2">Top Posts</h5>
                    <g:each in="${topPostsList}" var="obj">
                        <div class="row">
                            <div class="col col-auto">
                                <a href="/user/profile?user=${obj[1].createdBy.username}"><img
                                        src="${assetPath(src: "${obj[1].createdBy.photo}")}" width="70px"
                                        height="70px"/></a>
                            </div>
                            <div class="col">
                                <div class="row">
                                    <div class="col-auto text-left">
                                        <span>${obj[1].createdBy.firstName} ${obj[1].createdBy.lastName}</span>
                                        <span class="text-muted ml-2">@${obj[1].createdBy.username}</span>
                                    </div>

                                    <div class="col text-right">
                                        <a href="/topic/showTopic?id=${obj[1].topic.id}">${obj[1].topic.name}</a>
                                    </div>
                                </div>

                                <div class="row">
                                    <p>${obj[1].description?.take(100)}</p>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex mb-4 mt-2">
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
                                <g:if test="${obj[1] instanceof linksharing.LinkResource}">
                                    <a class="ml-auto "
                                       href="${obj[1]?.url}" target="_blank">View full site</a>
                                </g:if>
                                <g:else>
                                    <g:link class="mr-2 btn btn-link p-0 ml-auto" controller="resource"
                                            action="downloadResource"
                                            params='[resourceId: obj[1]?.id]'>Download</g:link>
                                </g:else>
                                <g:if test="${readingItemList.find { it.user?.username == session.user?.username && it?.resource?.id == obj[1]?.id && it?.isRead == false }}">
                                    <% def currReadingItem = readingItemList.find { it?.user?.username == session.user?.username && it?.resource?.id == obj[1]?.id } %>
                                    <button id="markReadBtn" class="ml-4 btn btn-link p-0"
                                            onclick="markRead(${currReadingItem?.id})">Mark as read</button>
                                </g:if>
                                <a class="ml-4" href="/resource/viewPost?id=${obj[1]?.id}">View post</a>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div> <!-- Top Posts card-->
        </div>

        <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
            <div class="card mt-5 mb-5" style="border-radius: 15px;">
                <div class="card-body p-2 m-2">
                    <h5 class="card-title mb-4">Search for "${searchQuery}"</h5>
                    <g:each in="${searchResultsList}" var="resourceObj">
                        <div class="p-1 pb-3 mb-4" id="div_${resourceObj?.id}">
                            <div class="row">
                                <div class="col pb-2 d-flex justify-content-between">
                                    <div>
                                        <span>${resourceObj?.createdBy?.firstName} ${resourceObj?.createdBy?.lastName}</span>
                                        <span class="text-muted pl-2">@${resourceObj?.createdBy?.username}</span>
                                    </div>
                                    <a href="/topic/showTopic?id=${resourceObj?.topic?.id}">${resourceObj?.topic?.name}</a>
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
                                        <a class="ml-auto "
                                           href="https://${resourceObj?.url}" target="_blank">View full site</a>
                                    </g:if>
                                    <g:else>
                                        <g:link class="mr-2 btn btn-link p-0 ml-auto" controller="resource"
                                                action="downloadResource"
                                                params='[resourceId: resourceObj?.id]'>Download</g:link>
                                    </g:else>
                                    <g:if test="${readingItemList.find { it.user?.username == session.user?.username && it?.resource?.id == resourceObj?.id && it?.isRead == false }}">
                                        <% def currReadingItem = readingItemList.find { it?.user?.username == session.user?.username && it?.resource?.id == resourceObj?.id } %>
                                        <button id="markReadBtn" class="ml-4 btn btn-link p-0"
                                                onclick="markRead(${currReadingItem?.id})">Mark as read</button>
                                    </g:if>
                                    <a class="ml-4" href="/resource/viewPost?id=${resourceObj?.id}">View post</a>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

        </div>
    </div>
</div>
<asset:javascript src="searchJS"/>
</body>
</html>