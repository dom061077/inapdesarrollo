package com.educacion.seguridad

class Role {

	String authority

	static hasMany=[requests:Requestmap]
	
	static mapping = {
		cache true
		requests(cascade: 'save-update')
	}
	
	

	static constraints = {
		authority blank: false,nullable:false, unique: true, validator:{current,obj->
			if(current.equals('ROLE_'))
				return false
			return true
		}
	}
	
	def beforeInsert(){
		authority = 'ROLE_'+authority
	}
	
	def beforeUpdate(){
		authority = authority.replace('ROLE_','')
		authority = 'ROLE_'+authority
	}
}
