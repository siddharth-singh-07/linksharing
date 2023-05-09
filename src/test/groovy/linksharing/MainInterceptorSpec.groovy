package linksharing

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class MainInterceptorSpec extends Specification implements InterceptorUnitTest<MainInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test main interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"main")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
