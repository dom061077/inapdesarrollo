package com.educacion.academico.exceptions

import com.educacion.academico.InscripcionMateria;

class InscripcionMateriaException extends RuntimeException{
	String code
	InscripcionMateria inscripcionMateria
	
	public InscripcionMateriaException(String code,InscripcionMateria inscripcionMateria){
		this.code = code
		this.inscripcionMateria = inscripcionMateria
	}
	
	
	
}