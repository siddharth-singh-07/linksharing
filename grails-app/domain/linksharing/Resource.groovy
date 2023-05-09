package linksharing

class Resource {

    String description
    Date dateCreated =new Date()
    Date lastUpdated =new Date()

    static hasMany = [readingItem : ReadingItem, resourceRating: ResourceRating]

    static belongsTo = [createdBy: User, topic: Topic]

    static constraints = {
    }

    static mapping = {
        table 'RESOURCE_TABLE'
    }
}
