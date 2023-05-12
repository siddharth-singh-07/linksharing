package linksharing

class TopicController {
    def TopicService

    def index() { }

    def createTopic(){
        params.user= session.user
        Topic topic = TopicService.createTopic(params)
        if(topic.hasErrors()){
            flash.object= topic
            redirect(controller: 'User', action: "dashboard")
        }
        else{
            flash.message="Topic created successfully"
            redirect(controller:'User', action: 'dashboard')
        }

    }

    def editVisibility(){
        def topicId= params.topic
        def newVisibility= params.visibilitySelect
        TopicService.editTopicVisibility(topicId, newVisibility)
//        if(topic.hasErrors()){
//            flash.object= topic
//            redirect(controller: 'User', action: "dashboard")
//        }
//        else{
            render status: 200, text: "Success"
//        }
    }

    def editTopicName(){
        def topicId= params.topicId
        def newTopicName= params.newTopicName
        Topic topic= TopicService.editTopicName(topicId, newTopicName)
        if(topic.hasErrors()){
            render status: 400, text: "You already have a topic with this name"
            return
        }
        else{
            render status: 200, text: "success"
            return
        }
    }
}
