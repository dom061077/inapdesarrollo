package com.educacion.academico

import com.educacion.enums.inscripcion.TipoInscripcionMateria;
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateria

class InscripcionMateriaDetalle {
	Materia materia
	EstadoInscripcionMateriaDetalleEnum estado = EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
	TipoInscripcionMateria tipo
	Float nota = new Float(0)

	InscripcionMateria inscripcionMateria
	
	static belongsTo = [inscripcionMateria:InscripcionMateria]
	
    static constraints = {
		materia(unique:'inscripcionMateria')
		
    }
}
