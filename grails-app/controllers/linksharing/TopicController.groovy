package linksharing

class TopicController {
    def TopicService

    def index() { }

    def createTopic(){
        params.user= session.user
        Topic topic = TopicService.createTopic(params)
        if(topic.hasErrors()){
//            flash.object= topic
            redirect(controller: 'User', action: "dashboard")
        }
        else{
            flash.message="Topic created successfully"
            redirect(controller:'User', action: 'dashboard')
        }

    }
}
