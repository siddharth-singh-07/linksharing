package linksharing

import enums.SeriousnessEnum
import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionService {

    def serviceMethod() {

    }

    Subscription createSubscription(Topic topic, User user, SeriousnessEnum seriousness){
        Subscription sub= new Subscription()
        sub.topic= topic
        sub.user=user
        sub.SERIOUSNESS= seriousness

        sub.validate()
        if(!sub.hasErrors()){
            sub.save(flush:true, failOnError:true)
        }
        return sub
    }

    Subscription editSubscriptionSeriousness(topicId, newSeriousness, user){
        Topic currTopic= Topic.findById(topicId)
        Subscription sub= Subscription.findByTopicAndUser(currTopic, user)
        sub.SERIOUSNESS=newSeriousness
        return sub
    }

    void deleteSubscription(topicId, user){
        Topic topic= Topic.findById(topicId)
        Subscription sub = Subscription.findByTopicAndUser(topic, user)
        sub.delete()
    }
}
