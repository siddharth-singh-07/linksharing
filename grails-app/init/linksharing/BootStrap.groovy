package linksharing

class BootStrap {

    def init = { servletContext ->

        def admin_user= new User(email: "siddharthsingh0705@gmail.com", username: "admin", password: "Admin123", firstName: "Siddharth", lastName: "Singh", photo: "icons/user.png", isAdmin:"true").save(flush: true, failOnError: true)
        def user1= new User(email: "user1@gmail.com", username: "user1", password: "user1", firstName: "Test1", lastName: "One", photo: "icons/user.png", lastUpdated: new Date()).save()
        def user2= new User(email: "user2@gmail.com", username: "user2", password: "user2", firstName: "Test2", lastName: "Two", photo: "icons/user.png", lastUpdated: new Date()).save()
        def user3= new User(email: "user3@gmail.com", username: "user3", password: "user3", firstName: "Test3", lastName: "Three", photo: "icons/user.png", lastUpdated: new Date()).save()
        def user4= new User(email: "user4@gmail.com", username: "user4", password: "user4", firstName: "Test4", lastName: "Four", photo: "icons/user.png", lastUpdated: new Date()).save(flush: true, failOnError: true)


        def topic1 = new Topic(name: "Topic 1", createdBy: 1, VISIBILITY: 'PUBLIC').save()
        def topic2 = new Topic(name: "Topic 2", createdBy: 2, VISIBILITY: 'PUBLIC').save()
        def topic3 = new Topic(name: "Topic 3", createdBy: 3, VISIBILITY: 'PUBLIC').save()
        def topic4 = new Topic(name: "Topic 4", createdBy: 4, VISIBILITY: 'PUBLIC').save(flush: true, failOnError: true)

        def sub1= new Subscription(user:1, topic:6, SERIOUSNESS: 'CASUAL').save()
        def sub2= new Subscription(user:1, topic:7, SERIOUSNESS: 'CASUAL').save()
        def sub3= new Subscription(user:2, topic:6, SERIOUSNESS: 'VERY_SERIOUS').save()
        def sub4= new Subscription(user:3, topic:6, SERIOUSNESS: 'SERIOUS').save()
        def sub5= new Subscription(user:4, topic:6, SERIOUSNESS: 'CASUAL').save(flush: true, failOnError: true)

        Resource res1= new LinkResource(topic: topic1, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: admin_user, url:"google.co.in").save()
        Resource res2= new LinkResource(topic: topic2, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu", createdBy: admin_user, url:"google.co.in").save()
        Resource res3= new LinkResource(topic: topic3, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: admin_user, url:"google.co.in").save()
        Resource res4= new LinkResource(topic: topic3, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: admin_user, url:"google.co.in").save()
        Resource res5= new LinkResource(topic: topic1, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: user4, url:"google.co.in").save()
        Resource res6= new LinkResource(topic: topic4, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: user3, url:"google.co.in").save()
        Resource res7= new DocumentResource(topic: topic1, description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu,", createdBy: user2, filePath: "google.co.in").save(flush:true, failOnError:true)

        def resRat1= new ResourceRating(resource:res1, user:user1, score:"2").save()
        def resRat2= new ResourceRating(resource:res2, user:user2, score:"3").save()
        def resRat3= new ResourceRating(resource:res3, user:user1, score:"4").save()
        def resRat4= new ResourceRating(resource:res4, user:user2, score:"3").save()
        def resRat5= new ResourceRating(resource:res5, user:user1, score:"2").save()
        def resRat6= new ResourceRating(resource:res6, user:user2, score:"5").save()
        def resRat7= new ResourceRating(resource:res7, user:user1, score:"2").save()

        def resRat8= new ResourceRating(resource:res1, user:user3, score:"1").save()
        def resRat9= new ResourceRating(resource:res2, user:user4, score:"2").save()
        def resRat10= new ResourceRating(resource:res3, user:user3, score:"3").save()
        def resRat11= new ResourceRating(resource:res4, user:user4, score:"4").save()
        def resRat12= new ResourceRating(resource:res5, user:user3, score:"4").save()
        def resRat13= new ResourceRating(resource:res6, user:user4, score:"2").save()
        def resRat14= new ResourceRating(resource:res7, user:user3, score:"3").save(flush:true, failOnError:true)

    }

    def destroy = {
    }
}
