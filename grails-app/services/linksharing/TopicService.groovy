package linksharing

import grails.gorm.services.Service

@Service(Topic)
interface TopicService {

    Topic get(Serializable id)

    List<Topic> list(Map args)

    Long count()

    void delete(Serializable id)

    Topic save(Topic topic)

}