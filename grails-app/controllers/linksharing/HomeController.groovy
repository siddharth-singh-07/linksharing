package linksharing

class HomeController {
    def ResourceService
    def ResourceRatingService

    def index() {
        if (session.user) {
            redirect(controller: 'User', action: 'dashboard')
        } else {
            List recentSharesList = ResourceService.recentShares()
            def topPostsList = ResourceRatingService.topPosts().findAll { it[1].topic.VISIBILITY == enums.VisibilityEnum.PUBLIC }.take(5)

            render(view: 'homePage', model: ['recentSharesList': recentSharesList, 'topPostsList': topPostsList])
        }
    }
}