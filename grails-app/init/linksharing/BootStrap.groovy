package linksharing

import enums.VisibilityEnum

class BootStrap {

    def init = { servletContext ->
    User admin_user= new User()
        admin_user.email= "siddharth@gmail.com"
        admin_user.username= "admin"
        admin_user.password= "admin"
        admin_user.firstName= "Siddharth"
        admin_user.lastName= "Singh"
        admin_user.photo= "xyz.com"
        admin_user.admin= true
        admin_user.active= true
        admin_user.dateCreated= new Date()
        admin_user.lastUpdated= new Date()



    }
    def destroy = {
    }
}
