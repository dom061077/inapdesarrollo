package com.educacion.academico

class InscripcionMatricula extends Inscripcion {
	
	static hasMany = [inscripcionesmaterias:InscripcionMateria]
	
    static constraints = {
    }
}
