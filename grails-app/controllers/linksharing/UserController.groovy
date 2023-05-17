package linksharing

class UserController {
    def TopicService
    def UserService
    def ResourceService
    def ReadingItemService

    static defaultAction = "dashboard"

    def authenticateUser() {
        def usr = params.signInUsername
        def pass = params.signInPass

        def user = User.findByUsernameOrEmail(usr, usr)
        if (user) {
            if (user.isActive) {
                if (pass == user.password) {
                    session.user = user
                    flash.message = "Welcome ${user.username}"
                    redirect(action: 'dashboard')
                    return
                } else {
                    flash.warn = "Incorrect password"
                    forward(controller: 'Home', model: ['user': user])
                    return
                }
            } else {
                flash.warn = "The user is disabled, contact administrator"
            }
        } else {
            flash.warn = "User with given email or username not found"

        }
        redirect(controller: 'Home')
    }

    def registerUser() {
        def newUser = new User()
        bindData(newUser, params, [exclude: ['firstName', 'lastName', 'photo']])
        if (params.firstName && params.lastName) {
            newUser.firstName = params.firstName.substring(0, 1).toUpperCase() + params.firstName.substring(1).toLowerCase()
            newUser.lastName = params.lastName.substring(0, 1).toUpperCase() + params.lastName.substring(1).toLowerCase()
        }
//        def passwordRe = params.passwordRe

        newUser.validate()

        if (newUser.hasErrors()) {
            forward(controller: 'Home', model: ['newUser': newUser, 'myObject': newUser])
            return
        } else {
            def userPic = request.getFile('photo')
            if (userPic && !userPic.isEmpty()) {
                String filePath = "userUploads/pfp${newUser.username}"
                new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/images/" + filePath).leftShift(userPic.getInputStream())
                newUser.photo = filePath
            } else {
                newUser.photo = 'userUploads/user.png'
            }
            newUser.save(flush: true, failOnError: true)
            flash.message = "Registration successful, Please sign in!"
            redirect(controller: 'home')
        }

    }

    def logoutUser() {
        session.invalidate()
        flash.message = "Logged out successfully"
        redirect(controller: 'Home')
    }

    def profile() {
        User targetUser = User.findByUsername(params.user)

        List userSubscriptionsList = UserService.getUserSubscriptions(targetUser)
        List userTopicsList = UserService.getUserTopics(targetUser)
        List userPublicPostsList = ResourceService.fetchUserPublicPosts(targetUser.username)
        render(view: 'profile', model: ['targetUser': targetUser, 'userSubscriptionsList': userSubscriptionsList, 'userTopicsList': userTopicsList, 'userPublicPostsList': userPublicPostsList])
    }

    def editProfile() {
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user)
        List userTopicsList = UserService.getUserTopics(session.user)
        render(view: 'editProfile', model: ['userTopicsList': userTopicsList, 'userSubscriptionsList': userSubscriptionsList])
    }

    def editUser() {
        params.photo = request.getFile('photo')
        flash.message = UserService.editUser(session.user.username, params)
        User currUser = User.findByUsername(session.user.username)
        session.user.firstName = currUser.firstName
        session.user.lastName = currUser.lastName
        session.user.photo = currUser.photo
        redirect(action: 'editProfile')
    }

    def changePass() {
        params.username = session.user.username

        if (UserService.changePass(params)) {
            flash.message = "Password changed successfully"
        } else {
            flash.warn = "New password can not be same as old password"
        }
        redirect(action: 'editProfile')
    }

    def dashboard() {
        List userSubscriptionsList = UserService.getUserSubscriptions(session.user)
        List userTopicsList = UserService.getUserTopics(session.user)
        List allReadingItemList = ReadingItemService.getAllReadingItems(session.user)
        List paginatedReadingItemList= ReadingItemService.getPaginatedReadingItems(session.user, 0)
        List trendingTopicsList = TopicService.trendingTopics()
        render(view: 'dashboard', model: ['myObject': flash.object, 'userSubscriptionsList': userSubscriptionsList, 'userTopicsList': userTopicsList, 'allReadingItemList': allReadingItemList, 'paginatedReadingItemList': paginatedReadingItemList, 'trendingTopicsList': trendingTopicsList])
    }

}
