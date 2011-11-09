package com.educacion.academico

class Nivel {
	
	String descripcion

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
}
