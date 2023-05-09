package linksharing
import grails.validation.*

class User {

    String email
    String username
    String password
    String firstName
    String lastName
    String photo
    Boolean isAdmin = false
    Boolean isActive = true
    Date dateCreated = new Date()
    Date lastUpdated = new Date()

    static hasMany = [
            topic : Topic, subscription : Subscription,
            readingItem : ReadingItem, resouce: Resource,
            resourceRating: ResourceRating
    ]

    static belongsTo = []

    static constraints = {
        email email: true, validator: {val, obj ->
            if(User.findByEmail(val)) {
                return "linkSharing.duplicateEmail"
            }
        }

        username blank: false, validator: {val, obj ->
            if(User.findByUsername(val)) {
                return "linkSharing.duplicateUsername"
            }
        }

        password(blank: false, minSize: 5)
        firstName(blank: false)
        lastName(blank: false, nullable: false)
        photo(nullable:true)
    }

    static mapping = {
        table 'USER_TABLE'
    }

//    def validateName(val){
//        val.each{
//            if(it.isNumber())
//                throw new ValidationException("First Name and Last Name can only contain characters")
//        }
//    }
}
