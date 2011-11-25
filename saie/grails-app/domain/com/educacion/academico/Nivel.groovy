package com.educacion.academico

class Nivel {
	
	String descripcion
	
	static belongTo=[carrera:Carrera]

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
}
