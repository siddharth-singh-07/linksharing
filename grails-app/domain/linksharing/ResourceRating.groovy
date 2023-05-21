package linksharing

class ResourceRating {

    Integer score

    static belongsTo = [resource: Resource, user: User]

    static constraints = {

    }

    @Override
    String toString() {
        return "linkSharing.ResourceRating"
    }
}
