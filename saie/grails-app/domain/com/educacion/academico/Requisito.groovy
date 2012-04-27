package com.educacion.academico

import com.educacion.enums.EstadoRequisitoEnum

class Requisito {
	ClaseRequisito claseRequisito
	String descripcion
	EstadoRequisitoEnum estado=EstadoRequisitoEnum.ESTADOREQUISITO_ACTIVO
	
	static hasMany = [subRequisitos:SubRequisito,carreras:Carrera]
	
	static belongsTo = [Carrera]
	
	
    static constraints = {
		descripcion(nullable:false,blank:false,size:1..35)
		claseRequisito(nullable:false,blank:false)
    }
	
	static mapping= {
		claseRequisito(lazy:false)
	}
	
}
