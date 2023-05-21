package linksharing

class ReadingItem {

    Boolean isRead

    static belongsTo = [user: User, resource: Resource]

    static constraints = {
    }

    @Override
    String toString() {
        return "linkSharing.ReadingItem"
    }
}
