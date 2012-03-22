package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum


class InscripcionMateria extends Inscripcion{
	
	Preinscripcion preinscripcion
	EstadoInscripcionMateriaEnum estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_ACTIVA 
	
	static hasMany = [detalleMateria:InscripcionMateriaDetalle]
	
    static constraints = {
		preinscripcion(nullable:true,blank:true)
		detalleMateria validator : {
			it?.every{it?.validate()}
		} 
    }
	
	static mapping = {
		detalleMateria(lazy:false)
	}
}
