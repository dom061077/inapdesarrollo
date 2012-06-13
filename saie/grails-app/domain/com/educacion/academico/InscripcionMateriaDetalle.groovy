package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum

class InscripcionMateriaDetalle {
	Materia materia
	EstadoInscripcionMateriaDetalleEnum estado = EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
	TipoInscripcionMateriaEnum tipo
	Float nota = new Float(0)

	InscripcionMateria inscripcionMateria
	
	static belongsTo = [inscripcionMateria:InscripcionMateria]
	
    static constraints = {
		materia(unique:'inscripcionMateria')
		
    }
	
}
