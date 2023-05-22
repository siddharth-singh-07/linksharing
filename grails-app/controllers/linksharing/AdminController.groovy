package linksharing

class AdminController {
    def AdminService
    def TopicService
    def UserService
    def ResourceService

    def index() {}

    def users() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user.username)
        List allUsersList = AdminService.fetchUsers()
        render(view: 'users', model: ['allUsersList': allUsersList, 'userSubscriptionsList': userSubscriptionsList])
    }

    def changeUserStatus() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        def username = params.username
        if (AdminService.changeUserStatus(username)) {
            render(status: 200, text: "Success")
        } else {
            render(status: 500, text: "Failed")
        }
    }

    def topics() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user.username)
        List allTopicsList = AdminService.fetchTopics()
        render(view: 'topics.gsp', model: ['allTopicsList': allTopicsList, 'userSubscriptionsList': userSubscriptionsList])
    }

    def deleteTopic() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        if (TopicService.deleteTopic(session.user.username, params.topicId as Long)) {
            flash.message = "Topic deleted successfully"
        } else {
            flash.warn = "Topic deletion failed"
        }
        redirect(action: 'topics')
    }

    def posts() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user.username)
        List allPostsList = AdminService.fetchPosts()
        render(view: 'posts.gsp', model: ['allPostsList': allPostsList, 'userSubscriptionsList': userSubscriptionsList])
    }

    def deletePost() {
        if (!session.user.isAdmin) {
            flash.warn = "You don't have access to that web page"
            redirect(controller: 'user', action: 'dashboard')
            return
        }
        if (ResourceService.deleteResource(session.user.username, params.resourceId as Long)) {
            flash.message = "Resource deleted successfully"
        } else {
            flash.warn = "Resource deletion failed"
        }
        redirect(action: 'posts')
    }
}
