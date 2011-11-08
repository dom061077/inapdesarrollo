package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum

class Requisito {
	String codigo
	ClaseRequisito claseRequisito
	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	
	static hasMany= [subRequisitos:Requisito]
	
	
	
    static constraints = {
		codigo(nullable:false,blank:false)
		descripcion(nullable:false,blank:false)
		claseRequisito(nullable:false,blank:false)
    }
}
