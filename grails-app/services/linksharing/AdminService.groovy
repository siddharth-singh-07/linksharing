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
            try{
                user.save(flush:true, failOnError:true, validate:false)
            }
            catch (e){
                println e
                return false
            }
            return true
        }
        return false
    }
}
