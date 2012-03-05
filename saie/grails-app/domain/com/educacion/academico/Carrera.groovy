package com.educacion.academico

import com.educacion.enums.ModalidadFormacionEnum

class Carrera {

	String denominacion
	Integer duracion
	ModalidadFormacionEnum modalidadFormacion
	String titulo
	String validezTitulo
	String perfilEgresado
	String campoOcupacional
	
	
	
	static hasMany= [requisitos:Requisito,niveles:Nivel,anios:AnioLectivo, documentos:DocumentoCarrera, preinscripciones:Inscripcion]
	
    static constraints = {
		denominacion(nullable:false,blank:false,size:1..36)
		campoOcupacional(nullable:false,blank:false,size:1..35)
    }
	
	static mapping = {
		niveles sort : 'descripcion'
		niveles lazy: false

	}
}
