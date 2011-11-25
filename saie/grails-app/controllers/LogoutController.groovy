class LogoutController {
	
		/**
		 * Index action. Redirects to the Spring security logout uri.
		 */
		def index = {
			// TODO  put any pre-logout code here
			log.info "INGRESANDO AL CLOSURE: index"
			redirect(uri: '/j_spring_security_logout')
		}
	}