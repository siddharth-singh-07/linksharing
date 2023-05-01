package linksharing

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ResourceController {

    ResourceService resourceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond resourceService.list(params), model:[resourceCount: resourceService.count()]
    }

    def show(Long id) {
        respond resourceService.get(id)
    }

    def create() {
        respond new Resource(params)
    }

    def save(Resource resource) {
        if (resource == null) {
            notFound()
            return
        }

        try {
            resourceService.save(resource)
        } catch (ValidationException e) {
            respond resource.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'resource.label', default: 'Resource'), resource.id])
                redirect resource
            }
            '*' { respond resource, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond resourceService.get(id)
    }

    def update(Resource resource) {
        if (resource == null) {
            notFound()
            return
        }

        try {
            resourceService.save(resource)
        } catch (ValidationException e) {
            respond resource.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'resource.label', default: 'Resource'), resource.id])
                redirect resource
            }
            '*'{ respond resource, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        resourceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'resource.label', default: 'Resource'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'resource.label', default: 'Resource'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
