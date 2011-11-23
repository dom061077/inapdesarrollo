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
	
	
	static hasMany= [requisitos:Requisito,niveles:Nivel,anios:AnioLectivo]
	
    static constraints = {
    }
}
