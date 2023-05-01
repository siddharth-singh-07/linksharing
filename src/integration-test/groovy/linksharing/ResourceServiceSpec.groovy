package linksharing

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ResourceServiceSpec extends Specification {

    ResourceService resourceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Resource(...).save(flush: true, failOnError: true)
        //new Resource(...).save(flush: true, failOnError: true)
        //Resource resource = new Resource(...).save(flush: true, failOnError: true)
        //new Resource(...).save(flush: true, failOnError: true)
        //new Resource(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //resource.id
    }

    void "test get"() {
        setupData()

        expect:
        resourceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Resource> resourceList = resourceService.list(max: 2, offset: 2)

        then:
        resourceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        resourceService.count() == 5
    }

    void "test delete"() {
        Long resourceId = setupData()

        expect:
        resourceService.count() == 5

        when:
        resourceService.delete(resourceId)
        sessionFactory.currentSession.flush()

        then:
        resourceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Resource resource = new Resource()
        resourceService.save(resource)

        then:
        resource.id != null
    }
}
