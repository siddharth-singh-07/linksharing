package linksharing

import enums.VisibilityEnum
import grails.gorm.transactions.Transactional

@Transactional
class ResourceService {

    def ReadingItemService
    def AuditLogService

    List recentShares() {
        List recentSharesList = Resource.createCriteria().list {
            topic {
                eq('VISIBILITY', VisibilityEnum.PUBLIC)
            }
            order('dateCreated', 'asc')
            maxResults(5)
        }
        return recentSharesList
    }

//    List topPosts() {
//        List topPostsList = ResourceRating.createCriteria().list {
//            topic {
//                eq('VISIBILITY', VisibilityEnum.PUBLIC)
//            }
//            order('score', desc)
//            maxResults(5)
//        }
//        return topPostsList
//    }

    Resource createLinkResource(params) {
        Resource linkResource = new LinkResource()
        linkResource.url = params.modalShareLinkLinkInput
        linkResource.description = params.modalShareLinkDescriptionInput.take(255)
        linkResource.createdBy = params.user
        linkResource.topic = Topic.findById(params.modalShareLinkTopicSelect)

        linkResource.validate()
        if (!linkResource.hasErrors()) {
            try {
                linkResource.save(flush: true, failOnError: true)
            }
            catch (e) {
                println e
                return linkResource
            }
            ReadingItemService.addResource(linkResource)
        }
        return linkResource
    }

    Resource createDocumentResource(params) {
        Resource documentResource = new DocumentResource()
        documentResource.description = params.modalShareDocDescriptionInput.take(255)
        documentResource.createdBy = params.user
        documentResource.topic = Topic.findById(params.modalShareDocTopicSelect)

        def resourceDoc = params.file
        if (resourceDoc && !resourceDoc.isEmpty()) {
            String filePath = resourceDoc.getOriginalFilename()
            new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/" + filePath).leftShift(resourceDoc.getInputStream())
            documentResource.filePath = filePath
        }

        documentResource.validate()
        if (!documentResource.hasErrors()) {
            try {
                documentResource.save(flush: true, failOnError: true)
            }
            catch (e) {
                println e
                return documentResource
            }
            ReadingItemService.addResource(documentResource)
        }
        return documentResource
    }

    def fetchUserPublicPosts(username) {
        def userPublicPostsList = Resource.createCriteria().list {
            createdBy {
                eq('username', username)
            }
            topic {
                eq('VISIBILITY', VisibilityEnum.PUBLIC)
            }
        }
        return userPublicPostsList
    }

    def deleteResource(username, resourceId) {
        Resource resource = Resource.findById(resourceId)
        User user = User.findByUsername(username)

        if (!user.isAdmin && (resource.createdBy.username != user.username)) {
            return false
        }

        def readingItems = resource.readingItem
        def resourceRatings = resource.resourceRating

        readingItems.each { readingItem ->
            if (!AuditLogService.createLog(readingItem, user))
                return false
        }
        resourceRatings.each { resourceRating ->
            if (!AuditLogService.createLog(resourceRating, user))
                return false
        }
        if (!AuditLogService.createLog(resource, user))
            return false

        try {
            resource.delete(flush: true)
        }
        catch (e) {
            println e
            return false
        }
        return true
    }
}
