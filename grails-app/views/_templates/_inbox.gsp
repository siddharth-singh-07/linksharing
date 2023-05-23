<g:if test="${paginatedReadingItemList.isEmpty()}">
    <span class="text-muted">Nothing to show</span>
</g:if>
<g:each in="${paginatedReadingItemList}" var="readingItemObj">
    <div class="p-1 pb-4 myContent" id="div_${readingItemObj.id}">
        <div class="row">
            <div class="col pb-2 d-flex justify-content-between">
                <div>
                    <span>${readingItemObj.resource.createdBy.firstName} ${readingItemObj.resource.createdBy.lastName}</span>
                    <span class="text-muted pl-2">@${readingItemObj.resource.createdBy.username}</span>
                </div>
                <a href="/topic/showTopic?id=${readingItemObj.resource.topic.id}">${readingItemObj.resource.topic.name}</a>
            </div>

        </div>

        <div class="row">
            <div class="col">
                <p>${readingItemObj.resource.description}</p>
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
                <g:if test="${readingItemObj.resource instanceof linksharing.LinkResource}">
                    <a class="ml-auto "
                       href="https://${readingItemObj.resource.url}" target="_blank">View full site</a>
                </g:if>
                <g:else>
                    <g:link class="ml-2 mr-2 btn btn-link p-0 ml-auto" controller="resource"
                            action="downloadResource"
                            params='[resourceId: readingItemObj.resource.id]'>Download</g:link>
                </g:else>
                <button class="ml-4 btn btn-link p-0"
                        onclick="markRead(${readingItemObj.id})">Mark as read</button>
                <a class="ml-4" href="/resource/viewPost?id=${readingItemObj.resource.id}">View post</a>
            </div>
        </div>
    </div>
</g:each>
