package linksharing

import grails.gorm.transactions.Transactional
import org.hibernate.Hibernate

@Transactional
class AuditLogService {

    def serviceMethod() {

    }

    boolean createLog(Object object, User user) {
        AuditLog log = new AuditLog()
        log.user = user
        log.instanceType = object.toString()
        log.objectId= object.id
        log.timestamp = new Date()

        try {
            log.save(flush: true, failOnError: true, validate: false)
        }
        catch (e) {
            println e
            return false
        }
        return true
    }
}
