package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum;

class SubRequisito {

	String codigo
	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	
	static belongsTo=[requisito:Requisito]

	
    static constraints = {
		codigo(nullable:false,blank:false)
		descripcion(nullable:false,blank:false)

    }
}
