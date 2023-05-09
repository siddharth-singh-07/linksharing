package linksharing

class MainInterceptor {
     MainInterceptor(){
        matchAll().excludes(controller: 'home', action: "*")
                .excludes(controller:'user', action:"authenticateUser")
                .excludes(controller: "user", action:"registerUser")
    }

    boolean before() {
        if (!session.user) {
            flash.warn= "Please login to access the application"
            redirect(controller: 'home')
            return false
        }
        else {
            return true
        }
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}