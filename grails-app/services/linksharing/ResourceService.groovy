package linksharing

import enums.VisibilityEnum
import grails.gorm.transactions.Transactional

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Transactional
class ResourceService {

    def ReadingItemService

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
        linkResource.description = params.modalShareLinkDescriptionInput
        linkResource.createdBy = params.user
        linkResource.topic = Topic.findById(params.modalShareLinkTopicSelect)

        linkResource.validate()
        if (!linkResource.hasErrors()) {
            linkResource.save(flush: true, failOnError: true)
            ReadingItemService.addResource(linkResource)
        }
        return linkResource
    }

    Resource createDocumentResource(params) {
        Resource documentResource = new DocumentResource()
        documentResource.description = params.modalShareDocDescriptionInput
        documentResource.createdBy = params.user
        documentResource.topic = Topic.findById(params.modalShareDocTopicSelect)

        def resourceDoc = params.file
        if (resourceDoc && !resourceDoc.isEmpty()) {
            def currentDateTime = LocalDateTime.now()
            def formatter = DateTimeFormatter.ofPattern('yyyyMMddHHmmss')
            def formattedDateTime = currentDateTime.format(formatter)

            String filePath = "${params.user.username + formattedDateTime}"
            new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/fileResources/" + filePath).leftShift(resourceDoc.getInputStream())
            documentResource.filePath = filePath
        }

        documentResource.validate()
        if (!documentResource.hasErrors()) {
            documentResource.save(flush: true, failOnError: true)
            ReadingItemService.addResource(documentResource)
        }
        return documentResource
    }

    def fetchUserPublicPosts(username){
        def userPublicPostsList= Resource.createCriteria().list {
            createdBy{
                eq('username', username)
            }
            topic{
                eq('VISIBILITY', VisibilityEnum.PUBLIC)
            }
        }
        return userPublicPostsList
    }
}
