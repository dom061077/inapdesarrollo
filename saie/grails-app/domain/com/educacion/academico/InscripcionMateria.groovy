package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum


class InscripcionMateria extends Inscripcion{
	
	EstadoInscripcionMateriaEnum estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_ACTIVA
	InscripcionMatricula inscripcionMatricula 
	
	static hasMany = [detalleMateria:InscripcionMateriaDetalle]
	
	static belongsTo = [inscripcionMatricula:InscripcionMatricula]
	
    static constraints = {
		preinscripcion(nullable:true,blank:true)
		detalleMateria validator : {
			it?.every{
				it?.validate()
			}
		} 
    }
	
	static mapping = {
		detalleMateria(lazy:false)
	}
}
