package linksharing

import enums.SeriousnessEnum

class SubscriptionController {
    def SubscriptionService

    def index() {}

    def editSeriousness() {
        def topicId = params.topic
        def newSeriousness = params.seriousnessSelect
        Subscription sub = SubscriptionService.editSubscriptionSeriousness(topicId, newSeriousness, session.user)
        if (!sub.hasErrors()) {
            render status: 200, text: "Success"
        }
    }

    def deleteSubscription() {
        SubscriptionService.deleteSubscription(params.topic, session.user)
        flash.message = "Unsubscribed successfully"
        redirect(controller: 'User', action: 'dashboard')
    }

    def createSubscription() {
        def topicId = params.topicId
        def username = params.username
        def seriousness = enums.SeriousnessEnum.valueOf(params.seriousness)
        Subscription sub = SubscriptionService.createSubscription(topicId, username, seriousness)
        if (!sub.hasErrors()) {
            render status: 200, text: "Success"
        }
    }

    def inviteLink() {
        def emailHash = params.user as Long
        def topicId = params.topic as Long
        def topicCreatorHash = params.topicUser as Long
        def user = User.findByUsername(session.user.username)
        def targetTopic = Topic.findById(topicId as Long)
        def targetCreator = targetTopic?.createdBy?.username
        def targetCreatorHash = targetCreator?.hashCode()
        def targetEmailHash = session.user?.email?.hashCode()
        println topicId
        println "=============================="


        if (!targetTopic) {
            flash.warn = "Topic does not exist"
            redirect(controller: 'user', action: 'dashboard')
            return
        } else {
            if (targetCreatorHash != topicCreatorHash) {
                flash.warn = "Topic authentication failed"
                redirect(controller: 'user', action: 'dashboard')
                return
            } else {
                if (targetEmailHash != emailHash) {
                    flash.warn = "User authentication failed"
                    redirect(controller: 'user', action: 'dashboard')
                    return
                } else {
                    if (Subscription.findByUserAndTopic(user, targetTopic)) {
                        flash.warn = "You are already subscribed to the topic"
                        redirect(controller: 'user', action: 'dashboard')
                        return
                    } else {
                        def sub = SubscriptionService.createSubscription(targetTopic.id, user.username, SeriousnessEnum.SERIOUS)
                        if (sub.hasErrors()) {
                            flash.warn = "Subscription failed, please try again later"
                            redirect(controller: 'user', action: 'dashboard')
                            return
                        } else {
                            flash.message = "Successfully subscribed to the topic"
                            redirect(controller: 'topic', action: 'showTopic', params: ['id': topicId])
                        }
                    }
                }
            }
        }
    }
}
