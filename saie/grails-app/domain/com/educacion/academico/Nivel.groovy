package com.educacion.academico

class Nivel {
	
	String descripcion
	Carrera carrera
	
	static belongsTo=[carrera:Carrera]
	
	static hasMany = [materias:Materia]

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
}
