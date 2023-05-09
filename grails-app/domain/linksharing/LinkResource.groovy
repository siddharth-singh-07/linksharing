package linksharing

class LinkResource extends Resource{

    String url

    static constraints = {
        url blank: false, nullable: false, URL: true
        description blank: false, nullable: false

    }
}
