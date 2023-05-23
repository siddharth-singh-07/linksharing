package linksharing

import enums.VisibilityEnum

class ResourceController {
    def ResourceService
    def ReadingItemService
    def TopicService

    def index() {}

    def createLinkResource() {
        params.user = session.user
        Resource linkResource = ResourceService.createLinkResource(params)
        if (linkResource.hasErrors()) {
            flash.object = linkResource
            redirect(controller: 'User', action: "dashboard")
        } else {
            flash.message = "Link shared in ${linkResource.topic.name} successfully"
            redirect(controller: 'User', action: 'dashboard')
        }
    }

    def createDocumentResource() {
        params.user = session.user
        params.file = request.getFile('modalShareDocFileInput')
        Resource documentResource = ResourceService.createDocumentResource(params)
        documentResource.validate()
        if (documentResource.hasErrors()) {
            flash.object = documentResource
            redirect(controller: 'User', action: "dashboard")
        } else {
            flash.message = "Document shared in ${documentResource.topic.name} successfully"
            redirect(controller: 'User', action: 'dashboard')
        }
    }

    def markRead() {
        ReadingItemService.markReadingItemRead(params.readingItemId)
//        redirect(controller: 'user', action: 'dashboard')
        render status: 200, text: "Success"
    }

    def viewPost() {
        if (!session.user) {
            redirect(action: 'viewPublicPost', params: ['id': params.id])
            return
        }
        Resource resource = Resource.findById(params.id as Long)
        if (!resource) {
            flash.warn = "Post does not exist"
            redirect(controller: 'user', action: 'dashboard')
        } else if (resource.topic.VISIBILITY == VisibilityEnum.PRIVATE && !resource.topic.subscription.find { it.user.username == session.user.username }) {
            flash.warn = "You don't have access to this post"
            redirect(controller: 'user', action: 'dashboard')
        } else {
            List trendingTopicsList = TopicService.trendingTopics()
            render(view: 'viewPost', model: ['trendingTopicsList': trendingTopicsList, 'resourceObj': resource, 'userSubscriptionsList': resource.topic])
        }
    }

    def viewPublicPost() {
        if (session.user) {
            redirect(action: 'viewPost', params: ['id': params.id])
            return
        }
        List trendingTopicsList = TopicService.trendingTopics()
        Resource resource = Resource.findById(params.id as Long)
        if (!resource || resource.topic.VISIBILITY == VisibilityEnum.PRIVATE) {
            redirect(controller: 'home', action: 'index')
            return
        } else {
            render(view: 'viewPublicPost', model: ['trendingTopicsList': trendingTopicsList, 'resourceObj': resource])
        }
    }

    def updateLinkResource() {
        Resource resource = LinkResource.findById(params.resourceId)
        if (!resource) {
            flash.warn = "Resource not found"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        boolean flag = false
        if (params.modalShareLinkDescriptionInput.trim()) {
            resource.description = params.modalShareLinkDescriptionInput
            flag = true
        }
        if (params.modalShareLinkLinkInput.trim()) {
            resource.url = params.modalShareLinkLinkInput
            flag = true
        }
        if (flag) {
            try {
                resource.save(flush: true, failOnError: true)
            }
            catch (e) {
                flash.warn = e.message
            }
        }
        flash.message = "Resource edited successfully"
        redirect(action: 'viewPost', params: ['id': params.resourceId])
    }

    def updateDocumentResource() {
        Resource resource = DocumentResource.findById(params.resourceId)
        def resourceDoc = request.getFile('modalShareDocFileInput')

        if (!resource) {
            flash.warn = "Resource not found"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        boolean flag = false
        if (params.modalShareDocDescriptionInput.trim()) {
            resource.description = params.modalShareDocDescriptionInput
            flag = true
        }
        if (resourceDoc && !resourceDoc.isEmpty()) {
            File oldFile = new File("/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/${resource.filePath}")
            oldFile.delete()

            String filePath = resourceDoc.getOriginalFilename()
            new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/" + filePath).leftShift(resourceDoc.getInputStream())
            resource.filePath = filePath
        }


        if (flag) {
            try {
                resource.save(flush: true, failOnError: true)
            }
            catch (e) {
                flash.warn = e.message
            }
        }
        flash.message = "Resource edited successfully"
        redirect(action: 'viewPost', params: ['id': params.resourceId])
    }

    def deleteResource() {
        Long resourceId = params.resourceId as Long
        if (ResourceService.deleteResource(session.user?.username, resourceId)) {
            flash.message = "Resource deleted successfully"
            render status: 200, text: 'Success'
        } else {
            flash.warn = "Resource deletion failed"
            render status: 400, text: 'Failed'
        }
    }

    def downloadResource = {
        println params.resourceId
        DocumentResource res = DocumentResource.findById(params.resourceId as Long)
        String path = res.filePath
        println "/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/${path}"
        def file = new File("/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/${path}")
        if (file.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"${file.name}\"")
            response.outputStream << file.bytes
        } else println("Error!")
    }
}
