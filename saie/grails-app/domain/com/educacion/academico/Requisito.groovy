package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum

class Requisito {
	ClaseRequisito claseRequisito
	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	
	static hasMany = [subRequisitos:SubRequisito]
	
	
    static constraints = {
		descripcion(nullable:false,blank:false)
		claseRequisito(nullable:false,blank:false)
    }
	
	static mapping= {
		claseRequisito(lazy:false)
	}
	
}
