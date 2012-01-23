import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils


class LogoutController {
	
		/**
		 * Index action. Redirects to the Spring security logout uri.
		 */
		def index = {
			// TODO  put any pre-logout code here
			log.info "INGRESANDO AL CLOSURE: index"
			redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl
		}
	}