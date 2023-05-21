package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ReadingItemService {

    def serviceMethod() {

    }

    def addResource(Resource res) {
        res.topic.subscription.user.each { user ->
            ReadingItem readingItem = new ReadingItem(user: user, resource: res, isRead: false)
            try {
                readingItem.save(flush: true, failOnError: true)
            }
            catch (e) {
                println e
            }
        }

    }

    def getPaginatedReadingItems(User user, def offsetInput) {
        List paginatedReadingItemList = ReadingItem.createCriteria().list(max: 10, offset: offsetInput) {
            eq('user', user)
            eq('isRead', false)
        }
        return paginatedReadingItemList
    }

    def markReadingItemRead(readingItemId) {
        ReadingItem obj = ReadingItem.findById("${readingItemId}")
        obj.isRead = true
        try {
            obj.save(flush: true, failOnError: true)
        }
        catch (e) {
            println e
        }
    }

    def getAllReadingItems(User user) {
        List readingItemList = ReadingItem.createCriteria().list {
            eq('user', user)
            eq('isRead', false)
        }
        return readingItemList
    }

}
