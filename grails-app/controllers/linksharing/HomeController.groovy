package linksharing

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class HomeController {
    def ResourceService

    def index() {
        if (session.user) {
            redirect(controller: 'User', action: 'dashboard')
        } else {
            List recentSharesList = ResourceService.recentShares()

            render(view: 'homePage', model: ['recentSharesList': recentSharesList])
        }
    }
}