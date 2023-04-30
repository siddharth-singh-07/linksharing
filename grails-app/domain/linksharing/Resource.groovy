package linksharing

class Resource {

    String description
    User createdBy
    Topic topic
    Date dateCreated
    Date lastUpdated

    static hasMany = [readingItem : ReadingItem, resourceRating: ResourceRating]

    static belongsTo = [user: User]

    static constraints = {
    }

    static mapping = {
        table 'RESOURCE_TABLE'
    }
}
