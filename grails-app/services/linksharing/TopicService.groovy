package linksharing

import enums.SeriousnessEnum
import grails.gorm.transactions.Transactional

@Transactional
class TopicService {
    def SubscriptionService
    def AuditLogService

    def serviceMethod() {

    }

    def allTopics() {
        def allTopicsList = Topic.createCriteria().list {
            projections {
                property('name')
            }
        }
        return allTopicsList
    }

//    def allSubscribedTopics(User user){
//        List allSubscribedTopicsList= Subscription.createCriteria().list {
//            projections{
//                property('topic')
//            }
//            eq('user', user)
//        }
//        return allSubscribedTopicsList
//    }

    Topic createTopic(params) {
        Topic topic = new Topic()
        topic.name = params.modalCreateTopicNameInput
        topic.VISIBILITY = params.modalCreateTopicVisibilitySelect
        topic.createdBy = params.user

        topic.validate()
        if (!topic.hasErrors()) {
            try {
                topic.save(flush: true, falOnError: true)
            }
            catch (e) {
                println e
                return topic
            }
            SubscriptionService.createSubscription(topic.id, topic.createdBy.username, SeriousnessEnum.VERY_SERIOUS)
        }
        return topic
    }

    void editTopicVisibility(topicId, newVisibility) {
        Topic currTopic = Topic.findById(topicId)
        currTopic.VISIBILITY = newVisibility

        try {
            currTopic.save(flush: true, validate: false)
        }
        catch (e) {
            println e
        }
//        return currTopic
        //        currTopic.validate()
//        if(!currTopic.hasErrors()){
//            currTopic.save(flush:true, failOnError:true)
//        }
    }

    Topic editTopicName(topicId, newTopicName) {
        Topic currTopic = Topic.findById(topicId)
        currTopic.name = newTopicName

        currTopic.validate()
        if (!currTopic.hasErrors()) {
            try {
                currTopic.save(flush: true, failOnError: true)
            }
            catch (e) {
                println e
                return currTopic
            }
        }
        return currTopic
    }

    List trendingTopics() {
        List trendingTopicsList = Resource.createCriteria().list() {
            projections {
                count("id", 'resourceCount')
            }
            groupProperty("topic")
            order('resourceCount', 'desc')
        }
        return trendingTopicsList
    }

    def deleteTopic(username, topicId) {
        Topic topic = Topic.findById(topicId)
        User user = User.findByUsername(username)

        if (!user.isAdmin && (topic.createdBy.username != user.username)) {
            return false
        }
        else if(!topic){
            return false
        }

        def resources = topic.resource
        def subscriptions = topic.subscription
        def readingItems = topic.resource.readingItem
        def resourceRatings = topic.resource.resourceRating

        resources.each { resource ->
            if (!AuditLogService.createLog(resource, user))
                return false
        }
        subscriptions.each { subscription ->
            if (!AuditLogService.createLog(subscription, user))
                return false
        }
        readingItems.each { readingItem ->
            readingItem.each { item ->
                if (!AuditLogService.createLog(item, user)) {
                    return false
                }
            }
        }

        resourceRatings.each { resourceRating ->
            resourceRating.each { rating ->
                if (!AuditLogService.createLog(rating, user)) {
                    return false
                }
            }
        }

        if (!AuditLogService.createLog(topic, user))
            return false

        try {
            topic.delete(flush: true)
        }
        catch (e) {
            println e
            return false
        }
        return true
    }

}
