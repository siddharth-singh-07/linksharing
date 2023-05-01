package linksharing
import enums.VisibilityEnum


class Topic {

    String name
//    User createdBy
    Date dateCreated= new Date()
    Date lastUpdate = new Date()
    VisibilityEnum VISIBILITY
    Boolean isDeleted = false

    static hasMany = [subscription: Subscription, resourse: Resource]

    static belongsTo = [createdBy: User]
    //subscription: Subscription, resource: Resource

    static constraints = {
        name blank: false


    }
}
