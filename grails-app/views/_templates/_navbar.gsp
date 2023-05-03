<nav class="navbar navbar-expand navbar-light bg-light">
    <a class="navbar-brand" href="#">LinkSharing</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="mr-auto justify-content-end">
            <g:message code="${flash.message}"/>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <div class="d-flex input-group w-auto">
                <input type="search" class="form-control mr-3" placeholder="Search"/>

                <button type="button" class="btn btn-link" data-toggle="modal" data-target="#modalCreateTopic">
                    <a href="#">
                       <img src="${assetPath(src: 'icons/message.png')}" alt="Create Topic" height="25em">
                    </a>
                </button>

                <button type="button" class="btn btn-link" data-toggle="modal" data-target="#modalSendInvitation">
                    <a href="#">
                        <img src="${assetPath(src: 'icons/mail.png')}" alt="Send Invitation" height="26em">
                    </a>
                </button>

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

                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                           data-toggle="dropdown">
                           <img src="${assetPath(src: 'icons/user.png')}" height="24em" class="rounded-circle" alt="User Profile Picture">
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="#">Users</a>
                            <a class="dropdown-item" href="#">Topics</a>
                            <a class="dropdown-item" href="#">Posts</a>
                            <a class="dropdown-item" href="#">Log out</a>
                        </div>
                    </li>
                </ul>
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
                <div class="modal-body">
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalCreateTopicNameInput">Name</label>
                        <input type="text" id="modalCreateTopicNameInput" class="form-control form-control-md" />
                    </div>
                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalCreateTopicVisibilitySelect">Visibility</label>
                        </div>
                        <select id="modalCreateTopicVisibilitySelect"
                                class="form-select form-select-lg mb-3 form-control">
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
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
                               class="form-control form-control-md" />
                    </div>
                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalSendInvitationTopicSelect">Topic</label></div>
                        <select id="modalSendInvitationTopicSelect"
                                class="form-select form-select-lg mb-3 form-control">
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
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
                <div class="modal-body">
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareLinkLinkInput">Link</label>
                        <input type="text" id="modalShareLinkLinkInput"
                               class="form-control form-control-md" />
                    </div>
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareLinkDescriptionInput">Description</label>
                        <textarea type="" id="modalShareLinkDescriptionInput"
                                  class="form-control form-control-md"></textarea>
                    </div>
                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalShareLinkTopicSelect">Topic</label></div>
                        <select id="modalShareLinkTopicSelect" class="form-select form-select-lg mb-3 form-control">
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Share</button>
                </div>
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
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareDocFileInput">Document</label>
                        <input type="file" id="modalShareDocFileInput"
                               class="form-control form-control-md" />
                    </div>
                    <div class="form-outline mb-3">
                        <label class="form-label" for="modalShareDocDescriptionInput">Description</label>
                        <textarea type="" id="modalShareDocDescriptionInput"
                                  class="form-control form-control-md"></textarea>
                    </div>
                    <div class="form-outline mb-3">
                        <div><label class="form-label" for="modalShareDocTopicSelect">Topic</label></div>
                        <select id="modalShareDocTopicSelect" class="form-select form-select-lg mb-3 form-control">
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Share</button>
                </div>
            </div>
        </div>
    </div>
</nav>