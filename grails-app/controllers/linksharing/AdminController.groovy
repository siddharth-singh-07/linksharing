package linksharing

class AdminController {
    def AdminService

    def index() {}

    def users() {
        List allUsersList = AdminService.fetchUsers()
        render(view: 'users.gsp', model: ['allUsersList': allUsersList])
    }

    def changeUserStatus() {
        def username = params.username
        if (AdminService.changeUserStatus(username)) {
            render(status: 200, text: "Success")
        } else {
            render(status: 500, text: "Failed")
        }
    }
}
