package linksharing

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

class TopicController {
    MailSender mailSender
    def TopicService
    def ReadingItemService

    def index() {}

    def createTopic() {
        params.user = session.user
        Topic topic = TopicService.createTopic(params)
        if (topic.hasErrors()) {
            flash.object = topic
            redirect(controller: 'User', action: "dashboard")
        } else {
            flash.message = "Topic created successfully"
            redirect(controller: 'User', action: 'dashboard')
        }

    }

    def editVisibility() {
        def topicId = params.topic
        def newVisibility = params.visibilitySelect
        TopicService.editTopicVisibility(topicId, newVisibility)
//        if(topic.hasErrors()){
//            flash.object= topic
//            redirect(controller: 'User', action: "dashboard")
//        }
//        else{
        render status: 200, text: "Success"
//        }
    }

    def editTopicName() {
        def topicId = params.topicId
        def newTopicName = params.newTopicName
        Topic topic = TopicService.editTopicName(topicId, newTopicName)
        if (topic.hasErrors()) {
            render status: 400, text: "You already have a topic with this name"
            return
        } else {
            render status: 200, text: "success"
            return
        }
    }

    def showTopic() {   /*to display the topic show page*/
        def topicId = params.id as Integer
        println topicId
        println "----------------------------"
        Topic reqTopic = Topic.findById(topicId)
        println reqTopic
        println "---------------------------------------"
        List readingItemList = ReadingItemService.getAllReadingItems(session.user)
        render(view: 'topic', model: ['topicObj': reqTopic, 'readingItemList': readingItemList, 'userSubscriptionsList': reqTopic])
    }

    def sendInvite() {
        def email = params.invitationEmail
        def topicId = params.invitationTopic
        def sender = params.invitationSender
        def modal = params.modal
        Topic topic = Topic.findById(topicId as Long)
        String topicCreator = topic.createdBy.username
        def receiverEmailHash = email.hashCode()
        def topicCreatorHash = topicCreator.hashCode()

        try {
            def message = new SimpleMailMessage()
            message.setFrom('no-reply.linksharing@outlook.com')
            message.setTo(email)
            message.setSubject("Invitation for Topic ${topic.name}")
            message.setText("Hi, You have been invited by ${sender} to join the topic ${topic.name}! Please login to you LinkSharing account and click the link " +
                    "http://localhost:9090/subscription/inviteLink?user=${receiverEmailHash}&topic=${topicId}&topicUser=${topicCreatorHash}")
            mailSender.send(message)
        }
        catch (e) {
            if (modal == 'navbar') {
                flash.warn = "Invitation could not be sent"
                println e
                redirect(controller: 'user', action: 'dashboard')
                return
            } else {
                render(status: 400, text: "Invitation could not be sent")
            }
        }
        if (modal == 'navbar') {
            flash.message = "Invitation sent to ${email} for topic ${topic.name}"
            redirect(controller: 'user', action: 'dashboard')
        } else {
            render(status: 200, text: "Invitation sent to ${email} for topic ${topic.name}")
        }
    }
}
