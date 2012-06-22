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
		denominacion(nullable:false,blank:false,size:1..100)
		campoOcupacional(nullable:false,blank:false,size:1..250)
		anios validator: {
			it?.every{ it?.validate()}
		}
    }
	
	static mapping = {
		niveles sort : 'descripcion'
		niveles lazy: false

	}
}
