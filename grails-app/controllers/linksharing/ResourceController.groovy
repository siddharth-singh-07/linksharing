package linksharing

class ResourceController {
    def ResourceService

    def index() {}

    def createLinkResource() {
        params.user = session.user
        Resource linkResource = ResourceService.createLinkResource(params)
        if (linkResource.hasErrors()) {
            flash.object = linkResource
            redirect(controller: 'User', action: "dashboard")
        } else {
            flash.message = "Link shared in ${linkResource.topic.name} successfully"
            redirect(controller: 'User', action: 'dashboard')
        }
    }

    def createDocumentResource() {
        params.user = session.user
        params.file = request.getFile('modalShareDocFileInput')
        Resource documentResource = ResourceService.createDocumentResource(params)
        documentResource.validate()
        if (documentResource.hasErrors()) {
            flash.object = documentResource
            redirect(controller: 'User', action: "dashboard")
        } else {
            flash.message = "Document shared in ${documentResource.topic.name} successfully"
            redirect(controller: 'User', action: 'dashboard')
        }
    }
}
