package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateria;
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateria

class InscripcionMateriaDetalle {
	Materia materia
	EstadoInscripcionMateriaEnum estado
	TipoInscripcionMateria tipo
	Integer nota

	InscripcionMateria inscripcionMateria
	
	static belongsTo = [inscripcionMateria:InscripcionMateria]
	
    static constraints = {
    }
}
