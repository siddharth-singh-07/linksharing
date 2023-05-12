package linksharing

import grails.gorm.transactions.Transactional
import org.hibernate.sql.JoinType

@Transactional
class UserService {

    def serviceMethod() {

    }

    List getUserSubscriptions(User user) {
        List userSubscriptionsList = Topic.createCriteria().listDistinct {
            subscription {
                eq('user', user)
            }
            createAlias('resource', 'r', JoinType.LEFT_OUTER_JOIN)
            order('r.dateCreated', 'desc')
        }
        return userSubscriptionsList
    }

    def getUserTopics(User user) {
        List userTopicsList = Topic.createCriteria().list {
            eq('createdBy', user)
        }
        return userTopicsList
    }

    def editUser(currUsername, params) {
        User currUser = User.findByUsername(currUsername)
        currUser.firstName = params.firstName
        currUser.lastName = params.lastName
        def photo = params.photo
        if (photo && !photo.isEmpty()){
            String filePath = "userUploads/pfp${currUsername}"
            File file = new File("/home/lt-siddharths/LinkSharing/grails-app/assets/images/" + filePath)
            if(file.exists()){
                file.delete()
            }
            new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/images/" + filePath).leftShift(photo.getInputStream())
            currUser.photo = filePath
        }
        currUser.save(flush: true, validate: false)
        return "User details successfully changed"
    }

    def changePass(params){
        User user= User.findByUsername(params.username)
        if(params.password==user.password){
            return false
        }
        user.password= params.password
        user.save(flush:true, validate:false)
        return true
    }

}
