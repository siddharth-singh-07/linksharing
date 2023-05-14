package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class AdminService {

    def serviceMethod() {

    }

    List fetchUsers() {
        List allUsers = User.createCriteria().list {
        }
        return allUsers
    }

    boolean changeUserStatus(username){
        User user= User.findByUsername(username)
        if(user){
            user.isActive = !user.isActive
            user.save(flush:true, failOnError:true, validate:false)
            return true
        }
        return false
    }
}
