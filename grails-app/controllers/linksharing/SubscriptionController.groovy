package linksharing

class SubscriptionController {
    def SubscriptionService

    def index() { }

    def editSeriousness(){
        def topicId= params.topic
        def newSeriousness= params.seriousnessSelect
        Subscription sub = SubscriptionService.editSubscriptionSeriousness(topicId, newSeriousness, session.user)
        if(sub.hasErrors()){
            flash.object= sub
            redirect(controller: 'User', action: "dashboard")
        }
        else{
            flash.message="Subscription seriousness edited successfully"
            redirect(controller:'User', action: 'dashboard')
        }
    }

    def deleteSubscription(){
        SubscriptionService.deleteSubscription(params.topic, session.user)
        redirect(controller:'User', action: 'dashboard')
    }
}
