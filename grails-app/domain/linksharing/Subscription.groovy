package linksharing
import enums.SeriousnessEnum

class Subscription {

//    Topic topic
//    User user
    SeriousnessEnum SERIOUSNESS
    Date dateCreated = new Date()

    static belongsTo = [user: User, topic: Topic]

    static constraints = {
    }
}
