package linksharing

class ResourceRating {

    Resource resource
    User user
    Integer score

    static belongsTo = [resource: Resource, user: User]

    static constraints = {
    }
}
