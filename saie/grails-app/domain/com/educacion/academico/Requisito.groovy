package com.educacion.academico

class Requisito {
	String codigo
	ClaseRequisito claseRequisito
	String descripcion
	boolean estado=false
	
	static hasMany= [subRequisitos:Requisito]
	
	
	
    static constraints = {
		codigo(nullable:false,blank:false)
		descripcion(nullable:false,blank:false)
		claseRequisito(nullable:false,blank:false)
    }
}
