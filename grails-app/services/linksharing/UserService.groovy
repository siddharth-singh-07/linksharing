package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UserService {

    def serviceMethod() {

    }

    List getUserSubscriptions(User user){
        List userSubscriptionsList = Subscription.createCriteria().list {
            eq('user', user)
        }
        return userSubscriptionsList
    }

    def getUserTopics(User user){
        List userTopicsList= Topic.createCriteria().list {
            eq('createdBy', user)
        }
        return userTopicsList
    }

}
