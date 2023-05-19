package linksharing

class SearchController {
    def TopicService
    def SearchService
    def ReadingItemService
    def UserService
    def ResourceRatingService

    def index() {
        List trendingTopicsList = TopicService.trendingTopics()
        List readingItemList = ReadingItemService.getAllReadingItems(session.user)
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user)
        List searchResultsList = SearchService.searchResults(params.searchQuery)
        def topPostsList = ResourceRatingService.topPosts()

        def searchResults
        def topPosts
        if (session.user) {
            if (session.user.isAdmin) {
                searchResults = searchResultsList
                topPosts = topPostsList.take(5)
            } else {
                searchResults = searchResultsList.findAll { it.topic.subscription.user.username == session.user.username || it.topic.VISIBILITY == enums.VisibilityEnum.PUBLIC }
                topPosts = topPostsList.findAll { it[1].topic.subscription.user.username == session.user.username || it[1].topic.VISIBILITY == enums.VisibilityEnum.PUBLIC }.take(5)
            }
        } else {
            searchResults = searchResultsList.findAll { it.topic.VISIBILITY == enums.VisibilityEnum.PUBLIC }
            topPosts = topPostsList.findAll {it[1].topic.VISIBILITY == enums.VisibilityEnum.PUBLIC}.take(5)
        }

        if (params.searchQuery.trim() == "" && (!session.user || !session.user?.isAdmin)) {
            flash.warn = "Can not search with empty input"
            render(view: 'search', model: ['trendingTopicsList': trendingTopicsList, 'searchQuery': params.searchQuery, 'readingItemList': readingItemList, 'userSubscriptionsList': userSubscriptionsList, 'topPostsList': topPosts])
        } else {
            render(view: 'search', model: ['trendingTopicsList': trendingTopicsList, 'searchResultsList': searchResults, 'searchQuery': params.searchQuery, 'readingItemList': readingItemList, 'userSubscriptionsList': userSubscriptionsList, 'topPostsList': topPosts])
        }
    }

}
