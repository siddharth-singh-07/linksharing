package linksharing

class SubscriptionController {
    def SubscriptionService

    def index() { }

    def editSeriousness(){
        def topicId= params.topic
        def newSeriousness= params.seriousnessSelect
        Subscription sub = SubscriptionService.editSubscriptionSeriousness(topicId, newSeriousness, session.user)
        if (!sub.hasErrors()) {
            render status: 200, text: "Success"
        }
    }

    def deleteSubscription(){
        SubscriptionService.deleteSubscription(params.topic, session.user)
        flash.message= "Unsubscribed successfully"
        redirect(controller:'User', action: 'dashboard')
    }

    def createSubscription(){
        def topicId= params.topicId
        def username= params.username
        def seriousness= enums.SeriousnessEnum.valueOf(params.seriousness)
        Subscription sub = SubscriptionService.createSubscription(topicId, username, seriousness)
        if(!sub.hasErrors()){
            render status: 200, text: "Success"
        }
    }
}
