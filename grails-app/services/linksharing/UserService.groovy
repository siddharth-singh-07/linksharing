package linksharing

import grails.gorm.transactions.Transactional
import org.hibernate.sql.JoinType

@Transactional
class UserService {

    def serviceMethod() {

    }

    List getUserSubscriptions(String username) {
        User user = User.findByUsername(username)
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
        String fileExtension = params.originalFilename.substring(params.originalFilename.lastIndexOf('.') + 1).toLowerCase()

        if (photo && !photo.isEmpty()) {
            if (!(fileExtension in ['jpg', 'jpeg', 'png'])) {
                return "Uploaded file must be an image"
            }

            String filePath = "userUploads/pfp${currUsername}"
            File file = new File("/home/lt-siddharths/LinkSharing/grails-app/assets/images/" + filePath)
            if (file.exists()) {
                file.delete()
            }
            new FileOutputStream("/home/lt-siddharths/LinkSharing/grails-app/assets/images/" + filePath).leftShift(photo.getInputStream())
            currUser.photo = filePath
        }
        try {
            currUser.save(flush: true, validate: false)
        }
        catch (e) {
            println e
            return "Failed"
        }
        return "User details successfully changed"
    }

    def changePass(params) {
        User user = User.findByUsername(params.username)
        if (params.password == user.password) {
            return false
        }
        user.password = params.password
        try {
            user.save(flush: true, validate: false)
        }
        catch (e) {
            println e
            return false
        }
        return true
    }

}
