package com.educacion.academico.exceptions

import com.educacion.academico.InscripcionMateria;

class InscripcionMateriaException extends RuntimeException{
	String message
	InscripcionMateria inscripcionMateria
	
	public InscripcionMateriaException(String message,InscripcionMateria inscripcionMateria){
		this.message = message
		this.inscripcionMateria = inscripcionMateria
	}
	
	
	
}