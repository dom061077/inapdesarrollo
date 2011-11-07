package com.educacion.academico

class ClaseRequisito {
	String codigo
	String descripcion
	
    static constraints = {
		codigo(nullable:false,blank:false,unique:true)
		descripcion(nullable:false,blank:false)
    }
}
