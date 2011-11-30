package com.educacion.academico

class Nivel {
	
	String descripcion
	Carrera carrera
	
	static belongTo=[carrera:Carrera]

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
}
