<%@ page import="enums.*" %>
<nav class="navbar navbar-expand navbar-light bg-light">
    <g:link controller="Home" class="navbar-brand">LinkSharing</g:link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="mr-auto justify-content-end">
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <div class="d-flex input-group w-auto">
                <input type="search" class="form-control mr-3" placeholder="Search"/>
                <g:if test="${session.user}">
                    <g:if test="${page != 'profile'}">
                        <g:if test="${page != 'topicShow'}">
                            <button type="button" class="btn btn-link" data-toggle="modal"
                                    data-target="#modalCreateTopic">
                                <a href="#">
                                    <img src="${assetPath(src: 'icons/message.png')}" alt="Create Topic" height="25em">
                                </a>
                            </button>

                            <button type="button" class="btn btn-link" data-toggle="modal"
                                    data-target="#modalSendInvitation">
                                <a href="#">
                                    <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation" height="26em">
                                </a>
                            </button>
                        </g:if>

                        <button type="button" class="btn btn-link" data-toggle="modal" data-target="#modalShareLink">
                            <a href="#">
                                <img src="${assetPath(src: 'icons/link.png')}" alt="Create Resource Link" height="20em">
                            </a>
                        </button>

                        <button type="button" class="btn btn-link" data-toggle="modal" data-target="#modalShareDoc">
                            <a href="#">
                                <img src="${assetPath(src: 'icons/file.png')}" alt="Create Resource File" height="24em">
                            </a>
                        </button>
                    </g:if>
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                               data-toggle="dropdown">
                                <img src="${assetPath(src: "${session.user?.photo}")}" height="25em" width="25em"
                                     class="rounded-circle" alt="User Profile Picture">
                            </a>

                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="/user/editProfile">Profile</a>
                                <g:if test="${session.user?.isAdmin}">
                                    <a class="dropdown-item" href="/admin/users">Users</a>
                                    <a class="dropdown-item" href="#">Topics</a>
                                    <a class="dropdown-item" href="#">Posts</a>
                                </g:if>

                                <g:link controller="User" action="logoutUser" class="dropdown-item">Log out</g:link>
                            </div>
                        </li>
                    </ul>
                </g:if>
            </div>
        </ul>

    </div>

    <!-- Modal for Create Topic-->
    <div class="modal fade" id="modalCreateTopic" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create Topic</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <g:form controller="topic" action="createTopic" method="POST">
                    <div class="modal-body">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="modalCreateTopicNameInput">Name</label>
                            <g:field type="text" id="modalCreateTopicNameInput" name="modalCreateTopicNameInput"
                                     class="form-control form-control-md"/>
                        </div>

                        <div class="form-outline mb-3">
                            <div><label class="form-label" for="modalCreateTopicVisibilitySelect">Visibility</label>
                            </div>
                            <g:select id="modalCreateTopicVisibilitySelect" name="modalCreateTopicVisibilitySelect"
                                      from="${VisibilityEnum.values()}" optionKey="key"
                                      class="form-select form-select-lg mb-3 form-control"/>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
    <!-- Modal for Send Invitation-->
    <div class="modal fade" id="modalSendInvitation" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Send Invitation</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalSendInvitationEmailInput">Email</label>
                        <input type="text" id="modalSendInvitationEmailInput"
                               class="form-control form-control-md"/>
                    </div>

                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalSendInvitationTopicSelect">Topic</label></div>
                        <g:select id="modalSendInvitationTopicSelect" name="invitationTopic"
                                  from="${userSubscriptionsList}" optionKey="${{ it?.id }}"
                                  optionValue="${{ it?.name }}" class="form-select form-select-lg mb-3 form-control"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Invite</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal for Share Link -->
    <div class="modal fade" id="modalShareLink" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Share Link</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <g:form controller="resource" action="createLinkResource" method="POST">
                    <div class="modal-body">
                        <div class="form-outline mb-3">
                            <label class="form-label" for="modalShareLinkLinkInput">Link</label>
                            <g:field type="text" id="modalShareLinkLinkInput" name="modalShareLinkLinkInput"
                                     class="form-control form-control-md" required="true"/>
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="modalShareLinkDescriptionInput">Description</label>
                            <g:textArea type="" id="modalShareLinkDescriptionInput"
                                        name="modalShareLinkDescriptionInput"
                                        class="form-control form-control-md" required="true"></g:textArea>
                        </div>

                        <div class="form-outline mb-3">
                            <div><label class="form-label" for="modalShareLinkTopicSelect">Topic</label></div>
                            %{--                        <g:select id="modalShareLinkTopicSelect" name="modalShareLinkTopicSelect" from="${userSubscriptionsList.collect{it.topic?.name}}" class="form-select form-select-lg mb-3 form-control" />--}%
                            <g:select id="modalShareLinkTopicSelect" name="modalShareLinkTopicSelect"
                                      from="${userSubscriptionsList}" optionKey="${{ it?.id }}"
                                      optionValue="${{ it?.name }}"
                                      class="form-select form-select-lg mb-3 form-control"/>
                            <g:if test="${page == 'topicShow'}">
                                <g:hiddenField name="modalShareLinkTopicSelect"
                                               value="${userSubscriptionsList.id}"/>
                            </g:if>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Share</button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
    <!-- Modal for Share Document-->
    <div class="modal fade" id="modalShareDoc" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Share Document</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <div class="modal-body">
                <g:uploadForm controller="resource" action="createDocumentResource" method="POST">
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareDocFileInput">Document</label>
                        <g:field type="file" id="modalShareDocFileInput" name="modalShareDocFileInput"
                                 class="form-control" required="true"/>
                    </div>

                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareDocDescriptionInput">Description</label>
                        <textarea id="modalShareDocDescriptionInput" name="modalShareDocDescriptionInput"
                                  class="form-control form-control-md" required="true"></textarea>
                    </div>

                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalShareDocTopicSelect">Topic</label></div>
                        <g:select id="modalShareDocTopicSelect" name="modalShareDocTopicSelect"
                                  from="${userSubscriptionsList}" optionKey="${{ it?.id }}"
                                  optionValue="${{ it?.name }}" class="form-select form-select-lg mb-3 form-control"/>
                        <g:if test="${page == 'topicShow'}">
                            <g:hiddenField name="modalShareDocTopicSelect"
                                           value="${userSubscriptionsList.id}"/>
                        </g:if>
                    </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Share</button>
                    </div>
                </g:uploadForm>
            </div>
        </div>
    </div>
</nav>
<g:if test="${flash.message}">
    <div class="alert alert-success alert-dismissible fade show pt-1 pb-1">
        ${flash.message}
        <button type="button" class="close pt-1 pb-1" data-dismiss="alert">
            <span>&times;</span>
        </button>
    </div>
</g:if>
<g:if test="${flash.warn}">
    <div class="alert alert-danger alert-dismissible fade show pt-1 pb-1">
        ${flash.warn}
        <button type="button" class="close pt-1 pb-1" data-dismiss="alert">
            <span>&times;</span>
        </button>
    </div>
</g:if>

<g:hasErrors><!--Using this to display validation errors from domain class     bean="${myObject}"      -->
    <div class="alert alert-danger alert-dismissible fade show pt-1 pb-1">
        <g:eachError><p class="mb-0"><g:message error="${it}"/></p></g:eachError>
    %{--        <g:renderErrors class="" error="${it}"/>--}%
        <button type="button" class="close pt-1 pb-1" data-dismiss="alert">
            <span>&times;</span>
        </button>
    </div>
</g:hasErrors>