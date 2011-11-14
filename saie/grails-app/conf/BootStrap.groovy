import com.educacion.seguridad.User
import com.educacion.seguridad.Requestmap
import com.educacion.seguridad.Role

class BootStrap {

	
	void createUsers(){
		def user = User.findByUsername('admin')
		if(!user){
			new Requestmap(url: '/js/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/css/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/images/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/login/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/logout/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/*', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save()
			new Requestmap(url: '/profile/**', configAttribute: 'ROLE_USER').save()
			new Requestmap(url: '/admin/**', configAttribute: 'ROLE_ADMIN').save()
			new Requestmap(url: '/admin/role/**', configAttribute: 'ROLE_SUPERVISOR').save()
			new Requestmap(url: '/admin/user/**', configAttribute: 'ROLE_ADMIN,ROLE_SUPERVISOR').save()
			new Requestmap(url: '/j_spring_security_switch_user',configAttribute: 'ROLE_SWITCH_USER,IS_AUTHENTICATED_FULLY').save()
		}
	}
	
    def init = { servletContext ->
    }
    def destroy = {
    }
}
