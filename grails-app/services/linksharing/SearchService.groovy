package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class SearchService {

    def serviceMethod() {

    }

    def searchResults(searchQuery) {
        def searchResultsList = Resource.createCriteria().list {
            or {
                topic {
                    ilike("name", "%${searchQuery}%") // Match topic's name containing the search query
                }
                ilike("description", "%${searchQuery}%") // Match resource's description containing the search query}
            }
        }
        return searchResultsList
    }
}
