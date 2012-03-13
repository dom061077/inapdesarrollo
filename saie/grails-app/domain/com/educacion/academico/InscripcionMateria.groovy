package com.educacion.academico


class InscripcionMateria extends Inscripcion{
	
	Preinscripcion preinscripcion
	static hasMany = [detalleMateria:InscripcionMateriaDetalle]
	
    static constraints = {
		preinscripcion(nullable:true,blank:true)
    }
}
