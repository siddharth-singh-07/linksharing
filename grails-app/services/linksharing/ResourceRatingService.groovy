package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ResourceRatingService {

    def serviceMethod() {

    }

    def fetchRating(Long resourceId) {
        def rating = ResourceRating.createCriteria().get {
            resource {
                eq('id', resourceId)
            }
            projections {
                avg('score')
            }
        }
        return rating
    }

    boolean addRating(Long resourceId, String username, Integer newScore) {
        Resource currResource = Resource.findById(resourceId)
        User currUser = User.findByUsername(username)

        ResourceRating exists = ResourceRating.findByResourceAndUser(currResource, currUser)
        if (exists) {
            exists.score = newScore
            try {
                exists.save(flush: true, failOnError: true)
            }
            catch (e) {
                println e
                return false
            }
            return true
        } else {
            ResourceRating resourceRating = new ResourceRating();
            resourceRating.user = currUser
            resourceRating.resource = currResource
            resourceRating.score = newScore

            resourceRating.validate()
            if (!resourceRating.hasErrors()) {
                try {
                    resourceRating.save(flush: true, failOnError: true)
                }
                catch (e) {
                    println e
                    return false
                }
                return true
            } else {
                println resourceRating.errors
                return false
            }
        }
    }

    def topPosts() {
        def topPostsList = ResourceRating.createCriteria().list {
            projections {
                avg("score", 'rating')
                groupProperty("resource")
            }
            order('rating', 'desc')
        }
        return topPostsList
    }
}
