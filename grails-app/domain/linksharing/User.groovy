package linksharing

import com.sun.org.apache.bcel.internal.generic.LDIV

import javax.validation.ValidationException

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
        username(blank: false, validator: {
            if(User.findByUsername(it))
                throw new ValidationException("duplicate")
//                return "duplicate"
        })
//        throws DataIntegrityViolationException
        password(blank: false)
        password validator:{ val->
            if(val.length() < 7)
                return false
//                throw new ValidationException("Password length is less than 7")

            boolean upper=false, lower=false, num= false
            val.each{
                if(Character.isUpperCase((char)it)) upper=true
                if(Character.isLowerCase((char)it)) lower=true
                if((String)it.isNumber()) num=true
            }
            if(!upper || !lower || !num)
                return false
//                throw new ValidationException("Password should contain at least 1 lower case, 1 upper case and 1 number")
        }
        firstName(blank: false, nullable: false)
//        validator: {validateName(it)}
        lastName(blank: false, nullable: false)
        photo(nullable:true)

    }
    static mapping = {
        table 'USER_TABLE'

    }

//    def validateName(val){
//        val.each{
//            if(it.isNumber())
//                throw new ValidationException("First Name and Last Name can only contain characters")
//        }
//    }
}
