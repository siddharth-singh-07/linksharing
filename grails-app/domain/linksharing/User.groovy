package linksharing

class User {

    String email
    String username
    String password
    String firstName
    String lastName
    String photo
    Boolean admin = false
    Boolean active =true
    Date dateCreated =new Date()
    Date lastUpdated =new Date()
    static hasMany = [topic : Topic, subscription : Subscription,
                      readingItem : ReadingItem, resouce: Resource,
                      resourceRating: ResourceRating]

    static belongsTo = []

    static constraints = {
        email(unique: true, email: true)
        username(blank: false, unique: true)
        password(blank: false)
        password validator:{ val, obj ->
            if(val.length() < 7)
                return false;

            boolean upper=false, lower=false

            for(int i=0; i<val.length(); i++){
                def c= val.charAt(i)
                if(Character.isUpperCase(c))
                    upper=true
                if(Character.isLowerCase(c))
                    lower=true
            }
            if(!upper || !lower)
                return false

        }
        firstName(blank: false, nullable: false)
        lastName(blank: false, nullable: false)
        photo(nullable:true)

    }
    static mapping = {
        table 'USER_TABLE'

    }
}
