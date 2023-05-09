package enums

public enum VisibilityEnum {
    PUBLIC("Public"),
    PRIVATE("Private")

    final String value
    VisibilityEnum(String value){
        this.value =value
    }

    String toString(){
        value
    }

    String getKey(){
        name()
    }
}
