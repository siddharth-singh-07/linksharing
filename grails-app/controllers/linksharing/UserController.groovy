package linksharing

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def authenticateUser(){
        def usr= params.signInUsername
        def pass= params.signInPass

        def user= User.findByUsernameOrEmail(usr, usr)
        if(user){
            if(pass == user.password){
                session.userId = user.username
//                redirect(controller: 'User', action: '')
                render(view: 'dashboard')
            }
            else{
                flash.error= "Incorrect password"
                render(view: '/home/homePage')
            }
        }
        else{
            flash.error= "User with given email or username not found"
            render(view: '/home/homePage')
        }
    }

    def registerUser(){
        def newUser= new User(params)
        newUser.firstName= params.firstName.substring(0, 1).toUpperCase() + params.firstName.substring(1).toLowerCase()
        newUser.lastName= params.firstName.substring(0, 1).toUpperCase() + params.firstName.substring(1).toLowerCase()
        def passwordRe= params.passwordRe
        try{
            newUser.validate()
        }
        catch (javax.validation.ValidationException e) {
            if(e.getMessage() == "duplicate"){
                flash.message="The username has already been taken"
                render(view: '/home/homePage')
                return
            }
        }
        if(newUser.password != passwordRe){
            flash.message= "Confirm password does not match"
            render(view: '/home/homePage')
            return
        }

        newUser.save(flush:true, failOnError:true)
        flash.message= "Success"
        render(view: '/home/homePage')

    }


    UserService userService



    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond userService.list(params), model:[userCount: userService.count()]
    }

    def show(Long id) {
        respond userService.get(id)
    }

    def create() {
        respond new User(params)
    }

    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond userService.get(id)
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        userService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
