package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum

class Requisito {
	ClaseRequisito claseRequisito
	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	Inscripcion inscripcion
	
	static hasMany = [subRequisitos:SubRequisito]
	static belongsTo = [inscripcion:Inscripcion] 
	
	
    static constraints = {
		descripcion(nullable:false,blank:false)
		claseRequisito(nullable:false,blank:false)
    }
}
