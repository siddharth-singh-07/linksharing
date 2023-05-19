package linksharing

class AuditLog {

    User user
    Date timestamp
    String instanceType
    Long objectId

    static constraints = {
        timestamp(nullable: false)
        user(nullable: false)
    }
}
