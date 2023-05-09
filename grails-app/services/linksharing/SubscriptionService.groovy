package linksharing

import enums.SeriousnessEnum
import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionService {

    def serviceMethod() {

    }

    boolean createSubscription(Topic topic, User user, SeriousnessEnum seriousness){
        Subscription sub= new Subscription()
        sub.topic= topic
        sub.user=user
        sub.SERIOUSNESS= seriousness

        sub.validate()
        if(sub.hasErrors()){
            return false
        }
        else{
            sub.save(flush:true, failOnError:true)
            return true
        }

    }
}
