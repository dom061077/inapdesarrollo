package com.educacion.academico

class Nivel {
	
	String descripcion
	Carrera carrera
	
	static belongsTo=[carrera:Carrera]

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
}
