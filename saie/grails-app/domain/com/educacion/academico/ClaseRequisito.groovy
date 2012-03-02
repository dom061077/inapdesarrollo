package com.educacion.academico

class ClaseRequisito {
	String descripcion
	
    static constraints = {
		descripcion(nullable:false,blank:false,size:1..20)
    }
}
