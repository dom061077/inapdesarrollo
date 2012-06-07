package com.educacion.academico


import com.educacion.enums.inscripcion.EstadoPreinscripcion;

class Preinscripcion extends Inscripcion {
	
	EstadoPreinscripcion estado
	InscripcionMatricula inscripcionMatricula
	static constraints = {
		//alumno(unique:['carrera'])
		inscripcionMatricula(nullable:true)
	}
	
	
	
	
}
