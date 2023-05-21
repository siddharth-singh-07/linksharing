package linksharing

class MainInterceptor {
    MainInterceptor() {
        matchAll().excludes(controller: 'home', action: "*")
                .excludes(controller: 'user', action: "authenticateUser")
                .excludes(controller: "user", action: "registerUser")
                .excludes(controller: 'user', action: 'forgotPasswordTrigger')
                .excludes(controller: 'user', action: 'resetPassword')
                .excludes(controller: 'search', index: "index")
                .excludes(controller: 'resource', index: 'viewPost')
                .excludes(controller: 'resourceRating', index: 'fetchCurrentRating')
                .excludes(controller: 'topic', index: 'showTopic')
    }

    boolean before() {
        if (!session.user) {
            flash.warn = "Please login to access the application"
            redirect(controller: 'home')
            return false
        } else {
            return true
        }
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}