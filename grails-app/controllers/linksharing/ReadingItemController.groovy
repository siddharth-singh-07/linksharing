package linksharing

class ReadingItemController {
    def ReadingItemService

    def index() {}

    def getNextPageInbox(def pageNum) {
        def offset = (pageNum - 1) * 20
        ReadingItemService.getReadingItems(session.user, offset)
    }

    def getNextReadingItemPage() {
        int pageNum = params.page as Integer
        int offset = (pageNum - 1) * 10
        List paginatedReadingItemList = ReadingItemService.getPaginatedReadingItems(session.user, offset)
        render(template: '/_templates/inbox', model: ['paginatedReadingItemList': paginatedReadingItemList])
    }

    def searchReadingItem() {
        def query = params.inboxSearchQuery
        List paginatedReadingItemList = ReadingItemService.searchInbox(query, session.user.username)
        render(template: '/_templates/inbox', model: ['paginatedReadingItemList': paginatedReadingItemList])
    }
}
