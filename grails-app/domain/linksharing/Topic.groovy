package linksharing
import enums.VisibilityEnum


class Topic {

    String name
    Date dateCreated
    Date lastUpdate
    VisibilityEnum VISIBILITY
    Boolean isDeleted

    static hasMany = [subscription: Subscription, resourse: Resource]

    static belongsTo = [user: User, subscription: Subscription, resource: Resource]

    static constraints = {
        name blank: false


    }
}
