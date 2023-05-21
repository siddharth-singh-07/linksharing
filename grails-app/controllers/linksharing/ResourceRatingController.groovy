package linksharing

import grails.converters.JSON

class ResourceRatingController {
    def ResourceRatingService

    def index() { }

    def fetchCurrentRating(){
        Long resourceId= params.id as Long
        def avgRating= ResourceRatingService.fetchRating(resourceId)
        def ratingResponse = [rating: Math.round(avgRating ?: 0)]
        render ratingResponse as JSON
    }

    def addRating(){
        Long resourceId= params.id as Long
        Integer score= params.score as Integer
        if(ResourceRatingService.addRating(resourceId, session.user.username, score)){
            render status: 200, text: "Success"
        }
        else{
            render status: 400, text: "Failed"
        }

    }
}
