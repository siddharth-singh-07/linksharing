package linksharing

class ReadingItemController {
    def ReadingItemService

    def index() { }

    def getNextPageInbox(def pageNum){
        def offset = (pageNum-1)*20
        ReadingItemService.getReadingItems(session.user, offset)
    }
}
