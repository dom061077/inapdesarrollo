package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum

class InscripcionMateria extends Inscripcion{
	EstadoInscripcionMateriaEnum estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_CREADA
	InscripcionMatricula inscripcionMatricula
	OrigenInscripcionMateriaEnum origen 
	
	static hasMany = [detalleMateria:InscripcionMateriaDetalle]
	
	static belongsTo = [inscripcionMatricula:InscripcionMatricula]
	
    static constraints = {
		inscripcionMatricula(nullable:false,blank:false)
		detalleMateria validator : {val,obj ->
			it?.every{
				it?.validate()
			}
			if(!obj.detalleMateria)
				return ["size.error"]

		} 
		
		
    }
	
	static mapping = {
		detalleMateria(lazy:false)
	}
}
