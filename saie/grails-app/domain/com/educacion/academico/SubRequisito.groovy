package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum;

class SubRequisito {

	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	
	static belongsTo=[requisito:Requisito]

	
    static constraints = {
		descripcion(nullable:false,blank:false,size:1..250)

    }
	
	static mapping = {
		
	}
}
