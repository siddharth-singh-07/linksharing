<!doctype html>
<html lang="en">
<%@ page import="enums.*" %>
<head>
%{--    <meta name="layout" content="mymain">--}%

    <title>Link Sharing - Post</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
    .checked {
        color: orange;
    }
    </style>
</head>

<body>
<g:render template="/_templates/navbar" model="[page: 'profile']"/>
    <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center h-100"><!-- align-items-center -->

            <div class="col-md-7 col-lg-7 col-xl-7 ml-5">
                <div class="card mt-5 mb-5" style="border-radius: 15px;">
                    <div class="card-body p-2 m-2">
                        <div class="row">
                            <div class="col col-auto">
                                <a href="/user/profile?user=${resourceObj?.createdBy?.username}"><img
                                        src="${assetPath(src: "${resourceObj?.createdBy?.photo}")}" width="70px"
                                        height="70px"/></a>
                            </div>

                            <div class="col">
                                <div class="row">
                                    <div class="col mr-auto">
                                        <h5>${resourceObj?.createdBy?.firstName} ${resourceObj?.createdBy?.lastName}</h5>
                                    </div>

                                    <div class="col d-flex justify-content-end">
                                        <div class="text-right pr-3">
                                            <a href="/topic/showTopic?id=${resourceObj?.topic?.id}">${resourceObj?.topic?.name}</a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col mr-auto">
                                        <p class="text-muted">@${resourceObj?.createdBy?.username}</p>
                                    </div>

                                    <div class="col d-flex justify-content-end">
                                        <div class="text-right pr-3">
                                            <g:formatDate date="${resourceObj?.dateCreated}" type="datetime"
                                                          style="LONG"
                                                          timeStyle="SHORT"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                        <div class="col" id="ratingStars">
                                            <i class="fa fa-star" style="font-size:24px"></i>
                                            <i class="fa fa-star" style="font-size:24px"></i>
                                            <i class="fa fa-star" style="font-size:24px"></i>
                                            <i class="fa fa-star" style="font-size:24px"></i>
                                            <i class="fa fa-star" style="font-size:24px"></i>
                                            <span class="text" id="ratingResult"></span>

                                            <p class="text-muted" id="ratingDisplay"></p>
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
                                            <a class="ml-2 mr-2"
                                               href="https://${resourceObj.url}" target="_blank">View full site</a>
                                        </g:if>
                                        <g:else>
                                            <g:link class="ml-2 mr-2 btn btn-link p-0" controller="resource"
                                                    action="downloadResource"
                                                    params='[resourceId: resourceObj.id]'>Download</g:link>
                                        </g:else>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-lg-4 col-xl-4">
                <div class="card mt-5 mb-5" style="border-radius: 15px;">
                    <div class="card-body p-2">
                        <h5 class="card-title m-2 mb-4">Trending Topics</h5>
                        <% def trendingCount = 0 %>
                        <g:each in="${trendingTopicsList}" var="obj">
                            <div class="pb-2">
                                <g:if test="${obj && (obj[1].VISIBILITY == VisibilityEnum.PUBLIC || (obj[1].VISIBILITY == VisibilityEnum.PRIVATE && (obj[1].subscription.find { it.user.username == session.user?.username } || session.user?.isAdmin)))}">
                                    <g:if test="${trendingCount < 5}">
                                        <% trendingCount++ %>

                                        <div class="row">
                                            <div class="col col-auto">
                                                <a href="/user/profile?user=${obj[1].createdBy.username}"><img
                                                        src="${assetPath(src: "${obj[1].createdBy.photo}")}"
                                                        width="70px"
                                                        height="70px"/></a>
                                            </div>

                                            <div class="col">
                                                <div class="row">
                                                    <div class="col pl-0">
                                                        <a id="trendingTopicDisplay_${obj[1].id}"
                                                           href="/topic/showTopic?id=${obj[1].id}">${obj[1].name}</a>
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
                                    </g:if>
                                </g:if>
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script> var resourceId = "${resourceObj.id}"</script>
    <asset:javascript src="viewPublicPostJS"/>

    <g:if test="${resourceObj instanceof linksharing.LinkResource}">
        <div class="modal fade" id="modalEditLink" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Resource</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:form controller="resource" action="updateLinkResource" method="POST">
                        <div class="modal-body">
                            <div class="form-outline mb-3">
                                <label class="form-label" for="modalShareLinkLinkInput">Link</label>
                                <g:field type="text" id="modalShareLinkLinkInput" name="modalShareLinkLinkInput"
                                         value="${resourceObj.url}"
                                         class="form-control form-control-md" maxlength="3999"/>
                            </div>

                            <div class="form-outline mb-3">
                                <label class="form-label" for="modalShareLinkDescriptionInput">Description</label>
                                <g:textArea type="" id="modalShareLinkDescriptionInput"
                                            name="modalShareLinkDescriptionInput"
                                            class="form-control form-control-md"
                                            value="${resourceObj.description}" maxlength="3999"></g:textArea>
                            </div>

                            <div class="form-outline mb-3">
                                <p>Topic: ${resourceObj.topic.name}</p>
                                <g:hiddenField name="resourceId" value="${resourceObj.id}"></g:hiddenField>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Edit</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="modal fade" id="modalEditDoc" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Resource</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <g:uploadForm controller="resource" action="updateDocumentResource" method="POST">
                        <div class="modal-body">
                            <div class="form-outline mb-3">
                                <label class="form-label" for="modalShareDocFileInput">File</label>
                                <g:field type="file" id="modalShareDocFileInput" name="modalShareDocFileInput"
                                         class="form-control"/>
                            </div>

                            <div class="form-outline mb-3">
                                <label class="form-label" for="modalShareDocDescriptionInput">Description</label>
                                <g:textArea id="modalShareDocDescriptionInput" name="modalShareDocDescriptionInput"
                                            class="form-control form-control-md"
                                            value="${resourceObj.description}"></g:textArea>
                            </div>

                            <div class="form-outline mb-3">
                                <p>Topic: ${resourceObj.topic.name}</p>
                                <g:hiddenField name="resourceId" value="${resourceObj.id}"></g:hiddenField>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Edit</button>
                        </div>
                    </g:uploadForm>
                </div>
            </div>
        </div>
    </g:else>


</body>
</html>