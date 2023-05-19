package linksharing
import enums.SeriousnessEnum

class Subscription {

    SeriousnessEnum SERIOUSNESS
    Date dateCreated = new Date()

    static belongsTo = [user: User, topic: Topic]

    static constraints = {
    }

    @Override
    String toString() {
        return "linkSharing.Subscription"
    }
}
