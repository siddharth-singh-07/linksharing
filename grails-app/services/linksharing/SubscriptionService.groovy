package linksharing

import enums.SeriousnessEnum
import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionService {

    def serviceMethod() {

    }

    Subscription createSubscription(topicId, username, seriousness) {
        Subscription sub = new Subscription()
        sub.topic = Topic.findById(topicId)
        sub.user = User.findByUsername(username)
        sub.SERIOUSNESS = seriousness

        sub.validate()
        if (!sub.hasErrors()) {
            sub.save(flush: true, failOnError: true)
        }
        return sub
    }

    Subscription editSubscriptionSeriousness(topicId, newSeriousness, user) {
        Topic currTopic = Topic.findById(topicId)
        Subscription sub = Subscription.findByTopicAndUser(currTopic, user)
        sub.SERIOUSNESS = newSeriousness
        return sub
    }

    void deleteSubscription(topicId, user) {
        Topic topic = Topic.findById(topicId)
        Subscription sub = Subscription.findByTopicAndUser(topic, user)
        sub.delete()
    }
}
