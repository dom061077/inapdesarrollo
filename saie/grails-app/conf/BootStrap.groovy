import com.educacion.seguridad.User
import com.educacion.seguridad.Requestmap
import com.educacion.seguridad.Role
import com.educacion.seguridad.UserRole

class BootStrap {
	def springSecurityService
	
	void createUsers(){
		def user = User.findByUsername('admin')
		if(!user){
			def adminRole = new Role(authority:'ROLE_ADMIN').save()
			new User(username:'user',password:'user',enabled:true).save(failOnError:true)
			user=new User(username:'admin',password:'admin',enabled:true).save(failOnError:true)
			new Requestmap(url: '/js/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(failOnError:true)
			new Requestmap(url: '/css/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(failOnError:true)
			new Requestmap(url: '/images/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(failOnError:true)
			new Requestmap(url: '/login/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(failOnError:true)
			new Requestmap(url: '/logout/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(failOnError:true)
			new Requestmap(url: '/*', configAttribute:'IS_AUTHENTICATED_REMEMBERED').save(failOnError:true)
			new Requestmap(url: '/j_spring_security_switch_user',configAttribute: 'ROLE_SWITCH_USER,IS_AUTHENTICATED_FULLY').save(failOnError:true)
			new Requestmap(url: '/carrera/**',configAttribute:'ROLE_ADMIN').save(failOnError:true)
			if (!user.authorities.contains(adminRole)) {
				UserRole.create(user, adminRole)
			}
	
		}
	}
	
    def init = { servletContext ->
		createUsers()
    }
    def destroy = {
    }
}
