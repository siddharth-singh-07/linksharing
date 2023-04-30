package linksharing

class User {

    String email
    String username
    String password
    String firstName
    String lastName
    String photo
    Boolean admin
    Boolean active
    Date dateCreated
    Date lastUpdated
    static hasMany = [topic : Topic, subscription : Subscription,
                      readingItem : ReadingItem, resouce: Resource]

    static belongsTo = []

    static constraints = {
        email email: true, blank: false
        username blank: false, unique: true
        password blank: false

    }
    static mapping = {
        table 'USER_TABLE'
    }
}
