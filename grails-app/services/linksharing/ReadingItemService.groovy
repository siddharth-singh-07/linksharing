package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ReadingItemService {

    def serviceMethod() {

    }
    def addResource(Resource res){
        res.topic.subscription.user.each{user->
            ReadingItem readingItem = new ReadingItem(user:user, resource: res, isRead: false)
            readingItem.save(flush:true, failOnError:true)
        }

    }

    def getReadingItems(User user, def offsetInput){
        List readingItemList= ReadingItem.createCriteria().list(max: 20, offset: offsetInput) {
            eq('user',user)
            eq('isRead', false)
        }
        return readingItemList
    }

    def markReadingItemRead(readingItemId){
        ReadingItem obj= ReadingItem.findById("${readingItemId}")
        obj.isRead=true
        obj.save(flush:true, failOnError:true)
    }

    def getAllReadingItems(User user){
        List readingItemList= ReadingItem.createCriteria().list {
            eq('user',user)
            eq('isRead', false)
        }
        return readingItemList
    }

}
