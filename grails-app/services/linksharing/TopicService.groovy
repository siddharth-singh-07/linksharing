package linksharing

import enums.SeriousnessEnum
import grails.gorm.transactions.Transactional

@Transactional
class TopicService {
    def SubscriptionService

    def serviceMethod() {

    }

    def allTopics(){
        def allTopicsList= Topic.createCriteria().list {
            projections{
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

    Topic createTopic(params){
        Topic topic = new Topic()
        topic.name= params.modalCreateTopicNameInput
        topic.VISIBILITY= params.modalCreateTopicVisibilitySelect
        topic.createdBy= params.user

        topic.validate()
        if(!topic.hasErrors()){
            topic.save(flush:true, falOnError:true)
            SubscriptionService.createSubscription(topic, topic.createdBy, SeriousnessEnum.VERY_SERIOUS)
        }
        return topic
    }

    void editTopicVisibility(topicId, newVisibility){
        Topic currTopic= Topic.findById(topicId)
        currTopic.VISIBILITY= newVisibility

        currTopic.save(flush:true, validate:false)
//        return currTopic
        //        currTopic.validate()
//        if(!currTopic.hasErrors()){
//            currTopic.save(flush:true, failOnError:true)
//        }
    }

    Topic editTopicName(topicId, newTopicName){
        Topic currTopic = Topic.findById(topicId)
        currTopic.name= newTopicName

        currTopic.validate()
        if(!currTopic.hasErrors()){
            currTopic.save(flush:true, failOnError:true)
        }
        return currTopic
    }

}
