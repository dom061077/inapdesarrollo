package com.educacion.academico

class Nivel {
	
	String descripcion
	Carrera carrera
	boolean esprimernivel = false
	
	static belongsTo=[carrera:Carrera]
	
	static hasMany = [materias:Materia]

    static constraints = {
		descripcion(nullable:false,blank:false)
    }
	
	static mapping = {
		carrera lazy:false
		materias cascade: 'save-update'
		materias lazy:false
		materias sort:'denominacion'
	}
}
