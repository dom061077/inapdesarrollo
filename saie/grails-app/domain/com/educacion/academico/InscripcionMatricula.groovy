package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum

class InscripcionMatricula extends Inscripcion {
	
	EstadoInscripcionMatriculaEnum estado
	
	static hasMany = [inscripcionesmaterias:InscripcionMateria]
	
    static constraints = {
    }
}
