package linksharing

import grails.gorm.services.Service

@Service(Resource)
interface ResourceService {

    Resource get(Serializable id)

    List<Resource> list(Map args)

    Long count()

    void delete(Serializable id)

    Resource save(Resource resource)

}