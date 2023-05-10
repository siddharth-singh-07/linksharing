package linksharing

class UserController {
    def TopicService
    def UserService

    static defaultAction = "dashboard"

    def authenticateUser(){
        def usr= params.signInUsername
        def pass= params.signInPass

        def user= User.findByUsernameOrEmail(usr, usr)
        if(user){
            if(user.isActive) {
                if (pass == user.password) {
                    session.user = user
                    flash.message = "Welcome ${user.username}"
                    redirect(action: 'dashboard')
                    return
                }
                else {
                    flash.warn = "Incorrect password"
                    forward(controller: 'Home', model: ['user': user])
                    return
                }
            }
            else{
                flash.warn = "The user is disabled, contact administrator"
            }
        }
        else{
            flash.warn= "User with given email or username not found"

        }
        redirect(controller: 'Home')
    }

    def registerUser() {
        def newUser = new User()
        bindData(newUser, params, [exclude: ['firstName', 'lastName', 'photo']])
        if(params.firstName && params.lastName) {
            newUser.firstName = params.firstName.substring(0, 1).toUpperCase() + params.firstName.substring(1).toLowerCase()
            newUser.lastName = params.lastName.substring(0, 1).toUpperCase() + params.lastName.substring(1).toLowerCase()
        }
//        def passwordRe = params.passwordRe

        newUser.validate()

        if (newUser.hasErrors()) {
            forward(controller: 'Home', model: ['newUser': newUser, 'myObject':newUser])
            return
        }
        else {
                def userPic= request.getFile('photo')
                if(userPic && !userPic.isEmpty()){
                    String filePath= "userUploads/pfp${newUser.username}"
                    new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/images/"+filePath).leftShift(userPic.getInputStream())
                    newUser.photo= filePath
                }
                else{
                    newUser.photo= 'userUploads/user.png'
                }
            newUser.save(flush: true, failOnError: true)
            flash.message= "Registration successful, Please sign in!"
            redirect(controller: 'home')
        }

    }

    def logoutUser(){
        session.invalidate()
        flash.message="Logged out successfully"
        redirect(controller: 'Home')
    }

    def dashboard() {
        List userSubscriptionsList= UserService.getUserSubscriptions(session.user)
        List userTopicsList= UserService.getUserTopics(session.user)

        render(view: 'dashboard', model: ['myObject':flash.object, 'userSubscriptionsList':userSubscriptionsList, 'userTopicsList': userTopicsList])
    }

}
