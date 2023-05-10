package linksharing

import grails.gorm.transactions.Transactional
import org.hibernate.sql.JoinType

@Transactional
class UserService {

    def serviceMethod() {

    }

    List getUserSubscriptions(User user){
        List userSubscriptionsList = Topic.createCriteria().listDistinct {
            subscription {
                eq('user', user)
            }
            createAlias('resource', 'r', JoinType.LEFT_OUTER_JOIN)
            order('r.dateCreated', 'desc')
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
