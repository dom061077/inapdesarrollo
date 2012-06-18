package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum

class InscripcionMateria extends Inscripcion{
	
	EstadoInscripcionMateriaEnum estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_ACTIVA
	InscripcionMatricula inscripcionMatricula
	OrigenInscripcionMateriaEnum origen 
	
	static hasMany = [detalleMateria:InscripcionMateriaDetalle]
	
	static belongsTo = [inscripcionMatricula:InscripcionMatricula]
	
    static constraints = {
		inscripcionMatricula(nullable:true,blank:true)
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
