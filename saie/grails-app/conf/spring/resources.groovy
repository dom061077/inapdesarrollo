// Place your Spring DSL code here
import org.springframework.security.web.authentication.session.ConcurrentSessionControlStrategy 
import org.springframework.security.web.session.ConcurrentSessionFilter 
import org.springframework.security.core.session.SessionRegistryImpl 
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy

beans = { 

        sessionRegistry(SessionRegistryImpl) 

        sessionAuthenticationStrategy(ConcurrentSessionControlStrategy, sessionRegistry) { 
                maximumSessions = -1 
        } 

        concurrentSessionFilter(ConcurrentSessionFilter){ 
                sessionRegistry = sessionRegistry 
                expiredUrl = '/login/concurrentSession' 
        } 
} 